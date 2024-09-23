FROM postgres:15

# Variables d'environnement pour PostgreSQL
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD userpassword
ENV POSTGRES_DB covoiturage_db

# Copier les fichiers SQL dans le répertoire d'initialisation
COPY ./1_covoiturage_db.sql /docker-entrypoint-initdb.d/1_covoiturage_db.sql
COPY ./2_covoiturage_db_script.sql /docker-entrypoint-initdb.d/2_covoiturage_db_script.sql
COPY ./3_covoiturage_db_roles.sql /docker-entrypoint-initdb.d/3_covoiturage_db_roles.sql

# Exposer le port PostgreSQL
EXPOSE 1112:5432
