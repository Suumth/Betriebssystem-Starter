# Lesson: Sichtbare Koordinationsrollen

## Datum

2026-07-05

## Repo

`OWNER/REPO`

## Ticket und PR

- Issue: `OWNER/REPO#74`
- PR: dieser PR

## Ergebnis

1. Der Repository-Planner-/Epic-Lead-Pilot fuehrte sichtbare Rollen ein, die
   GitHub-Issues, Worker Orders, Heartbeats und PRs koordinieren.
2. Die vorhandene Grundregel gegen sichtbare Subagent-PM-Rollen musste
   praezisiert werden, damit erlaubte Koordination nicht mit versteckter
   Subagent-Orchestrierung verwechselt wird.
3. Die Worker-Wave dokumentierte Repository Planner und Epic Lead als
   contract-gebundene Rollen, ohne ihnen Builder-, Review- oder Merge-Rechte
   zu geben.

## Was gut funktioniert hat

- Die Rollen blieben ueber GitHub rekonstruierbar: Goal/Plan/Epic Issues,
  Worker Orders, PRs und Heartbeats bildeten die operative Wahrheit.
- Die Rollen hatten eigene Contracts und klare Grenzen.
- Human Gates, Review of Record und Merge-Entscheidung blieben beim Operator
  beziehungsweise beim dafuer vorgesehenen Review-Prozess.

## Was gerieben hat

- Die alte Kurzregel "keine sichtbaren Subagent-PM-Rollen / kein
  Subagenten-Organigramm" war zu grob fuer sichtbare, contract-gebundene
  Koordinationsrollen.
- Ohne Praezisierung konnte "keine Subagent-PM-Rolle" faelschlich als Verbot
  jeder sichtbaren Koordination gelesen werden.

## Harness Failure Classification

- unclear_spec

## Wichtigstes Learning

Sichtbare Koordinationsrollen sind erlaubt, wenn sie GitHub-rekonstruierbar,
contract-gebunden, nicht implementierend, nicht reviewend, nicht mergend und
ohne Human-Gate-Verschiebung arbeiten.

## Regelanpassung

**Variante A - Anpassung noetig:**

- Betroffenes Artefakt: `docs/operating-model.md`, `docs/glossary.md`,
  `contracts/planner-contract.md`, `contracts/epic-lead-contract.md`
- Was muss sich aendern: Die Methode braucht die explizite Unterscheidung
  zwischen erlaubten sichtbaren Koordinationsrollen und weiterhin verbotenen
  internen Subagent-PM-Rollen.
- Umsetzung: direkt als PR umgesetzt; diese Lesson haelt die Entscheidung
  nach der Pilot-Wave fest.

Unveraendert verboten bleiben:

- interne Subagents mit PM-Rolle oder Label-Rechten;
- versteckte Orchestrierung ausserhalb von GitHub;
- Koordinationsrollen ohne eigenen Contract;
- Koordination, die Implementierung, Review of Record, Merge oder Human Gate
  uebernimmt oder verschiebt.

Repository Planner und Epic Lead sind erlaubte sichtbare Koordinationsrollen,
weil ihre Arbeit ueber GitHub-Artefakte nachvollziehbar ist und ihre Contracts
die verbotenen Aktionen ausdruecklich ausschliessen.

## Naechste Anwendung

Kuenftige Plan-Issues, Worker-Waves und Lessons pruefen diese Unterscheidung:
Eine neue Koordinationsrolle ist nur zulaessig, wenn sie denselben
Rekonstruktions-, Contract- und Human-Gate-Grenzen folgt.
