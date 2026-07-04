import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(__file__))

from pr_contract_check import check

GOOD_BODY = """# Summary

## Validation Evidence

- tests passed

## Review of Record

- Status: PASS

## Human Gate

- Required: no
- Reason: low risk

## Operator Summary

- ready

## Review Recommendation

- none

## Vault Impact

- Vault update required: NO
- Area:
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:
"""

RAW_BODY = """# Summary

## Validation Evidence

- 

## Review of Record

- Status: pending
- Reviewer:
- Link:

## Human Gate

- Required: yes/no
- Reason:

## Operator Summary

## Review Recommendation

## Vault Impact

- Vault update required: YES | NO
- Area:
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:
"""

VAULT_IMPACT_YES_BODY = GOOD_BODY.replace(
    """- Vault update required: NO
- Area:
- Reason:
- Suggested target file:
- Proposed Markdown update:
- Source evidence:""",
    """- Vault update required: YES
- Area: Decision
- Reason: captured a durable decision
- Suggested target file: ai-vault/02_Projects/Demo/Entscheidungen.md
- Proposed Markdown update: Add decision note.
- Source evidence: test evidence""",
)


class PrContractCheckTests(unittest.TestCase):
    def test_valid_body_and_labels_pass(self):
        self.assertEqual(check(GOOD_BODY, ["review:pass"]), [])

    def test_missing_sections_fail(self):
        failures = check("# Summary", [])
        self.assertTrue(any("Validation Evidence" in item for item in failures))

    def test_raw_template_fails(self):
        failures = check(RAW_BODY, [])
        self.assertTrue(any("empty section" in item for item in failures))
        self.assertTrue(any("Human Gate" in item for item in failures))

    def test_auto_merge_requires_review_pass(self):
        failures = check(GOOD_BODY, ["auto-merge:ok"])
        self.assertIn("auto-merge:ok requires review:pass", failures)

    def test_auto_merge_conflicts_with_stop_labels(self):
        for label in ["needs-human", "needs-fix", "blocked"]:
            with self.subTest(label=label):
                failures = check(GOOD_BODY, ["auto-merge:ok", "review:pass", label])
                self.assertTrue(any(label in item for item in failures))

    def test_auto_merge_conflicts_with_protected_risk(self):
        for label in ["risk:protected", "risk:release"]:
            with self.subTest(label=label):
                failures = check(GOOD_BODY, ["auto-merge:ok", "review:pass", label])
                self.assertTrue(any(label in item for item in failures))

    def test_review_pass_conflicts_with_needs_fix(self):
        failures = check(GOOD_BODY, ["review:pass", "needs-fix"])
        self.assertIn("review:pass conflicts with needs-fix", failures)

    def test_auto_merge_conflicts_with_required_human_gate(self):
        body = GOOD_BODY.replace("Required: no", "Required: yes")
        failures = check(body, ["auto-merge:ok", "review:pass"])
        self.assertTrue(any("Human Gate" in item for item in failures))

    def test_unknown_labels_are_ignored(self):
        self.assertEqual(check(GOOD_BODY, ["review:pass", "custom:label"]), [])

    def test_vault_impact_yes_with_required_fields_passes(self):
        self.assertEqual(check(VAULT_IMPACT_YES_BODY, ["review:pass"]), [])

    def test_vault_impact_yes_requires_reason(self):
        body = VAULT_IMPACT_YES_BODY.replace(
            "- Reason: captured a durable decision",
            "- Reason:",
        )
        failures = check(body, ["review:pass"])
        self.assertIn("Vault Impact requires Reason when update is YES", failures)

    def test_vault_impact_no_allows_empty_detail_fields(self):
        self.assertEqual(check(GOOD_BODY, ["review:pass"]), [])

    def test_vault_impact_raw_template_fails(self):
        failures = check(RAW_BODY, [])
        self.assertIn(
            "Vault Impact must say Vault update required: YES or NO",
            failures,
        )

    def test_missing_vault_impact_section_fails(self):
        body = GOOD_BODY.split("## Vault Impact")[0]
        failures = check(body, ["review:pass"])
        self.assertIn("missing section: ## Vault Impact", failures)


if __name__ == "__main__":
    unittest.main()
