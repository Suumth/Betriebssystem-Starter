# Starter Configuration

Diese Konfiguration beschreibt die Werte, die ein frisch aus dem Template erzeugtes Repo personalisiert.

## Dateien

- `starter.config.example` ist die neutrale Beispiel-Konfiguration.
- `placeholders.json` ist der maschinenlesbare Contract fuer Setup und Readiness Checks.
- `setup.local.env` ist die lokale Arbeitskopie und wird nicht committed.

## Personalisierbare Werte

- `PROJECT_NAME`: sichtbarer Projektname.
- `GITHUB_OWNER`: GitHub User oder Organisation.
- `GITHUB_REPO`: Repository-Name.
- `PROJECT_REPO_URL`: kanonische GitHub-URL des Projekt-Repos.
- `AI_VAULT_PATH`: lokaler Pfad zum AI Vault.
- `LOCAL_CHECKOUT_PATH`: lokaler Pfad zum Projekt-Checkout.

## Setup-Grenzen

Setup darf lokale Projektdateien und Vault-Projektbereiche vorbereiten. Setup darf Methoden-, Contract-, Template- und Dokumentationsdateien nicht ungefragt ueberschreiben.
