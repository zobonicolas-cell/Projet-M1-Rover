package verification_ROVLibre {

    private import contexte_ROVLibre::definitions::*;
    private import materiel_ROVLibre::*;
    private import requirements_ROVLibre::*;

    // Le système complet (rover + relais + station) qui satisfait les exigences
    part architecture : ArchitectureMaterielROVLibre;

    // =====================================================================
    // 1. SATISFACTION : blocs matériels qui répondent à chaque exigence
    // =====================================================================

    // ---- Famille « fonctions » (exigences fonctionnelles)
    satisfy requirements_ROVLibre::deplacementTerrestre     by architecture;  // rover.mobilite, rover.chassis
    satisfy requirements_ROVLibre::navigationAutonome       by architecture;  // rover.perception, rover.calcul
    satisfy requirements_ROVLibre::observationEnvironnement by architecture;  // rover.perception
    satisfy requirements_ROVLibre::detectionVictime         by architecture;  // rover.perception, rover.calcul
    satisfy requirements_ROVLibre::adaptationAmphibie       by architecture;  // rover.flottabilite, rover.calcul
    satisfy requirements_ROVLibre::navigationSurface        by architecture;  // rover.flottabilite, rover.chassis
    satisfy requirements_ROVLibre::inspectionObstacle       by architecture;  // rover.observation
    satisfy requirements_ROVLibre::retourMission            by architecture;  // rover.calcul, rover.mobilite

    // ---- Famille « interactionsMaterielles »
    satisfy requirements_ROVLibre::commandeDistance         by architecture;  // station.manette, station.radio, rover.radio
    satisfy requirements_ROVLibre::transmissionDonnees      by architecture;  // rover.radio, relais, station.radio, station.serveur
    satisfy requirements_ROVLibre::informationEtat          by architecture;  // station.poste, rover.radio
    satisfy requirements_ROVLibre::informationChefEquipe    by architecture;  // station.poste, station.serveur
    satisfy requirements_ROVLibre::maintenanceSysteme       by architecture;  // rover.energie, rover.flottabilite

    // ---- Famille « contraintes »
    satisfy requirements_ROVLibre::resistanceEnvironnement  by architecture;  // rover.chassis
    satisfy requirements_ROVLibre::securiteMouvements       by architecture;  // rover.calcul, rover.mobilite
    satisfy requirements_ROVLibre::autonomieEnergetique     by architecture;  // rover.energie
    satisfy requirements_ROVLibre::protectionElectronique   by architecture;  // rover.chassis
    satisfy requirements_ROVLibre::perteCommunication       by architecture;  // rover.calcul, rover.radio
    satisfy requirements_ROVLibre::securiteFlottabilite     by architecture;  // rover.flottabilite, rover.calcul

    // =====================================================================
    // 2. VÉRIFICATION : essais, mesures, analyses et inspections
    // =====================================================================

    // ---- Famille « fonctions »
    verification def EssaiDeplacementTerrestre {
        doc /* Essai : franchissement de béton, gravats, terre, boue, pente 30° et escalier. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::deplacementTerrestre; }
    }
    verification def EssaiNavigationAutonome {
        doc /* Essai : atteinte d'un objectif dans un bâtiment sans GPS, sans pilotage permanent. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::navigationAutonome; }
    }
    verification def EssaiObservationEnvironnement {
        doc /* Essai : qualité d'image de jour, de nuit et à travers la fumée. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::observationEnvironnement; }
    }
    verification def EssaiDetectionVictime {
        doc /* Essai : détection d'une silhouette humaine sur un jeu de scènes. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::detectionVictime; }
    }
    verification def EssaiAdaptationAmphibie {
        doc /* Essai : immersion progressive en bassin, flottabilité positive en moins de 2 s. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::adaptationAmphibie; }
    }
    verification def EssaiNavigationSurface {
        doc /* Essai : stabilité en surface en bassin avec courant, puis reprise du
               déplacement terrestre sur sol sec. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::navigationSurface; }
    }
    verification def EssaiInspectionObstacle {
        doc /* Essai : passage dans une fissure de 5 mm, déploiement de 1 m, image exploitable, repli. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::inspectionObstacle; }
    }
    verification def EssaiRetourMission {
        doc /* Essai : retour du rover au point de départ après une mission d'exploration. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::retourMission; }
    }

    // ---- Famille « interactionsMaterielles »
    verification def EssaiCommandeDistance {
        doc /* Essai : envoi de commandes depuis la manette et réaction du rover. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::commandeDistance; }
    }
    verification def EssaiTransmissionDonnees {
        doc /* Mesure : latence vidéo inférieure à 300 ms, chiffrement de bout en bout,
               images, mesures et données de mission reçues à la station. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::transmissionDonnees; }
    }
    verification def EssaiInformationEtat {
        doc /* Essai : affichage de l'état et du mode actif (terrestre ou aquatique) sur la station. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::informationEtat; }
    }
    verification def EssaiInformationChefEquipe {
        doc /* Essai : consultation des informations de mission par le chef d'équipe. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::informationChefEquipe; }
    }
    verification def EssaiMaintenanceSysteme {
        doc /* Essai : contrôle, recharge et réarmement de la flottabilité par un technicien,
               puis auto-test de bon fonctionnement. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::maintenanceSysteme; }
    }

    // ---- Famille « contraintes »
    verification def EssaiResistanceEnvironnement {
        doc /* Essai : exposition à la poussière, à la chaleur et à l'humidité prévues. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::resistanceEnvironnement; }
    }
    verification def EssaiSecuriteMouvements {
        doc /* Essai : absence de mouvement dangereux à proximité d'un mannequin et d'opérateurs. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::securiteMouvements; }
    }
    verification def EssaiAutonomieEnergetique {
        doc /* Essai : fonctionnement continu d'au moins 2 h et changement de batterie sur le terrain. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::autonomieEnergetique; }
    }
    verification def EssaiProtectionElectronique {
        doc /* Essai : contrôle de l'indice IP67 (poussière et immersion temporaire). */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::protectionElectronique; }
    }
    verification def EssaiPerteCommunication {
        doc /* Essai : coupure de la liaison, immobilisation puis retour au dernier point de liaison. */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::perteCommunication; }
    }
    verification def EssaiSecuriteFlottabilite {
        doc /* Essai : déploiement de la flottabilité sans danger pour le rover ni les personnes
               proches, et absence de déclenchement intempestif (flaque, pluie, choc, stockage). */
        subject systeme : ROVLibre;
        objective { verify requirements_ROVLibre::securiteFlottabilite; }
    }
}