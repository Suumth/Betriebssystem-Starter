# Legacy Notes: AI-Betriebssystem 1.0

## Status

Die alte Runner-/Dashboard-/Orchestrator-Architektur ist verworfen und gehört nicht in den MVP von AI-Betriebssystem 2.0.

## Nicht übernehmen

- Local Morning Runner
- GitHub Actions Dispatch-Runner
- cron oder launchd
- Multi-Repo-Scanner
- Dashboard als operative Oberfläche
- Auto-Merge-Pipeline
- lange Statusmodelle
- viele Subagenten
- lokale Run-Registry als Source of Truth

## Wiederverwendbar

Nur methodische Muster dürfen übernommen werden:

- gute Ticket-Struktur
- klare Closeouts
- Evidence-Muster
- Review-Schärfe
- Entscheidungsvorlagen

## Grund für die Änderung

Die Apps bringen viele Ausführungsfunktionen bereits mit. Der Engpass ist nicht ein weiterer Runner, sondern reife Tickets, GitHub als operative Wahrheit und ein einfacher Build-Review-Fix-Loop.

## Regel

Legacy-Ideen werden nur übernommen, wenn sie den neuen Kernsatz stärken:

> GitHub hält den Kontext, die Apps führen aus, Tickets beweisen ihre eigene Reife, und der Mensch entscheidet nur noch über Ampeln.
