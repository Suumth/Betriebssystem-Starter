# Worker Order Template

Kopiervorlage fuer den Auftrags-Kommentar des Epic Leads in einem
Worker-Ticket nach `contracts/epic-lead-contract.md`.

Ein Worker Order ergaenzt ein reifes Ticket, er ersetzt es nicht. Der Order
wiederholt Ticket-Inhalte fuer den Worker-Start; er darf sie nicht aendern.
Weicht der Order vom Ticket ab, gilt das Ticket, und die Abweichung wird im
naechsten Heartbeat als Lead-Fehler dokumentiert.

---

```markdown
## Worker Order (Epic Lead)

Epic: #<Epic-Issue> / Milestone <Name>
Worker-ID: W<n>
Ticket: #<Issue> (agent:ready, Plan Issue #<M>, Wave <n>)
Branch: agent/<issue-number>-<short-title>

### Auftrag

Goal: <ein Satz, aus dem Ticket uebernommen, nicht neu erfunden>
Scope-Erinnerung: <Boundary-Kurzfassung plus haertestes Do-not-touch>
Kontext-Paket:
- <3-6 Datei-/Issue-/PR-Links, die der Worker zuerst liest>
Erwartetes Ergebnis: <PR mit welcher Evidence>

### Reasoning

Stufe: low | medium | high | highest available
Begruendung der Stufe: <ein Satz; Pflicht bei Abweichung von der
Default-Matrix in contracts/epic-lead-contract.md>

### Stop Conditions (zusaetzlich zum Ticket)

- Stopp bei Boundary-Kontakt mit Ticket #<x> (Parallel-Worker)
- Stopp nach Attempt Budget: self-fix max 1, needs-fix-Zyklen max 2
- <epic-spezifische Bedingung, falls vorhanden>

### Pflichten

Verifikation: <Befehl/Check aus dem Ticket, wiederholt>
Meldung: Closeout in den PR Body als Primary Closeout Source; bei
Blockade oder Abbruch Resume State ins Ticket.
```

---

## Regeln

- Ein Worker Order pro Worker-Start. Ein Ersatz-Worker (REPLACE) bekommt
  einen neuen Order mit Verweis auf den Resume State des Vorgaengers und
  denselben Branch/PR.
- Der Order setzt keine Labels und aendert keine Ticket-Felder. Der Worker
  folgt beim Start den Statusregeln aus `contracts/labels.md`.
- Kontext-Paket klein halten: Links statt kopierter Inhalte. Der PR Body
  und das Ticket bleiben die Wahrheit, nicht der Order.
- Bei Hoch- oder Runterstufung der Reasoning-Stufe im laufenden Epic wird
  ein neuer Order-Kommentar geschrieben; alte Orders werden nicht
  editiert.
