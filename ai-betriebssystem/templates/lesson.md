# Lesson Template

Eine Lesson dokumentiert einen realen Loop und entscheidet, ob der Harness angepasst wird. Eine Lesson ohne Regelanpassungs-Entscheidung ist unvollständig — "keine Anpassung noetig" ist eine gueltige Entscheidung, aber sie muss ausgesprochen werden.

Ablage: `lessons/<nummer>-<repo>-<kurztitel>.md`

---

# Lesson: <Titel>

## Datum

YYYY-MM-DD

## Repo

`OWNER/REPO`

## Ticket und PR

- Issue: `OWNER/REPO#N`
- PR: `OWNER/REPO#N`

## Ergebnis

Was ist in diesem Loop passiert? Kurzer Ablauf in nummerierten Schritten, inklusive Ampel-Verlauf (z. B. NEEDS-FIX → PASS/Gelb → Merge).

## Was gut funktioniert hat

- ...

## Was gerieben hat

- ...

## Harness Failure Classification

Beobachtete Klassifikationen in diesem Loop (aus dem Closeout, nicht neu erfunden):

- none | missing_context | stale_context | missing_tool | missing_verifier | weak_guardrail | unclear_spec | model_limitation

## Wichtigstes Learning

Ein Satz, der auch ohne den Rest der Lesson verstaendlich ist.

## Regelanpassung

Pflichtblock. Genau eine der beiden Varianten:

**Variante A — Anpassung noetig:**

- Betroffenes Artefakt: `contracts/...` | `prompts/...` | `templates/...` | `docs/...` | `skills/...`
- Was muss sich ändern:
- Umsetzung: Issue erstellt (`OWNER/REPO#N`) | direkt als PR umgesetzt (`OWNER/REPO#N`)

**Variante B — Keine Anpassung noetig:**

- Warum der bestehende Harness dieses Muster bereits abdeckt:

## Naechste Anwendung

Wo wird dieses Learning als nächstes bewusst angewendet oder überprüft?
