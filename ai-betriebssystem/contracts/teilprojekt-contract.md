# Teilprojekt Contract

Der Teilprojekt Contract definiert das PM-Lagebild für Projekt-Repos. Er
macht Teilprojekte und Produktversprechen sichtbar, ohne eine zweite operative
Wahrheit neben GitHub zu schaffen.

## Grundsatz

GitHub bleibt operative Wahrheit. Das Lagebild ist eine read-only Ableitung aus:

- GitHub Milestones;
- GitHub Issues, PRs, Labels, Reviews und Closeouts;
- dem Produktversprechen-Register in `PROJECT.md`.

Das Lagebild darf verdichten, verlinken und Ampeln ableiten. Es setzt keine
Stati, schreibt keine Labels, bestätigt keine Produktversprechen und ersetzt
keine Human-/Operator-Entscheidung.

## Teilprojekt-Modell

Ein Teilprojekt ist ein GitHub Milestone im jeweiligen Projekt-Repo.

Produktwirksame reife Tickets brauchen einen Milestone, wenn sie als
`agent:ready` in Umsetzung gehen. Produktwirksam ist ein Ticket, wenn sein
Ergebnis ein Nutzer-, Produkt-, Release-, Beta-, Surface-, Architektur- oder
Qualitätsversprechen berührt.

Tickets ohne Milestone sind erlaubt, wenn sie ausdrücklich nicht
teilprojektbezogen sind:

- repo-hygiene;
- meta;
- reine Dokumentation ohne Produktversprechen;
- Tooling ohne Teilprojektbezug;
- Methoden- oder Templatepflege ohne Produktartefakt.

Keine neuen `track:*`-, `status:*`- oder vergleichbaren Label-Parallelwelten.
Milestones modellieren Teilprojekte. Labels bleiben Workflow-, Review-,
Risiko- oder Agentensignale gemäß Label Contract.

## Versprechen-Register

Produktversprechen werden in `PROJECT.md` geführt. Tickets beweisen
Umsetzungsschritte, aber nicht automatisch Produktversprechen.

Das Register enthält je Produktversprechen:

- Teilprojekt / Milestone;
- Produktversprechen;
- Status: `offen` oder `bestätigt`;
- Evidence-Link;
- phasenkritisch: `ja` oder `nein`.

Statuswerte sind absichtlich knapp:

- `offen`: noch nicht durch Operator-/Human-Entscheidung bestätigt.
- `bestätigt`: durch Operator-/Human-Entscheidung per PR mit Evidence-Link
  bestätigt.

Eine Statusänderung von `offen` zu `bestätigt` darf nur durch
Operator-/Human-Entscheidung erfolgen. Sie braucht einen PR und einen
Evidence-Link auf die prüfbare Grundlage, etwa Issue, PR, Review, Closeout,
Test-/Build-Evidence, Screenshot oder Entscheidung.

Anti-Bloat-Leitplanken:

- maximal 7 Teilprojekte je Projekt;
- maximal 4 Produktversprechen je Teilprojekt.

Wenn ein Projekt mehr braucht, ist das ein Signal, das Lagebild zu schneiden
oder Teilprojekte zusammenzufassen, nicht mehr Statusmechanik einzuführen.

## Zustandslogik für Teilprojekte

Das Lagebild nutzt nur diese Zustände:

| Zustand | Bedeutung |
| --- | --- |
| `erledigt` | Milestone ist geschlossen oder alle produktwirksamen Issues sind geschlossen und haben Review-/PR-Evidence. |
| `in Review` | Es gibt offene oder kürzlich gelieferte Arbeit mit PR-/Review-Bezug, aber noch keine grüne Entscheidung. |
| `blockiert` | Mindestens ein relevantes Issue/PR ist `blocked` oder ein erforderlicher Human-/Operator-Entscheid fehlt. |
| `offen` | Es gibt offene produktwirksame Arbeit ohne rotes oder gelbes Gate. |
| `Risiko offen` | Es gibt offene Risiken, fehlende Evidence oder produktwirksame Unsicherheit ohne harten Blocker. |
| `unklar` | GitHub Milestone, Issue-Zuordnung, Evidence oder PROJECT-Register reichen nicht für eine belastbare Ableitung. |

Zustände werden aus GitHub und `PROJECT.md` abgeleitet. Sie werden nicht in
separate Dateien zurückgeschrieben.

## Ampel-Logik

Teilprojekt-Ampeln werden aus Zustand, Labels und offenen Human Gates
abgeleitet.

| Ampel | Regel |
| --- | --- |
| Rot | `blockiert`, offene `blocked`-Items oder phasenkritische offene Versprechen in Beta-/Release-Phase. |
| Gelb | `in Review`, `Risiko offen`, `unklar`, `needs-human` oder `needs-fix`. |
| Grün | `erledigt` oder offenes Teilprojekt ohne Gates und mit belegbarer Bewegung. |

Die Projekt-Ampel ist ein Worst-of über phasenkritische Teilprojekte. Das
Portfolio bekommt keine Gesamtampel.

Jede Ampel braucht eine klickbare Begründung, zum Beispiel Milestone, Issue,
PR, Review, Closeout oder PROJECT-Evidence-Link.

## Verbotene Signale

Das Lagebild darf nicht verwenden:

- Prozentzahlen;
- Scores;
- Velocity;
- Burndowns;
- Forecasts;
- Trendpfeile aus Ticketzählungen.

Fortschritt wird als Zustand und rohe Zählstände gezeigt, zum Beispiel
erledigte/offene/blockierte Issues. Diese Zählstände sind Belege für
Arbeitslage, keine Produktversprechen.

## Regenerierbarkeit

Das Lagebild ist Ableitung, keine eigene Aussage.

Generierte Lagebild-Dateien sind nicht manuell zu pflegen. Wenn ein Lagebild
nicht gelöscht und aus GitHub plus `PROJECT.md` neu erzeugt werden kann,
verletzt es diesen Contract.

Ein Generator darf lesen und schreiben:

- lesen: GitHub und `PROJECT.md`;
- schreiben: die generierte Markdown-Ableitung im Methoden-Repo.

Er darf nicht:

- GitHub-Issues, PRs, Labels, Milestones oder Produktversprechen mutieren;
- lokale Arbeitskopien als Wahrheit verwenden;
- AI Vault, Chat-Verläufe oder Tool-Projektanweisungen als operative Quelle
  verwenden;
- eigene Statusdateien als Wahrheit pflegen.
