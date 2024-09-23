-- Création des tables sans dépendances

CREATE TABLE IF NOT EXISTS training_center (
    id_center SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50),
    hours_opening VARCHAR(50) NOT NULL,
    sms_notifications BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS users (  
    id_user SERIAL PRIMARY KEY,  
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    phone_number VARCHAR(50),
    afpa_function VARCHAR(50),
    profile_picture VARCHAR(50),
    account_status VARCHAR(50) NOT NULL,
    type_user VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS vehicle (
    id_vehicle SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    type_vehicule VARCHAR(50) NOT NULL,
    type_fuel VARCHAR(50) NOT NULL,
    seat_number INT NOT NULL,
    average_consumption FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS term_of_service (
    id_term_of_service SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    last_updated TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS notification_template (
    id_notification_template SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    content VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS notification_preference (
    id_preference SERIAL PRIMARY KEY,
    notification_app BOOLEAN NOT NULL DEFAULT true,
    notification_email BOOLEAN NOT NULL DEFAULT true,
    notification_sms BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE IF NOT EXISTS fuel_price (
    id_fuel_price SERIAL PRIMARY KEY,
    fuel_type VARCHAR(50) NOT NULL,
    price FLOAT NOT NULL,
    effective_date DATE NOT NULL
);

-- Création des tables avec dépendances

CREATE TABLE IF NOT EXISTS employee (
    id_employee INT PRIMARY KEY,
    administrator BOOLEAN NOT NULL DEFAULT false,
    id_center INT,
    FOREIGN KEY (id_employee) REFERENCES users(id_user),
    FOREIGN KEY (id_center) REFERENCES training_center(id_center)
);

CREATE TABLE IF NOT EXISTS trainer (
    id_trainer INT PRIMARY KEY,
    FOREIGN KEY (id_trainer) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS trainee (
    id_trainee INT PRIMARY KEY,
    FOREIGN KEY (id_trainee) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS training_session (
    id_session SERIAL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE,
    id_trainer INT,
    FOREIGN KEY (id_trainer) REFERENCES trainer(id_trainer)
);

CREATE TABLE IF NOT EXISTS training_registration (
    id_registration SERIAL PRIMARY KEY,
    id_session INT NOT NULL,  
    id_trainee INT NOT NULL,
    FOREIGN KEY (id_session) REFERENCES training_session(id_session),
    FOREIGN KEY (id_trainee) REFERENCES trainee(id_trainee)
);

CREATE TABLE IF NOT EXISTS trip (
    id_trip SERIAL PRIMARY KEY,
    address_departure VARCHAR(50) NOT NULL,
    address_arrival VARCHAR(50) NOT NULL,
    time_departure TIMESTAMP NOT NULL,
    price FLOAT NOT NULL,
    type_trip VARCHAR(50),
    start_date DATE NOT NULL,
    end_date DATE,
    weekdays VARCHAR(50),
    date_trip DATE NOT NULL,
    description VARCHAR(50),
    id_vehicle INT NOT NULL,
    id_user INT,
    FOREIGN KEY (id_vehicle) REFERENCES vehicle(id_vehicle),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS user_trip (
    id_user INT,
    id_trip INT,
    PRIMARY KEY (id_user, id_trip),
    FOREIGN KEY (id_user) REFERENCES users(id_user),
    FOREIGN KEY (id_trip) REFERENCES trip(id_trip)
);

CREATE TABLE IF NOT EXISTS comment (
    id_comment SERIAL PRIMARY KEY,
    content VARCHAR(100) NOT NULL,
    date_creation TIMESTAMP NOT NULL,
    id_trip INT NOT NULL,
    id_user INT,
    FOREIGN KEY (id_trip) REFERENCES trip(id_trip),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS notification (
    id_notification SERIAL PRIMARY KEY,
    type_notification VARCHAR(50) NOT NULL,
    content VARCHAR(50) NOT NULL,
    date_creation TIMESTAMP NOT NULL,
    acceptation BOOLEAN NOT NULL,
    id_preference INT NOT NULL,
    id_user INT,
    FOREIGN KEY (id_preference) REFERENCES notification_preference(id_preference),
    FOREIGN KEY (id_user) REFERENCES users(id_user)
);

CREATE TABLE IF NOT EXISTS employee_notification_template (
    id_employee INT,
    id_notification_template INT,
    PRIMARY KEY (id_employee, id_notification_template),
    FOREIGN KEY (id_employee) REFERENCES employee(id_employee),
    FOREIGN KEY (id_notification_template) REFERENCES notification_template(id_notification_template)
);

-- Ajout de la relation entre users et notification_preference
ALTER TABLE users
ADD COLUMN IF NOT EXISTS id_preference INT,
ADD CONSTRAINT fk_user_notification_preference
    FOREIGN KEY (id_preference) REFERENCES notification_preference(id_preference);




























-- -- Création de la fonction de validation du mot de passe
-- CREATE OR REPLACE FUNCTION validate_password(password TEXT)
-- RETURNS BOOLEAN AS $$
-- BEGIN
--     -- Vérifie la longueur du mot de passe
--     IF LENGTH(password) < 8 THEN
--         RETURN FALSE;
--     END IF;

--     -- Vérifie la présence d'au moins un caractère spécial
--     IF password !~ '[!@#$%^&*(),.?":{}|<>]' THEN
--         RETURN FALSE;
--     END IF;

--     -- Vérifie la présence d'au moins une majuscule
--     IF password !~ '[A-Z]' THEN
--         RETURN FALSE;
--     END IF;

--     RETURN TRUE;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Création du trigger function
-- CREATE OR REPLACE FUNCTION check_password_trigger()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     IF NOT validate_password(NEW.password) THEN
--         RAISE EXCEPTION 'Le mot de passe ne respecte pas les règles de sécurité.';
--     END IF;
--     RETURN NEW;
-- END;
-- $$ LANGUAGE plpgsql;

-- -- Création du trigger
-- CREATE TRIGGER validate_password_before_insert
-- BEFORE INSERT OR UPDATE ON "USERS"
-- FOR EACH ROW
-- EXECUTE FUNCTION check_password_trigger();

