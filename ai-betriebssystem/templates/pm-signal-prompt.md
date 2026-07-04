# PM Signal Prompt

```text
Erstelle einen PM Signal Lauf fuer OWNER/REPO.

Nutze ausschliesslich GitHub und Repo-Kontext:
Issues, PRs, Labels, Commits, AGENTS.md, docs/pm/*.md, docs/adr/*.md.

Lies nicht den AI Vault als operative Wahrheit.

Ziel:
Verdichte den Projektstand so, dass der Operator erkennt:
- Wo stehen die Teilprojekte?
- Was wurde seit dem letzten Signal geliefert?
- Was ist blockiert?
- Welche Risiken wachsen?
- Welche Entscheidungen sind als Naechstes noetig?
- Welche Tickets oder Contract Updates sollten angelegt werden?

Arbeite nach Trigger -> Action -> Proof -> Memory -> Stop.

Output:
1. Overall Status: Green | Yellow | Red
2. Teilprojekt-Tabelle mit Status, Fortschritt, Blocker, Risiko, naechster Entscheidung
3. Delivered Since Last Signal
4. Open Risks
5. Critical Missing Pieces
6. Next Operator Decisions
7. Suggested Issues / Updates
8. Confidence / Missing Evidence

Regeln:
- Keine zweite Roadmap neben GitHub erfinden.
- Unklare Punkte als Fragen oder suggested issues ausgeben.
- Keine erledigte Arbeit behaupten ohne Issue, PR, Commit oder Closeout.
- Keine neuen Regeln automatisch setzen; Contract-/Template-Updates nur vorschlagen.
- Neue Arbeit als GitHub Issue vorschlagen oder, wenn ausdruecklich erlaubt, anlegen.
- Harte Entscheidungen als Decision Log oder ADR vorschlagen.
```
