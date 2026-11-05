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
    satisfy exigences_ROVLibre::fonctionnelles::deplacementTousTerrains by architecture;  // rover.mobilite, rover.chassis
    satisfy exigences_ROVLibre::fonctionnelles::navigationAutonome      by architecture;  // rover.perception, rover.calcul
    satisfy exigences_ROVLibre::fonctionnelles::perteLiaison            by architecture;  // rover.calcul, rover.radio
    satisfy exigences_ROVLibre::fonctionnelles::observationToutTemps    by architecture;  // rover.perception
    satisfy exigences_ROVLibre::fonctionnelles::detectionAutomatique    by architecture;  // rover.perception, rover.calcul
    satisfy exigences_ROVLibre::fonctionnelles::transmissionTempsReel   by architecture;  // rover.radio, relais, station.radio
    satisfy exigences_ROVLibre::fonctionnelles::conservationDonnees     by architecture;  // station.serveur, rover.memoire

    // ---- Exigences liées aux innovations
    satisfy exigences_ROVLibre::innovantes::detectionImmersion              by architecture;  // rover.flottabilite
    satisfy exigences_ROVLibre::innovantes::absenceDeclenchementIntempestif by architecture;  // rover.flottabilite, rover.calcul
    satisfy exigences_ROVLibre::innovantes::navigationSurface               by architecture;  // rover.flottabilite, rover.chassis
    satisfy exigences_ROVLibre::innovantes::retourModeTerrestre             by architecture;  // rover.flottabilite, rover.calcul
    satisfy exigences_ROVLibre::innovantes::infiltrationFissure             by architecture;  // rover.observation
    satisfy exigences_ROVLibre::innovantes::inspectionSansPerturbation      by architecture;  // rover.observation
    satisfy exigences_ROVLibre::innovantes::replisSur                       by architecture;  // rover.observation

    // ---- Environnement et robustesse
    satisfy exigences_ROVLibre::environnement::etancheite          by architecture;  // rover.chassis
    satisfy exigences_ROVLibre::environnement::temperatureStockage by architecture;  // rover entier
    satisfy exigences_ROVLibre::environnement::resistanceChocs     by architecture;  // rover.chassis

    // ---- Contraintes de mise en œuvre
    satisfy exigences_ROVLibre::contraintes::transportabilite   by architecture;  // rover entier
    satisfy exigences_ROVLibre::contraintes::miseEnOeuvreRapide by architecture;  // rover.calcul (auto-test)
    satisfy exigences_ROVLibre::contraintes::autonomie          by architecture;  // rover.energie
    // contraintes::reglementation et contraintes::nonArme : pas de bloc dédié,
    // elles sont vérifiées par analyse et inspection (voir ci-dessous).

    // =====================================================================
    // 2. Vérification : procédures de test, d'analyse ou d'inspection
    // =====================================================================

    verification def EssaiFranchissement {
        doc /* Essai : franchissement de béton, gravats, terre, boue, pente 30° et escalier. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::deplacementTousTerrains; }
    }
    verification def EssaiNavigationSansGps {
        doc /* Essai : atteinte d'un objectif dans un bâtiment sans GPS, avec cartographie. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::navigationAutonome; }
    }
    verification def EssaiPerteLiaison {
        doc /* Essai : coupure de la liaison, immobilisation puis retour au dernier point de liaison. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::perteLiaison; }
    }
    verification def EssaiObservationToutTemps {
        doc /* Essai : qualité d'image de jour, de nuit et à travers la fumée. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::observationToutTemps; }
    }
    verification def EssaiDetectionAutomatique {
        doc /* Essai : détection d'obstacles, d'anomalies et de silhouettes sur un jeu de scènes. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::detectionAutomatique; }
    }
    verification def EssaiTransmission {
        doc /* Mesure : latence vidéo inférieure à 300 ms et chiffrement de bout en bout. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::transmissionTempsReel; }
    }
    verification def EssaiConservationDonnees {
        doc /* Essai : données présentes à la station après une mission où le rover est perdu. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::fonctionnelles::conservationDonnees; }
    }
    verification def EssaiDetectionImmersion {
        doc /* Essai : immersion progressive en bassin, flottabilité positive en moins de 2 s. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::innovantes::detectionImmersion; }
    }
    verification def EssaiNonDeclenchement {
        doc /* Essai : flaque, pluie, projection, choc et stockage sans déclenchement de FI1. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::innovantes::absenceDeclenchementIntempestif; }
    }
    verification def EssaiNavigationSurface {
        doc /* Essai : stabilité en bassin avec courant jusqu'à 1 m/s, capteurs hors de l'eau. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::innovantes::navigationSurface; }
    }
    verification def EssaiRetourTerrestre {
        doc /* Essai : retour à la configuration terrestre sur sol sec après confirmation. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::innovantes::retourModeTerrestre; }
    }
    verification def EssaiSondeFissure {
        doc /* Essai : passage dans une fissure de 5 mm, déploiement de 1 m, image exploitable, repli. */
        subject systeme : ROVLibre;
        objective {
            verify exigences_ROVLibre::innovantes::infiltrationFissure;
            verify exigences_ROVLibre::innovantes::inspectionSansPerturbation;
            verify exigences_ROVLibre::innovantes::replisSur;
        }
    }
    verification def EssaiEtancheite {
        doc /* Essai : contrôle de l'indice IP67 (poussière et immersion temporaire). */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::environnement::etancheite; }
    }
    verification def EssaiClimatique {
        doc /* Essai : stockage en enceinte climatique de -20 °C à +60 °C, puis contrôle de bon fonctionnement. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::environnement::temperatureStockage; }
    }
    verification def EssaiVibrationsChocs {
        doc /* Essai : vibrations de transport routier et chocs de manutention. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::environnement::resistanceChocs; }
    }
    verification def MesureMasse {
        doc /* Mesure : pesée du rover (moins de 40 kg) et manutention à deux personnes. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::contraintes::transportabilite; }
    }
    verification def EssaiMiseEnOeuvre {
        doc /* Essai : chronométrage de la mise en œuvre avec gants, auto-test compris (moins de 5 min). */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::contraintes::miseEnOeuvreRapide; }
    }
    verification def EssaiAutonomie {
        doc /* Essai : fonctionnement continu d'au moins 2 h et changement de batterie sur le terrain. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::contraintes::autonomie; }
    }
    verification def AnalyseReglementaire {
        doc /* Analyse : conformité Machines, RED, CEM, Batteries et ATEX si site à risque. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::contraintes::reglementation; }
    }
    verification def InspectionNonArme {
        doc /* Inspection : revue de la configuration pour s'assurer qu'aucune arme n'est embarquée. */
        subject systeme : ROVLibre;
        objective { verify exigences_ROVLibre::contraintes::nonArme; }
    }

    // =====================================================================
    // 3. Compléments FI1 (RAMI) : exigences issues des cas d'utilisation
    //    adapterImmersion et remettreEnEtat, absentes de la table initiale.
    // =====================================================================

    package complementsFI1 {
        private import contexte_ROVLibre::definitions::*;

        requirement <'EI8'> signalementModeAquatique {
            subject systeme : ROVLibre;
            doc /* FI1 : la station de contrôle doit indiquer en permanence au
                   télépilote que le rover est en mode aquatique, ainsi que son
                   autonomie restante. */
        }
        requirement <'EI9'> rearmementFlottabilite {
            subject systeme : ROVLibre;
            doc /* FI1 : après usage, le dispositif de flottabilité doit pouvoir être
                   réarmé par le technicien en moins de 15 min (à valider). */
        }
    }

    satisfy complementsFI1::signalementModeAquatique by architecture;  // station.poste, rover.radio
    satisfy complementsFI1::rearmementFlottabilite   by architecture;  // rover.flottabilite

    verification def EssaiSignalementMode {
        doc /* Essai : déclenchement de FI1 en bassin, contrôle de l'affichage du mode
               aquatique et de l'autonomie restante sur la station de contrôle. */
        subject systeme : ROVLibre;
        objective { verify complementsFI1::signalementModeAquatique; }
    }
    verification def EssaiRearmement {
        doc /* Essai : chronométrage du réarmement de la flottabilité par un technicien
               après un déclenchement, puis auto-test de bon fonctionnement. */
        subject systeme : ROVLibre;
        objective { verify complementsFI1::rearmementFlottabilite; }
    }
}