# Nom du conteneur docker-compose (par défaut c'est "docker-compose")
DC := docker-compose

# Cible par défaut
.DEFAULT_GOAL := help

# -----------------------------------------------------------------------------
# 🐳 Docker
# -----------------------------------------------------------------------------
up:  ## Démarre tous les services (Airflow, DB...)
	$(DC) up --build -d

down:  ## Arrête tous les conteneurs
	$(DC) down

restart: down up  ## Redémarre les conteneurs proprement

logs:  ## Affiche les logs
	$(DC) logs -f

# -----------------------------------------------------------------------------
# 🌬️ Airflow
# -----------------------------------------------------------------------------

airflow-init:  ## Initialise la base Airflow
	$(DC) run --rm airflow-webserver airflow db init

airflow-user:  ## Crée un utilisateur admin Airflow (user: airflow / pwd: airflow)
	$(DC) run --rm airflow-webserver airflow users create \
		--username airflow \
		--password airflow \
		--firstname Admin \
		--lastname User \
		--role Admin \
		--email elsa.lebihan@proton.me
airflow-ui:  ## Ouvre l'interface Airflow
	open http://localhost:8080

# -----------------------------------------------------------------------------
# 🧪 Tests
# -----------------------------------------------------------------------------

test:  ## Teste la connexion à PostgreSQL Airflow
	PGPASSWORD=$(PG_DB_AIRFLOW_PWD) psql -h localhost -U $(PG_DB_AIRFLOW_USER) -d $(PG_DB_AIRFLOW) -c '\dt'

# -----------------------------------------------------------------------------
# 🆘 Aide
# -----------------------------------------------------------------------------

help:
	@g
