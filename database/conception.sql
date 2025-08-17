
-- Table des avions
CREATE TABLE avions (
   id_avion SERIAL PRIMARY KEY,
   numero VARCHAR(100) NOT NULL,          -- immatriculation
   modele VARCHAR(50) NOT NULL,
   nbsiegebusiness INT,
   nbsiegeeco INT,
   date_creation DATE DEFAULT CURRENT_DATE
);

-- Table des villes
CREATE TABLE villes (
   id_ville SERIAL PRIMARY KEY,
   nom VARCHAR(50) NOT NULL
);

-- Table des vols
CREATE TABLE vols (
   id_vol SERIAL PRIMARY KEY,
   id_ville_depart INT NOT NULL REFERENCES villes(id_ville),
   id_ville_arrivee INT NOT NULL REFERENCES villes(id_ville),
   date_heure_depart TIMESTAMP NOT NULL,
   date_heure_arrivee TIMESTAMP NOT NULL,
   statut VARCHAR(50) DEFAULT 'prévu',
   id_avion INT NOT NULL REFERENCES avions(id_avion),
   prix_eco NUMERIC(10,2) NOT NULL,           -- prix d'un siège éco
   prix_business NUMERIC(10,2) NOT NULL,      -- prix d'un siège business
   nb_siege_promo_eco INT DEFAULT 0,          -- nombre de sièges éco en promotion
   nb_siege_promo_business INT DEFAULT 0,     -- nombre de sièges business en promotion
   reduction_promo NUMERIC(5,2) DEFAULT 0,   -- pourcentage de réduction
   fin_reservation TIMESTAMP                  -- date limite pour réserver
);

-- Table des utilisateurs (passagers)
CREATE TABLE users (
   id_user SERIAL PRIMARY KEY,
   nom VARCHAR(250) NOT NULL,
   prenom VARCHAR(250),
   date_naissance DATE NOT NULL,
   login VARCHAR(250) UNIQUE NOT NULL,
   password VARCHAR(250) NOT NULL
);
INSERT INTO users (nom, prenom, date_naissance, login, password) 
VALUES ('Admin', 'Administrateur', '1990-01-01', 'admin', 'admin');

-- Table des sièges
CREATE TABLE sieges (
   id_siege SERIAL PRIMARY KEY,
   numero VARCHAR(10) NOT NULL,        -- ex : "12A"
   classe VARCHAR(50) NOT NULL,        -- eco / business
   id_avion INT NOT NULL REFERENCES avions(id_avion)
);

-- Table des réservations
CREATE TABLE reservations (
   id_reservation SERIAL PRIMARY KEY,
   date_reservation DATE DEFAULT CURRENT_DATE,
   statut VARCHAR(50) DEFAULT 'confirmée',
   classe VARCHAR(50) NOT NULL,           -- eco / business
   siege_attribue VARCHAR(50),
   prix NUMERIC(10,2) NOT NULL,          -- prix du billet
   id_vol INT NOT NULL REFERENCES vols(id_vol),
   id_user INT NOT NULL REFERENCES users(id_user),
   date_fin_annulation TIMESTAMP          -- date limite pour annuler
);

-- Table de paramétrage du délai minimum pour une réservation
CREATE TABLE parametrage_heure_reservation (
    delai_min_heures INT NOT NULL DEFAULT 2  -- nombre d'heures minimum avant le vol
);

-- Table de paramétrage du délai maximum pour annuler une réservation
CREATE TABLE parametrage_annulation_reservation (
    delai_max_heures INT NOT NULL DEFAULT 2  -- nombre d'heures maximum avant le vol pour annuler
);

-- Fonction pour calculer fin_reservation sur vols
CREATE OR REPLACE FUNCTION set_fin_reservation()
RETURNS TRIGGER AS $$
DECLARE
    delai INT;
BEGIN
    SELECT delai_min_heures INTO delai FROM parametrage_heure_reservation LIMIT 1;

    IF delai IS NULL THEN
        delai := 2;  -- valeur par défaut si pas de paramétrage
    END IF;

    NEW.fin_reservation := NEW.date_heure_depart - (delai * INTERVAL '1 hour');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger pour vols
CREATE TRIGGER trigger_fin_reservation
BEFORE INSERT OR UPDATE ON vols
FOR EACH ROW
EXECUTE FUNCTION set_fin_reservation();

-- Fonction pour calculer date_fin_annulation sur reservations
CREATE OR REPLACE FUNCTION set_date_fin_annulation()
RETURNS TRIGGER AS $$
DECLARE
    delai INT;
    vol_depart TIMESTAMP;
BEGIN
    -- on récupère le délai depuis la table de paramétrage annulation
    SELECT delai_max_heures INTO delai FROM parametrage_annulation_reservation LIMIT 1;
    IF delai IS NULL THEN
        delai := 2;  -- valeur par défaut
    END IF;

    -- on récupère la date de départ du vol
    SELECT date_heure_depart INTO vol_depart FROM vols WHERE id_vol = NEW.id_vol;

    -- calcul automatique de la date limite d'annulation
    NEW.date_fin_annulation := vol_depart - (delai * INTERVAL '1 hour');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger pour reservations
CREATE TRIGGER trigger_date_fin_annulation
BEFORE INSERT OR UPDATE ON reservations
FOR EACH ROW
EXECUTE FUNCTION set_date_fin_annulation();
