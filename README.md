# test

À compléter...

Inspiré de Odis : DataForGood saison 13.

## Installation

Pour prendre en main ce repository et installer les dépendances du projet :
- [Guide d'installation](./INSTALL.md)

```bash
cp .env.dist .env
poetry install
```

## Pour démarrer la base de données en local

```bash
docker compose up -d
```

La base de données sera ensuite accessible sur `localhost:5432`

## Pour initialiser ou réinitialiser la base de données

```
poetry run python bin/db.py init
```

## Télécharger la méthodologie et les modèles de données cibles - standby

Il s'agit d'une méthodologie reprenant les opérations de transformation effectuées (manuellement) depuis les données sources. Puis d'un ensemble de csv qui correspondent aux données transformées cibles.

```bash
poetry run python ./common/utils/download_target_data.py
```

## Pour stocker les données de l'API Dans un JSON

```
poetry run python scripts/db.py init
poetry run python /scripts/extract.py --domain eco2mix
poetry run python /scripts/load.py --domain eco2mix
```
