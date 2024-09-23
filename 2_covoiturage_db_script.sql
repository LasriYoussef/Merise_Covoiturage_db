-- Insertion de données dans la table TRAINER
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'trainer') THEN
        INSERT INTO trainer (name_trainer)
        VALUES 
            ('Alice Johnson'),
            ('Bob Smith'),
            ('Carol Williams');
        RAISE NOTICE 'Data inserted into trainer table successfully';
    ELSE
        RAISE NOTICE 'The trainer table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table TRAINEE
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'trainee') THEN
        INSERT INTO trainee (name_trainee)
        VALUES 
            ('David Brown'),
            ('Eva Green'),
            ('Frank White');
        RAISE NOTICE 'Data inserted into trainee table successfully';
    ELSE
        RAISE NOTICE 'The trainee table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table TRAINING_SESSION
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'training_session') THEN
        INSERT INTO training_session (start_date, end_date)
        VALUES 
            ('2024-10-01', '2024-10-05'),
            ('2024-10-10', '2024-10-15'),
            ('2024-10-20', '2024-10-25');
        RAISE NOTICE 'Data inserted into training_session table successfully';
    ELSE
        RAISE NOTICE 'The training_session table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table TRAINING_REGISTRATION
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'training_registration') THEN
        INSERT INTO training_registration (id_session, id_trainee)
        VALUES 
            (1, 1),
            (1, 2),
            (2, 2),
            (2, 3),
            (3, 1),
            (3, 3);
        RAISE NOTICE 'Data inserted into training_registration table successfully';
    ELSE
        RAISE NOTICE 'The training_registration table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table TERM_OF_SERVICE
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'term_of_service') THEN
        INSERT INTO term_of_service (content, last_updated)
        VALUES 
            ('Terms and conditions of service', '2024-09-21 00:00:00');
        RAISE NOTICE 'Data inserted into term_of_service table successfully';
    ELSE
        RAISE NOTICE 'The term_of_service table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table NOTIFICATION_TEMPLATE
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'notification_template') THEN
        INSERT INTO notification_template (name, content, type)
        VALUES 
            ('Welcome Email', 'Welcome to our service', 'email'),
            ('Reminder SMS', 'Don''t forget your appointment.', 'sms');
        RAISE NOTICE 'Data inserted into notification_template table successfully';
    ELSE
        RAISE NOTICE 'The notification_template table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table FUEL_PRICE
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'fuel_price') THEN
        INSERT INTO fuel_price (fuel_type, price, effective_date)
        VALUES 
            ('Petrol', 1.25, '2024-09-21'),
            ('Diesel', 1.35, '2024-09-21'),
            ('Ethanol', 0.97, '2024-09-21'),
            ('Electric', 0.13, '2024-09-24');
        RAISE NOTICE 'Data inserted into fuel_price table successfully';
    ELSE
        RAISE NOTICE 'The fuel_price table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table COMMENT
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'comment') THEN
        INSERT INTO comment (content, date_creation, id_trip)
        VALUES 
            ('Hello, John Doe has accepted your trip request. Enjoy your carpool!', '2024-09-21 00:00:00', 1),
            ('Hello, unfortunately, Jane Doe has not accepted your trip request. Other options are surely available!', '2024-09-21 00:00:00', 2),
            ('Hello, Alex Smith is interested in your trip from Greenfield to Sunrise. You can call them at +123456789 to arrange the trip.', '2024-09-21 00:00:00', 3);
        RAISE NOTICE 'Data inserted into comment table successfully';
    ELSE
        RAISE NOTICE 'The comment table does not exist. Skipping data insertion.';
    END IF;
END $$;

-- Insertion de données dans la table NOTIFICATION
DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'notification') THEN
        INSERT INTO notification (type_notification, content, date_creation, acceptation, id_preference)
        VALUES 
            ('System Alert', 'Update available.', '2024-09-21 00:00:00', true, 1),
            ('Reminder', 'Meeting scheduled.', '2024-09-21 00:00:00', true, 2);
        RAISE NOTICE 'Data inserted into notification table successfully';
    ELSE
        RAISE NOTICE 'The notification table does not exist. Skipping data insertion.';
    END IF;
END $$;





























-- -- Liste des utilisateurs
-- SELECT 
--     id_users AS "ID Utilisateur",
--     first_name AS "Prénom",
--     last_name AS "Nom",
--     email AS "Email",
--     phone_number AS "Numéro de Téléphone",
--     afpa_function AS "Fonction AFPA",
--     account_status AS "Statut du Compte",
--     type_users AS "Type d'Utilisateur"
-- FROM 
--     userss;

-- -- Liste des véhicules
-- SELECT 
--     id_vehicle AS "ID Véhicule",
--     model AS "Modèle",
--     type_vehicle AS "Type de Véhicule",
--     type_fuel AS "Type de Carburant",
--     seat_number AS "Nombre de Places",
--     average_consumption AS "Consommation Moyenne"
-- FROM 
--     vehicle;

-- -- Liste des voyages
-- SELECT 
--     id_trip AS "ID Voyage",
--     address_departure AS "Adresse de Départ",
--     address_arrival AS "Adresse d'Arrivée",
--     time_departure AS "Heure de Départ",
--     price AS "Prix",
--     type_trip AS "Type de Voyage",
--     start_date AS "Date de Début",
--     end_date AS "Date de Fin",
--     weekdays AS "Jours de la Semaine",
--     description AS "Description"
-- FROM 
--     trip;

-- -- Liste des sessions de formation
-- SELECT 
--     id_session AS "ID Session",
--     start_date AS "Date de Début",
--     end_date AS "Date de Fin"
-- FROM 
--     training_session;

-- -- Liste des formations
-- SELECT 
--     id_training AS "ID Formation",
--     name_training AS "Nom de la Formation"
-- FROM 
--     training;

-- -- Liste des commentaires
-- SELECT 
--     id_comment AS "ID Commentaire",
--     content AS "Contenu",
--     date_creation AS "Date de Création"
-- FROM 
--     comment;

-- -- Liste des notifications
-- SELECT 
--     id_notification AS "ID Notification",
--     type_notification AS "Type de Notification",
--     content AS "Contenu",
--     date_creation AS "Date de Création",
--     acceptation AS "Acceptation"
-- FROM 
--     notification;

-- -- Liste des préférences de notification
-- SELECT 
--     id_preference AS "ID Préférence",
--     notification_app AS "Notification App",
--     notification_email AS "Notification Email",
--     notification_sms AS "Notification SMS"
-- FROM 
--     notification_preference;

-- -- Liste des centres de formation
-- SELECT 
--     id_center AS "ID Centre",
--     name AS "Nom",
--     address AS "Adresse",
--     hours_opening AS "Heures d'Ouverture",
--     sms_notifications AS "Notifications SMS"
-- FROM 
--     training_center;

-- -- Liste des employés
-- SELECT 
--     id_employee AS "ID Employé",
--     admin AS "Administrateur"
-- FROM 
--     employee;

-- -- Liste des formateurs
-- SELECT 
--     id_trainer AS "ID Formateur",
--     name_trainer AS "Nom du Formateur"
-- FROM 
--     trainer;

-- -- Liste des stagiaires
-- SELECT 
--     id_trainee AS "ID Stagiaire",
--     name_trainee AS "Nom du Stagiaire"
-- FROM 
--     trainee;
