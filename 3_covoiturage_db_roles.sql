-- Création des rôles
CREATE ROLE application_admin WITH LOGIN PASSWORD 'useradminpassword';
CREATE ROLE application_users WITH LOGIN PASSWORD 'userpassword'; -- Remplacez 'userpassword' par un mot de passe sécurisé

-- Fonction pour vérifier l'existence des tables et accorder les privilèges
CREATE OR REPLACE FUNCTION grant_privileges_if_exists() RETURNS void AS $$
DECLARE
    tables text[] := ARRAY['users', 'administrator', 'employee', 'trainer', 'trainee', 'training_center', 'vehicle', 'trip', 'training_session', 'training_registration', 'comment', 'notification', 'notification_preference', 'notification_template', 'term_of_service', 'fuel_price'];
    t text;
BEGIN
    FOREACH t IN ARRAY tables
    LOOP
        IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = t) THEN
            EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON %I TO application_admin', t);
            RAISE NOTICE 'Granted privileges on table %', t;
        ELSE
            RAISE NOTICE 'Table % does not exist, skipping', t;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Exécution de la fonction pour accorder les privilèges
SELECT grant_privileges_if_exists();

-- Création de la vue (à exécuter seulement si les tables nécessaires existent)
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'users')
       AND EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'trip')
       AND EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'participates')
       AND EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'training_registration') THEN
        
        EXECUTE 
        CREATE OR REPLACE VIEW user_trip_info AS
        SELECT
            u.id_user,
            u.first_name,
            u.last_name,
            t.address_departure,
            t.address_arrival,
            tr.start_date AS start_participation,
            tr.end_date AS end_participation,
            p.status
        FROM
            users u
        JOIN
            participates p ON u.id_user = p.user_id
        JOIN
            trip t ON p.trip_id = t.id_trip
        LEFT JOIN
            training_registration tr ON u.id_user = tr.trainee_id';
        
        RAISE NOTICE 'View user_trip_info created successfully';
        
        -- Accorder les privilèges sur la vue
        GRANT SELECT ON user_trip_info TO application_users;
    ELSE
        RAISE NOTICE 'Not all required tables exist for creating the view user_trip_info';
    END IF;
END $$;

-- Accorder les privilèges de lecture sur certaines tables aux utilisateurs de l'application
DO $$
DECLARE
    read_tables text[] := ARRAY['users', 'trip', 'vehicle', 'fuel_price', 'notification', 'notification_preference'];
    t text;
BEGIN
    FOREACH t IN ARRAY read_tables
    LOOP
        IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = t) THEN
            EXECUTE format('GRANT SELECT ON %I TO application_users', t);
            RAISE NOTICE 'Granted SELECT privilege on table % to application_users', t;
        ELSE
            RAISE NOTICE 'Table % does not exist, skipping SELECT privilege', t;
        END IF;
    END LOOP;
END $$;

-- Accorder les privilèges d'insertion et de mise à jour sur certaines tables aux utilisateurs de l'application
DO $$
DECLARE
    write_tables text[] := ARRAY['trip', 'comment', 'notification_preference'];
    t text;
BEGIN
    FOREACH t IN ARRAY write_tables
    LOOP
        IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = t) THEN
            EXECUTE format('GRANT INSERT, UPDATE ON %I TO application_users', t);
            RAISE NOTICE 'Granted INSERT, UPDATE privileges on table % to application_users', t;
        ELSE
            RAISE NOTICE 'Table % does not exist, skipping INSERT, UPDATE privileges', t;
        END IF;
    END LOOP;
END $$;

-- Accorder les privilèges de suppression sur la table comment aux utilisateurs de l'application
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'comment') THEN
        GRANT DELETE ON comment TO application_users;
        RAISE NOTICE 'Granted DELETE privilege on table comment to application_users';
    ELSE
        RAISE NOTICE 'Table comment does not exist, skipping DELETE privilege';
    END IF;
END $$;