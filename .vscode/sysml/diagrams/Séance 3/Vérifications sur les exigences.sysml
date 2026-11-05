package verification_ROVLibre {

    private import contexte_ROVLibre::definitions::*;
    private import materiel_ROVLibre::*;
    private import exigences_ROVLibre::*;

    part architecture : ArchitectureMaterielROVLibre;

    // =====================================================================
    // 1. Satisfaction : les exigences portent sur un sujet de type ROVLibre,
    //    c'est donc le système complet (architecture) qui les satisfait.
    //    Le commentaire de chaque ligne indique les blocs matériels concernés.
    // =====================================================================

    // ---- Exigences fonctionnelles
    satisfy fonctionnelles::deplacementTousTerrains by architecture;  // rover.mobilite, rover.chassis
    satisfy fonctionnelles::navigationAutonome      by architecture;  // rover.perception, rover.calcul
    satisfy fonctionnelles::perteLiaison            by architecture;  // rover.calcul, rover.radio
    satisfy fonctionnelles::observationToutTemps    by architecture;  // rover.perception
    satisfy fonctionnelles::detectionAutomatique    by architecture;  // rover.perception, rover.calcul
    satisfy fonctionnelles::transmissionTempsReel   by architecture;  // rover.radio, relais, station.radio
    satisfy fonctionnelles::conservationDonnees     by architecture;  // station.serveur, rover.memoire

    // ---- Exigences liées aux innovations
    satisfy innovantes::detectionImmersion              by architecture;  // rover.flottabilite
    satisfy innovantes::absenceDeclenchementIntempestif by architecture;  // rover.flottabilite, rover.calcul
    satisfy innovantes::navigationSurface               by architecture;  // rover.flottabilite, rover.chassis
    satisfy innovantes::retourModeTerrestre             by architecture;  // rover.flottabilite, rover.calcul
    satisfy innovantes::infiltrationFissure             by architecture;  // rover.observation
    satisfy innovantes::inspectionSansPerturbation      by architecture;  // rover.observation
    satisfy innovantes::replisSur                       by architecture;  // rover.observation

    // ---- Environnement et robustesse
    satisfy environnement::etancheite          by architecture;  // rover.chassis
    satisfy environnement::temperatureStockage by architecture;  // rover entier
    satisfy environnement::resistanceChocs     by architecture;  // rover.chassis

    // ---- Contraintes de mise en œuvre
    satisfy contraintes::transportabilite   by architecture;  // rover entier
    satisfy contraintes::miseEnOeuvreRapide by architecture;  // rover.calcul (auto-test)
    satisfy contraintes::autonomie          by architecture;  // rover.energie
    // contraintes::reglementation et contraintes::nonArme : pas de bloc dédié,
    // elles sont vérifiées par analyse et inspection (voir ci-dessous).

    // =====================================================================
    // 2. Vérification : procédures de test, d'analyse ou d'inspection
    // =====================================================================

    verification def EssaiFranchissement {
        doc /* Essai : franchissement de béton, gravats, terre, boue, pente 30° et escalier. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::deplacementTousTerrains; }
    }
    verification def EssaiNavigationSansGps {
        doc /* Essai : atteinte d'un objectif dans un bâtiment sans GPS, avec cartographie. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::navigationAutonome; }
    }
    verification def EssaiPerteLiaison {
        doc /* Essai : coupure de la liaison, immobilisation puis retour au dernier point de liaison. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::perteLiaison; }
    }
    verification def EssaiObservationToutTemps {
        doc /* Essai : qualité d'image de jour, de nuit et à travers la fumée. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::observationToutTemps; }
    }
    verification def EssaiDetectionAutomatique {
        doc /* Essai : détection d'obstacles, d'anomalies et de silhouettes sur un jeu de scènes. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::detectionAutomatique; }
    }
    verification def EssaiTransmission {
        doc /* Mesure : latence vidéo inférieure à 300 ms et chiffrement de bout en bout. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::transmissionTempsReel; }
    }
    verification def EssaiConservationDonnees {
        doc /* Essai : données présentes à la station après une mission où le rover est perdu. */
        subject systeme : ROVLibre;
        objective { verify fonctionnelles::conservationDonnees; }
    }
    verification def EssaiDetectionImmersion {
        doc /* Essai : immersion progressive en bassin, flottabilité positive en moins de 2 s. */
        subject systeme : ROVLibre;
        objective { verify innovantes::detectionImmersion; }
    }
    verification def EssaiNonDeclenchement {
        doc /* Essai : flaque, pluie, projection, choc et stockage sans déclenchement de FI1. */
        subject systeme : ROVLibre;
        objective { verify innovantes::absenceDeclenchementIntempestif; }
    }
    verification def EssaiNavigationSurface {
        doc /* Essai : stabilité en bassin avec courant jusqu'à 1 m/s, capteurs hors de l'eau. */
        subject systeme : ROVLibre;
        objective { verify innovantes::navigationSurface; }
    }
    verification def EssaiRetourTerrestre {
        doc /* Essai : retour à la configuration terrestre sur sol sec après confirmation. */
        subject systeme : ROVLibre;
        objective { verify innovantes::retourModeTerrestre; }
    }
    verification def EssaiSondeFissure {
        doc /* Essai : passage dans une fissure de 5 mm, déploiement de 1 m, image exploitable, repli. */
        subject systeme : ROVLibre;
        objective {
            verify innovantes::infiltrationFissure;
            verify innovantes::inspectionSansPerturbation;
            verify innovantes::replisSur;
        }
    }
    verification def EssaiEtancheite {
        doc /* Essai : contrôle de l'indice IP67 (poussière et immersion temporaire). */
        subject systeme : ROVLibre;
        objective { verify environnement::etancheite; }
    }
    verification def EssaiClimatique {
        doc /* Essai : stockage en enceinte climatique de -20 °C à +60 °C, puis contrôle de bon fonctionnement. */
        subject systeme : ROVLibre;
        objective { verify environnement::temperatureStockage; }
    }
    verification def EssaiVibrationsChocs {
        doc /* Essai : vibrations de transport routier et chocs de manutention. */
        subject systeme : ROVLibre;
        objective { verify environnement::resistanceChocs; }
    }
    verification def MesureMasse {
        doc /* Mesure : pesée du rover (moins de 40 kg) et manutention à deux personnes. */
        subject systeme : ROVLibre;
        objective { verify contraintes::transportabilite; }
    }
    verification def EssaiMiseEnOeuvre {
        doc /* Essai : chronométrage de la mise en œuvre avec gants, auto-test compris (moins de 5 min). */
        subject systeme : ROVLibre;
        objective { verify contraintes::miseEnOeuvreRapide; }
    }
    verification def EssaiAutonomie {
        doc /* Essai : fonctionnement continu d'au moins 2 h et changement de batterie sur le terrain. */
        subject systeme : ROVLibre;
        objective { verify contraintes::autonomie; }
    }
    verification def AnalyseReglementaire {
        doc /* Analyse : conformité Machines, RED, CEM, Batteries et ATEX si site à risque. */
        subject systeme : ROVLibre;
        objective { verify contraintes::reglementation; }
    }
    verification def InspectionNonArme {
        doc /* Inspection : revue de la configuration pour s'assurer qu'aucune arme n'est embarquée. */
        subject systeme : ROVLibre;
        objective { verify contraintes::nonArme; }
    }
}
