# Repo Context Pack

## Zweck

Der Repo Context Pack ist ein lokaler technischer Lesekontext für Agents. Er buendelt Repo-Dateien in ein agentenlesbares Artefakt, damit ein Agent schneller navigieren und relevante Dateien finden kann.

Repomix ist dafür der empfohlene API-freie Baustein.

## Warum nicht OpenWiki

OpenWiki wurde geprüft und für dieses Methoden-Repo verworfen, weil non-interactive Runs einen `OPENROUTER_API_KEY` voraussetzen. Das widerspricht der Zielarchitektur:

- App-first
- keine zusaetzliche metered API-Abhaengigkeit
- keine neuen Provider-Credentials
- GitHub als operative Wahrheit
- keine zweite operative Dokumentationsschicht

## Rolle von Repomix

Repomix erzeugt lokal ein technisches Kontextartefakt. Es ist:

- API-frei
- ohne externen Provider nutzbar
- ein optionaler Lesekontext für Agents
- kein Ersatz für Issue, PR, `AGENTS.md`, Contracts oder relevante Quelldateien
- keine operative Wahrheit

Generierte Artefakte werden nicht committed. `.ai-os/context/` und `repomix-output.*` bleiben lokale Arbeitsartefakte.

## Lesereihenfolge

Agents lesen weiterhin in dieser Reihenfolge:

1. GitHub Issue oder konkrete Task Anweisung
2. `AGENTS.md` oder `CLAUDE.md`, falls im Repo vorhanden
3. optional Repo Context Pack
4. relevante Quelldateien und Dokumente

Der Repo Context Pack darf die Auswahl relevanter Dateien beschleunigen. Er ersetzt nicht die Ticket-Boundary, die Validation oder die Evidence-Pflichten.

## Standardbefehl

```bash
mkdir -p .ai-os/context
npx repomix@latest --output .ai-os/context/repo-context.xml
```

## Ignore-Regeln

`.gitignore` verhindert, dass lokale Context-Pack-Artefakte committed werden:

```gitignore
.ai-os/context/
repomix-output.*
```

`.repomixignore` schliesst technische Artefakte, Logs, Build-Verzeichnisse, Runs und Secrets aus dem Context Pack aus.

## Sicherheitsgrenze

Der Repo Context Pack darf keine Secrets, `.env`-Dateien, Logs, Build-Ausgaben oder bereits generierte Context Packs enthalten. Wenn ein Repo zusaetzliche sensible Pfade hat, müssen sie in `.repomixignore` ergänzt werden, bevor Repomix ausgefuehrt wird.
