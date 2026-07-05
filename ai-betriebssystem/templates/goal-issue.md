# Goal Issue Template

Kopiervorlage fuer ein Ziel-Issue. Ein Goal Issue ist der Einstieg fuer den
Repository Planner nach `contracts/planner-contract.md`. Es ersetzt kein
Arbeitsticket und bekommt nie selbst `agent:ready`.

Der Mensch beschreibt hier nur das Ziel. Die Zerlegung in Tickets ist
Planner-Arbeit.

---

```markdown
# Goal: <Ziel in einem Satz>

## Goal Contract

Typ: Goal (kein Arbeitsticket, kein agent:ready)
Ziel-Repo: OWNER/REPO
Angefragt von: <Operator>
Datum: <YYYY-MM-DD>

## Ziel

Ein Satz. Was soll am Ende wahr sein, das heute nicht wahr ist?

Beispiel: "Wir moechten einen Learning Loop fuer Reviews einfuehren."

## Warum jetzt

- <optional, 1-3 Stichpunkte>

## Bekannte Nicht-Ziele

- <was ausdruecklich nicht Teil dieses Ziels ist>

## Bekannte Grenzen

- Protected Areas: <falls bekannt>
- Deadline / Zeitfenster: <falls vorhanden>
- Budget- / Ressourcenhinweise: <falls vorhanden>
- Sonstige Vorgaben: <falls vorhanden>

## Erfolgsbild

Woran erkennt der Operator, dass das Ziel erreicht ist?

- <1-3 pruefbare Aussagen, so konkret wie moeglich>

## Naechster Schritt

Repository Planner erstellt ein Plan Issue nach `templates/plan-issue.md`
und verlinkt es hier.

- Plan Issue: <#N, wird vom Planner ergaenzt>
```

---

## Regeln

- Ein Goal Issue enthaelt keinen Ticket-Stack, keine Boundary und keine
  Verification. Das ist Absicht: Zerlegung ist Planner-Arbeit.
- Fehlt das Ziel oder das Ziel-Repo, stoppt der Planner mit einer konkreten
  Rueckfrage in diesem Issue.
- Ein Goal Issue wird geschlossen, wenn der zugehoerige Plan vollstaendig
  abgearbeitet oder das Ziel verworfen wurde. Beides wird mit einem
  Kommentar begruendet.
