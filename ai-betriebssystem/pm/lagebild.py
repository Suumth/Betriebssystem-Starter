#!/usr/bin/env python3
"""Generate a read-only PM portfolio status report from GitHub and PROJECT.md."""

from __future__ import annotations

import argparse
import base64
import dataclasses
import datetime as dt
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Any


DEFAULT_REPOS = ("<OWNER>/<REPO>",)
OUTPUT_PATH = Path("pm/portfolio.md")
HUMAN_GATE_LABELS = {"needs-human", "blocked", "needs-fix"}
REVIEW_EVIDENCE_PATTERN = re.compile(
    r"\b(?:review\s+of\s+record\s*:\s*pass|review-pass)\b",
    flags=re.IGNORECASE,
)
MUTATING_GH_COMMANDS = {
    ("issue", "edit"),
    ("issue", "close"),
    ("issue", "reopen"),
    ("pr", "edit"),
    ("pr", "close"),
    ("pr", "merge"),
    ("pr", "ready"),
    ("label", "create"),
    ("label", "delete"),
    ("milestone", "create"),
    ("milestone", "edit"),
    ("milestone", "delete"),
}
MUTATING_API_METHODS = {"PATCH", "POST", "PUT", "DELETE"}


@dataclasses.dataclass(frozen=True)
class Promise:
    milestone: str
    text: str
    status: str
    evidence_url: str
    phase_critical: bool


@dataclasses.dataclass(frozen=True)
class ProjectRegister:
    phase: str
    target_picture: str
    promises: list[Promise]


@dataclasses.dataclass(frozen=True)
class Issue:
    number: int
    title: str
    state: str
    url: str
    labels: list[str]
    milestone: str | None
    closed_at: str | None = None


@dataclasses.dataclass(frozen=True)
class PullRequest:
    number: int
    title: str
    state: str
    url: str
    body: str
    labels: list[str]
    merged_at: str | None = None
    review_evidence_texts: list[str] = dataclasses.field(default_factory=list)


@dataclasses.dataclass(frozen=True)
class Milestone:
    title: str
    state: str
    url: str
    open_issues: int
    closed_issues: int


@dataclasses.dataclass(frozen=True)
class ProjectSnapshot:
    repo: str
    repo_url: str
    phase: str
    target_picture: str
    milestones: list[Milestone]
    issues: list[Issue]
    pull_requests: list[PullRequest]
    project_md_found: bool
    promises: list[Promise]


def normalize_label(label: Any) -> str:
    if isinstance(label, dict):
        return str(label.get("name", "")).strip()
    return str(label).strip()


def normalize_milestone(milestone: Any) -> str | None:
    if not milestone:
        return None
    if isinstance(milestone, dict):
        title = milestone.get("title")
        return str(title).strip() if title else None
    return str(milestone).strip()


def parse_project_register(markdown: str | None) -> ProjectRegister:
    if not markdown:
        return ProjectRegister(phase="", target_picture="", promises=[])

    phase = ""
    target_picture = ""
    promises: list[Promise] = []
    in_register = False

    for raw_line in markdown.splitlines():
        line = raw_line.strip()
        if not line:
            continue
        lower = line.lower()
        if lower.startswith("phase:"):
            phase = line.split(":", 1)[1].strip()
        elif lower.startswith("zielbild:") or lower.startswith("target picture:"):
            target_picture = line.split(":", 1)[1].strip()
        elif line.startswith("## "):
            in_register = "teilprojekte" in lower and "produktversprechen" in lower
        elif in_register and line.startswith("|"):
            cells = [cell.strip() for cell in line.strip("|").split("|")]
            if len(cells) < 5:
                continue
            first_cell = cells[0].lower()
            if first_cell.startswith("---") or "teilprojekt" in first_cell:
                continue
            promises.append(
                Promise(
                    milestone=cells[0],
                    text=cells[1],
                    status=cells[2],
                    evidence_url=cells[3],
                    phase_critical=cells[4].lower() == "ja",
                )
            )

    return ProjectRegister(phase=phase, target_picture=target_picture, promises=promises)


def assert_read_only_gh_args(args: list[str]) -> None:
    if not args or args[0] != "gh":
        raise ValueError("expected gh command")

    if len(args) >= 3 and (args[1], args[2]) in MUTATING_GH_COMMANDS:
        raise ValueError(f"mutating gh command rejected: {' '.join(args[:3])}")

    if len(args) >= 2 and args[1] == "api":
        for index, arg_value in enumerate(args):
            if arg_value == "-X" and index + 1 < len(args):
                method = args[index + 1].upper()
                if method in MUTATING_API_METHODS:
                    raise ValueError(f"mutating gh api method rejected: {method}")
            if arg_value == "--method" and index + 1 < len(args):
                method = args[index + 1].upper()
                if method in MUTATING_API_METHODS:
                    raise ValueError(f"mutating gh api method rejected: {method}")


def run_gh_json(args: list[str]) -> Any:
    assert_read_only_gh_args(args)
    completed = subprocess.run(
        args,
        check=True,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    output = completed.stdout.strip()
    if not output:
        return None
    return json.loads(output)


def fetch_project_md(repo: str) -> str | None:
    try:
        data = run_gh_json(["gh", "api", f"repos/{repo}/contents/PROJECT.md"])
    except subprocess.CalledProcessError:
        return None
    if not isinstance(data, dict) or data.get("encoding") != "base64":
        return None
    content = str(data.get("content", ""))
    return base64.b64decode(content).decode("utf-8")


def fetch_issues(repo: str) -> list[Issue]:
    data = run_gh_json(
        [
            "gh",
            "issue",
            "list",
            "--repo",
            repo,
            "--state",
            "all",
            "--limit",
            "1000",
            "--json",
            "number,title,state,labels,milestone,url,closedAt",
        ]
    )
    return [
        Issue(
            number=int(item["number"]),
            title=str(item["title"]),
            state=str(item["state"]),
            url=str(item["url"]),
            labels=sorted(filter(None, (normalize_label(label) for label in item.get("labels", [])))),
            milestone=normalize_milestone(item.get("milestone")),
            closed_at=item.get("closedAt"),
        )
        for item in sorted(data or [], key=lambda row: int(row["number"]))
    ]


def fetch_pull_requests(repo: str) -> list[PullRequest]:
    data = run_gh_json(
        [
            "gh",
            "pr",
            "list",
            "--repo",
            repo,
            "--state",
            "all",
            "--limit",
            "1000",
            "--json",
            "number,title,state,url,body,labels,mergedAt",
        ]
    )
    pull_requests: list[PullRequest] = []
    for item in sorted(data or [], key=lambda row: int(row["number"])):
        number = int(item["number"])
        pull_requests.append(
            PullRequest(
                number=number,
                title=str(item["title"]),
                state=str(item["state"]),
                url=str(item["url"]),
                body=str(item.get("body") or ""),
                labels=sorted(filter(None, (normalize_label(label) for label in item.get("labels", [])))),
                merged_at=item.get("mergedAt"),
                review_evidence_texts=fetch_pr_review_evidence(repo, number),
            )
        )
    return pull_requests


def collect_bodies(items: Any) -> list[str]:
    if not isinstance(items, list):
        return []
    bodies: list[str] = []
    for item in items:
        if not isinstance(item, dict):
            continue
        body = item.get("body")
        if body:
            bodies.append(str(body))
    return bodies


def fetch_pr_review_evidence(repo: str, number: int) -> list[str]:
    evidence_texts: list[str] = []
    try:
        data = run_gh_json(
            [
                "gh",
                "pr",
                "view",
                str(number),
                "--repo",
                repo,
                "--json",
                "comments,reviews",
            ]
        )
    except (subprocess.CalledProcessError, json.JSONDecodeError):
        data = None
    if isinstance(data, dict):
        evidence_texts.extend(collect_bodies(data.get("comments")))
        evidence_texts.extend(collect_bodies(data.get("reviews")))

    try:
        data = run_gh_json(["gh", "api", f"repos/{repo}/pulls/{number}/comments?per_page=100"])
    except (subprocess.CalledProcessError, json.JSONDecodeError):
        data = None
    evidence_texts.extend(collect_bodies(data))

    return sorted(set(filter(None, evidence_texts)))


def has_review_of_record_evidence(pr: PullRequest) -> bool:
    labels = {label.lower() for label in pr.labels}
    if "review:pass" in labels:
        return True
    if REVIEW_EVIDENCE_PATTERN.search(pr.body):
        return True
    return any(REVIEW_EVIDENCE_PATTERN.search(text) for text in pr.review_evidence_texts)


def fetch_milestones(repo: str) -> list[Milestone]:
    data = run_gh_json(["gh", "api", f"repos/{repo}/milestones?state=all&per_page=100"])
    return [
        Milestone(
            title=str(item["title"]),
            state=str(item["state"]),
            url=str(item.get("html_url", "")),
            open_issues=int(item.get("open_issues", 0)),
            closed_issues=int(item.get("closed_issues", 0)),
        )
        for item in sorted(data or [], key=lambda row: str(row.get("title", "")).lower())
    ]


def fetch_project_snapshot(repo: str) -> ProjectSnapshot:
    project_md = fetch_project_md(repo)
    register = parse_project_register(project_md)
    return ProjectSnapshot(
        repo=repo,
        repo_url=f"https://github.com/{repo}",
        phase=register.phase,
        target_picture=register.target_picture,
        milestones=fetch_milestones(repo),
        issues=fetch_issues(repo),
        pull_requests=fetch_pull_requests(repo),
        project_md_found=project_md is not None,
        promises=register.promises,
    )


def linked_issue_numbers(pr: PullRequest) -> set[int]:
    return {
        int(match)
        for match in re.findall(
            r"\b(?:close[sd]?|fix(?:e[sd])?|resolve[sd]?)\s+#(\d+)\b",
            pr.body,
            flags=re.IGNORECASE,
        )
    }


def merged_pr_by_issue(pull_requests: list[PullRequest]) -> dict[int, PullRequest]:
    links: dict[int, PullRequest] = {}
    for pr in pull_requests:
        if pr.state.upper() != "MERGED":
            continue
        for issue_number in linked_issue_numbers(pr):
            links.setdefault(issue_number, pr)
    return links


def open_pr_by_issue(pull_requests: list[PullRequest]) -> dict[int, PullRequest]:
    links: dict[int, PullRequest] = {}
    for pr in pull_requests:
        if pr.state.upper() != "OPEN":
            continue
        for issue_number in linked_issue_numbers(pr):
            links.setdefault(issue_number, pr)
    return links


def link(label: str, url: str) -> str:
    return f"[{label}]({url})" if url else label


def issue_link(issue: Issue) -> str:
    return link(f"#{issue.number} {issue.title}", issue.url)


def pr_link(pr: PullRequest) -> str:
    return link(f"PR #{pr.number} {pr.title}", pr.url)


def milestone_issues(snapshot: ProjectSnapshot, milestone_title: str) -> list[Issue]:
    return [issue for issue in snapshot.issues if issue.milestone == milestone_title]


def milestone_promises(snapshot: ProjectSnapshot, milestone_title: str) -> list[Promise]:
    return [promise for promise in snapshot.promises if promise.milestone == milestone_title]


def human_gate_issues(issues: list[Issue]) -> list[Issue]:
    return [issue for issue in issues if HUMAN_GATE_LABELS.intersection(issue.labels)]


def milestone_state(snapshot: ProjectSnapshot, milestone: Milestone) -> tuple[str, str, str]:
    issues = milestone_issues(snapshot, milestone.title)
    promises = milestone_promises(snapshot, milestone.title)
    merged_links = merged_pr_by_issue(snapshot.pull_requests)
    open_links = open_pr_by_issue(snapshot.pull_requests)
    phase = snapshot.phase.lower()

    if any("blocked" in issue.labels for issue in issues):
        issue = next(issue for issue in issues if "blocked" in issue.labels)
        return "blockiert", "Rot", issue_link(issue)
    if any(
        promise.phase_critical and promise.status == "offen" and phase in {"beta", "release"}
        for promise in promises
    ):
        promise = next(
            promise
            for promise in promises
            if promise.phase_critical and promise.status == "offen" and phase in {"beta", "release"}
        )
        return "blockiert", "Rot", promise.evidence_url or "phasenkritisches offenes Versprechen"
    if any(HUMAN_GATE_LABELS.intersection(issue.labels) for issue in issues):
        issue = next(issue for issue in issues if HUMAN_GATE_LABELS.intersection(issue.labels))
        return "Risiko offen", "Gelb", issue_link(issue)
    if any(issue.number in open_links for issue in issues):
        issue = next(issue for issue in issues if issue.number in open_links)
        return "in Review", "Gelb", pr_link(open_links[issue.number])
    if not snapshot.project_md_found:
        return "unklar", "Gelb", "PROJECT.md nicht gefunden"
    if not issues and not promises:
        return "unklar", "Gelb", link(milestone.title, milestone.url)
    closed_without_pr = [
        issue
        for issue in issues
        if issue.state.upper() == "CLOSED" and issue.number not in merged_links
    ]
    if closed_without_pr:
        return "Risiko offen", "Gelb", issue_link(closed_without_pr[0])
    if milestone.state == "closed" or (
        issues and all(issue.state.upper() == "CLOSED" for issue in issues)
    ):
        return "erledigt", "Gruen", link(milestone.title, milestone.url)
    return "offen", "Gruen", link(milestone.title, milestone.url)


def project_ampel(rows: list[tuple[Milestone, str, str, str]]) -> tuple[str, str]:
    if any(row[2] == "Rot" for row in rows):
        reason = next(row[3] for row in rows if row[2] == "Rot")
        return "Rot", reason
    if any(row[2] == "Gelb" for row in rows):
        reason = next(row[3] for row in rows if row[2] == "Gelb")
        return "Gelb", reason
    if rows:
        return "Gruen", rows[0][3]
    return "Gelb", "keine Milestones gefunden"


def render_portfolio(snapshots: list[ProjectSnapshot], generated_at: str | None = None) -> str:
    generated_at = generated_at or dt.datetime.now(dt.UTC).replace(microsecond=0).isoformat()
    lines = [
        "<!-- GENERATED by pm/lagebild.py; do not edit manually. -->",
        f"Generated at: {generated_at}",
        "",
        "# PM Portfolio Lagebild",
        "",
        "GitHub und PROJECT.md bleiben die operative Wahrheit. Dieses Lagebild ist nur eine read-only Ableitung.",
        "",
        "## Portfolio-Übersicht",
        "",
        "Keine Portfolio-Gesamtampel.",
        "",
        "| Projekt | Projekt-Ampel | Phase | Letzter Merge | Offene Human Gates | Projektsektion |",
        "|---|---|---|---|---|---|",
    ]

    rendered_projects: list[tuple[ProjectSnapshot, list[tuple[Milestone, str, str, str]], str, str]] = []
    for snapshot in sorted(snapshots, key=lambda item: item.repo.lower()):
        rows = [(milestone, *milestone_state(snapshot, milestone)) for milestone in snapshot.milestones]
        ampel, reason = project_ampel(rows)
        human_gates = human_gate_issues(snapshot.issues)
        merged = [pr for pr in snapshot.pull_requests if pr.state.upper() == "MERGED" and pr.merged_at]
        last_merge = max((pr.merged_at for pr in merged), default="unklar")
        section_anchor = snapshot.repo.lower().replace("/", "").replace("-", "-")
        lines.append(
            "| "
            + " | ".join(
                [
                    link(snapshot.repo, snapshot.repo_url),
                    f"{ampel}: {reason}",
                    snapshot.phase or "unklar",
                    last_merge,
                    str(len(human_gates)),
                    f"[Sektion](#{section_anchor})",
                ]
            )
            + " |"
        )
        rendered_projects.append((snapshot, rows, ampel, reason))

    for snapshot, rows, ampel, reason in rendered_projects:
        merged_links = merged_pr_by_issue(snapshot.pull_requests)
        open_links = open_pr_by_issue(snapshot.pull_requests)
        lines.extend(
            [
                "",
                f"## Projekt: {snapshot.repo}",
                "",
                f"- Repo: {link(snapshot.repo, snapshot.repo_url)}",
                f"- Phase: {snapshot.phase or 'unklar'}",
                f"- Zielbild: {snapshot.target_picture or 'unklar'}",
                f"- PROJECT.md: {'gefunden' if snapshot.project_md_found else 'nicht gefunden'}",
                f"- Projekt-Ampel: {ampel} durch {reason}",
                "",
                "### Teilprojekte",
                "",
                "| Teilprojekt | Zustand | Ampel | Begründung | Issues roh | Versprechen |",
                "|---|---|---|---|---|---|",
            ]
        )
        for milestone, state, row_ampel, row_reason in rows:
            issues = milestone_issues(snapshot, milestone.title)
            promises = milestone_promises(snapshot, milestone.title)
            closed_count = len([issue for issue in issues if issue.state.upper() == "CLOSED"])
            open_count = len([issue for issue in issues if issue.state.upper() != "CLOSED"])
            blocked_count = len([issue for issue in issues if "blocked" in issue.labels])
            promise_text = ", ".join(
                f"{promise.text} ({promise.status})" for promise in promises
            ) or "keine"
            lines.append(
                "| "
                + " | ".join(
                    [
                        link(milestone.title, milestone.url),
                        state,
                        row_ampel,
                        row_reason,
                        f"erledigt {closed_count}, offen {open_count}, blockiert {blocked_count}",
                        promise_text,
                    ]
                )
                + " |"
            )

        delivered = [
            (issue, merged_links[issue.number])
            for issue in snapshot.issues
            if issue.number in merged_links
        ]
        lines.extend(["", "### Delivered since last signal", ""])
        if delivered:
            for issue, pr in delivered:
                review = "Review of Record sichtbar" if has_review_of_record_evidence(pr) else "Review unklar"
                lines.append(f"- {issue_link(issue)} via {pr_link(pr)}; merged {pr.merged_at or 'unklar'}; {review}.")
        else:
            lines.append("- keine merged PR-Belege gefunden.")

        lines.extend(["", "### Offene Human Gates", ""])
        gates = human_gate_issues(snapshot.issues)
        if gates:
            for issue in gates:
                labels = ", ".join(issue.labels)
                lines.append(f"- {issue_link(issue)} mit Labels: {labels}.")
        else:
            lines.append("- keine offenen Human Gates gefunden.")

        lines.extend(["", "### Issues ohne Milestone", ""])
        missing_milestone = [issue for issue in snapshot.issues if not issue.milestone]
        if missing_milestone:
            for issue in missing_milestone:
                lines.append(f"- {issue_link(issue)} ({issue.state}).")
        else:
            lines.append("- keine gefunden.")

        lines.extend(["", "### Geschlossene Issues ohne merged PR-Beleg", ""])
        closed_without_pr = [
            issue
            for issue in snapshot.issues
            if issue.state.upper() == "CLOSED" and issue.number not in merged_links
        ]
        if closed_without_pr:
            for issue in closed_without_pr:
                lines.append(f"- {issue_link(issue)}.")
        else:
            lines.append("- keine gefunden.")

        lines.extend(["", "### Unklare Versprechen ohne Evidence-Link", ""])
        unclear_promises = [
            promise
            for promise in snapshot.promises
            if promise.status == "bestätigt" and not promise.evidence_url
        ] + [
            promise
            for promise in snapshot.promises
            if promise.phase_critical and promise.status == "offen" and not promise.evidence_url
        ]
        if unclear_promises:
            for promise in unclear_promises_sorted(unclear_promises):
                lines.append(f"- {promise.milestone}: {promise.text} ({promise.status}).")
        else:
            lines.append("- keine gefunden.")

        lines.extend(["", "### Offene PR-/Review-Bezüge", ""])
        if open_links:
            for issue_number, pr in sorted(open_links.items()):
                lines.append(f"- Issue #{issue_number}: {pr_link(pr)}.")
        else:
            lines.append("- keine offenen PR-Bezüge gefunden.")

    return "\n".join(lines) + "\n"


def unclear_promises_sorted(promises: list[Promise]) -> list[Promise]:
    return sorted(promises, key=lambda promise: (promise.milestone.lower(), promise.text.lower()))


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Generate a read-only PM portfolio Lagebild Markdown.")
    parser.add_argument(
        "--repo",
        action="append",
        dest="repos",
        help="Repository in owner/name form. Can be passed multiple times.",
    )
    parser.add_argument(
        "--output",
        default=str(OUTPUT_PATH),
        help="Output Markdown path. Defaults to pm/portfolio.md.",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv or sys.argv[1:])
    repos = tuple(args.repos or DEFAULT_REPOS)
    snapshots = [fetch_project_snapshot(repo) for repo in sorted(repos)]
    output = render_portfolio(snapshots)
    output_path = Path(args.output)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(output, encoding="utf-8")
    print(f"Wrote {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
