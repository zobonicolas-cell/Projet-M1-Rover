// =====================================================================
// MODÈLE ROVLibre : fichier unique et complet
// Contexte, cas d'utilisation, exigences, matériel, allocation, vérification
// =====================================================================

// =====================================================================
// 1. CONTEXTE
// =====================================================================
package contexte_ROVLibre {

    package definitions {

        // Éléments échangés
        item def Commande;
        item def DonneesMission;  // images, mesures, position, cartographie
        item def EtatSysteme;     // mode terrestre/aquatique, batterie, alertes

        // Le système étudié : rover + station de contrôle + relais radio
        part def ROVLibre {
            in item commandeRecue : Commande;
            out item etatEmis : EtatSysteme;
            out item donneesEmises : DonneesMission;
            out item compteRenduEmis : DonneesMission;
        }

        // Équipe d'intervention
        part def Telepilote {
            out item commandeEmise : Commande;
            in item etatRecu : EtatSysteme;
        }
        part def Analyste {
            in item donneesRecues : DonneesMission;
        }
        part def ChefEquipe {
            in item compteRenduRecu : DonneesMission;
        }
        part def Technicien;

        // Environnement de la mission
        part def Terrain;
        part def ZoneInondee;
        part def Obstacle;
        part def Victime;
        part def Atmosphere;      // fumée, poussière, chaleur, obscurité
    }

    private import definitions::*;

    part def VueContexteROVLibre {
        part systeme : ROVLibre;

        part telepilote : Telepilote;
        part analyste : Analyste;
        part chefEquipe : ChefEquipe;
        part technicien : Technicien;

        part terrain : Terrain;
        part zoneInondee : ZoneInondee[*];
        part obstacle : Obstacle[*];
        part victime : Victime[*];
        part atmosphere : Atmosphere;

        // Échanges d'information avec l'équipe
        flow commandes of Commande from telepilote.commandeEmise to systeme.commandeRecue;
        flow etat of EtatSysteme from systeme.etatEmis to telepilote.etatRecu;
        flow donnees of DonneesMission from systeme.donneesEmises to analyste.donneesRecues;
        flow compteRendu of DonneesMission from systeme.compteRenduEmis to chefEquipe.compteRenduRecu;
        connection entretient connect technicien to systeme;

        // Interactions avec l'environnement
        connection rouleSur connect systeme to terrain;
        connection flotteSur connect systeme to zoneInondee;    // FI1
        connection inspecteAuDela connect systeme to obstacle;  // FI2
        connection detecte connect systeme to victime;
        connection subit connect systeme to atmosphere;         // FB6
    }
}

// =====================================================================
// 2. CAS D'UTILISATION
// =====================================================================
package useCases_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    use case def CasROVLibre {
        subject systeme : ROVLibre;
    }

    // ---- Avant la mission
    use case mettreEnOeuvre : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Rendre le rover opérationnel en quelques minutes :
                           batterie, liaison radio, relais, auto-test (phase 4). */ }
    }

    // ---- Reconnaissance terrestre (fonctionnalités de base)
    use case conduireRover : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Déplacer le rover sur tout type de terrain en mode piloté (FB1). */ }
        include transmettreDonnees;
    }

    use case naviguerAutonome : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Progresser seul vers un objectif sans GPS et réagir
                           de façon sûre en cas de perte de liaison (FB2). */ }
        include transmettreDonnees;
    }

    use case observerEtAnalyser : CasROVLibre {
        actor analyste : Analyste;
        actor victime : Victime[*];
        objective { doc /* Observer de jour, de nuit et dans la fumée, et repérer
                           obstacles, anomalies et silhouettes (FB3, FB4). */ }
        include transmettreDonnees;
    }

    use case transmettreDonnees : CasROVLibre {
        actor analyste : Analyste;
        objective { doc /* Envoyer en temps réel et de façon sécurisée images,
                           mesures et position (FB5). */ }
    }

    // ---- Fonctionnalités innovantes
    use case adapterImmersion : CasROVLibre {
        actor zoneInondee : ZoneInondee;
        actor telepilote : Telepilote;
        objective { doc /* FI1 : détecter seul l'immersion, acquérir une flottabilité
                           positive, naviguer en surface puis revenir au mode terrestre. */ }
        include transmettreDonnees;
    }

    use case inspecterDerriereObstacle : CasROVLibre {
        actor telepilote : Telepilote;
        actor analyste : Analyste;
        actor obstacle : Obstacle;
        objective { doc /* FI2 : déployer un moyen d'observation souple et ultra-fin
                           dans une fissure pour voir derrière l'obstacle, puis le replier. */ }
        include transmettreDonnees;
    }

    // ---- Fin de mission
    use case recupererRover : CasROVLibre {
        actor telepilote : Telepilote;
        actor chefEquipe : ChefEquipe;
        objective { doc /* Ramener le rover et sauvegarder les données de mission,
                           même si le rover n'est pas récupéré (phase 8). */ }
    }

    use case remettreEnEtat : CasROVLibre {
        actor technicien : Technicien;
        objective { doc /* Nettoyer, recharger, réarmer la flottabilité et vérifier
                           le moyen d'observation déporté (phases 9 et 10). */ }
    }
}

// =====================================================================
// 3. EXIGENCES
// =====================================================================
package requirements_ROVLibre {

    // Exigence principale
    requirement specificationsROVLibre {
        doc /* Le rover doit permettre l'exploration
               de zones dangereuses pour les secours. */
    }

    // Trois familles d'exigences
    requirement fonctions specializes specificationsROVLibre {
        doc /* Fonctions attendues du rover. */
    }

    requirement interactionsMaterielles
        specializes specificationsROVLibre {
        doc /* Échanges entre le rover et les
               éléments extérieurs. */
    }

    requirement contraintes specializes specificationsROVLibre {
        doc /* Conditions que le rover doit respecter. */
    }

    // ---- 1. Exigences fonctionnelles
    requirement deplacementTerrestre specializes fonctions {
        doc /* Le rover doit pouvoir se déplacer
               sur des terrains accidentés. */
    }

    requirement navigationAutonome specializes fonctions {
        doc /* Le rover doit pouvoir explorer
               une zone sans pilotage permanent. */
    }

    requirement observationEnvironnement specializes fonctions {
        doc /* Le rover doit permettre d'observer
               les zones dangereuses et les obstacles. */
    }

    requirement detectionVictime specializes fonctions {
        doc /* Le rover doit pouvoir détecter
               la présence possible d'une victime. */
    }

    requirement adaptationAmphibie specializes fonctions {
        doc /* Le rover doit détecter une arrivée
               d'eau et activer automatiquement
               un dispositif de flottabilité. */
    }

    requirement navigationSurface specializes fonctions {
        doc /* Le rover doit pouvoir rester à la surface
               de l'eau et reprendre son déplacement
               terrestre lorsque cela est possible. */
    }

    requirement inspectionObstacle specializes fonctions {
        doc /* Le rover doit permettre d'inspecter
               une zone située derrière un obstacle
               sans déplacer celui-ci. */
    }

    requirement retourMission specializes fonctions {
        doc /* Le rover doit permettre son retour
               après une mission d'exploration. */
    }

    // ---- 2. Exigences d'interaction
    requirement commandeDistance specializes interactionsMaterielles {
        doc /* Le télépilote doit pouvoir envoyer
               des commandes au rover. */
    }

    requirement transmissionDonnees specializes interactionsMaterielles {
        doc /* Le rover doit transmettre les images,
               les mesures et les données de mission. */
    }

    requirement informationEtat specializes interactionsMaterielles {
        doc /* Le rover doit informer le télépilote
               de son état et de son mode actif. */
    }

    requirement informationChefEquipe specializes interactionsMaterielles {
        doc /* Le chef d'équipe doit pouvoir consulter
               les informations utiles à la mission. */
    }

    requirement maintenanceSysteme specializes interactionsMaterielles {
        doc /* Le technicien doit pouvoir contrôler,
               recharger et entretenir le rover. */
    }

    // ---- 3. Exigences de contrainte
    requirement resistanceEnvironnement specializes contraintes {
        doc /* Le rover doit résister aux conditions
               prévues de poussière, de chaleur
               et d'humidité. */
    }

    requirement securiteMouvements specializes contraintes {
        doc /* Le rover ne doit pas provoquer de
               mouvements dangereux pour les victimes
               ou les équipes de secours. */
    }

    requirement autonomieEnergetique specializes contraintes {
        doc /* Le rover doit disposer d'une autonomie
               suffisante pour sa mission. */
    }

    requirement protectionElectronique specializes contraintes {
        doc /* Les composants électroniques doivent
               être protégés contre l'eau et
               les débris. */
    }

    requirement perteCommunication specializes contraintes {
        doc /* Le rover doit adopter un comportement
               sûr lorsque la liaison est perdue. */
    }

    requirement securiteFlottabilite specializes contraintes {
        doc /* Le déploiement de la flottabilité
               ne doit pas mettre en danger
               le rover ou les personnes proches. */
    }
}

// =====================================================================
// 4. MATÉRIEL
// =====================================================================
package materiel_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    // ===== Composants élémentaires du rover =====
    part def ChassisEtanche;
    part def Motoreducteur;
    part def TrainChenilles;
    part def DetecteurImmersion;
    part def SystemeGonflage;
    part def Flotteur;
    part def BatterieRemplacable;
    part def ControleurBatterie;
    part def CameraVisible;
    part def CameraThermique;
    part def Lidar;
    part def CentraleInertielle;
    part def SondeSouple;
    part def MecanismeDeploiement;

    // ===== Modules du rover =====
    part def ModuleMobilite {
        part motorisation : Motoreducteur[2];
        part chenilles : TrainChenilles[2];
    }

    // FI1 : détecteur et gonflage dans un même module pour réagir en moins de 2 s
    part def ModuleFlottabilite {
        part detecteur : DetecteurImmersion;
        part gonflage : SystemeGonflage;
        part flotteurs : Flotteur[2];
    }

    part def ModuleEnergie {
        part batterie : BatterieRemplacable;
        part controleur : ControleurBatterie;
    }

    part def ModulePerception {
        part cameraVisible : CameraVisible;
        part cameraThermique : CameraThermique;
        part lidar : Lidar;
        part centrale : CentraleInertielle;
    }

    // FI2 : moyen d'observation déporté (sonde souple dans une fissure)
    part def ModuleObservationDeportee {
        part sonde : SondeSouple;
        part mecanisme : MecanismeDeploiement;
    }

    part def CalculateurEmbarque;
    part def MemoireEmbarquee;
    part def ModuleRadioRover;

    // ===== Station de contrôle et relais =====
    part def PosteOperateur;
    part def ManettePilotage;
    part def ModuleRadioStation;
    part def ServeurDonnees;
    part def RelaisRadio;

    // ===== Vue d'interconnexion du rover =====
    part def RoverMateriel {
        part chassis : ChassisEtanche;
        part mobilite : ModuleMobilite;
        part flottabilite : ModuleFlottabilite;
        part energie : ModuleEnergie;
        part perception : ModulePerception;
        part observation : ModuleObservationDeportee;
        part calcul : CalculateurEmbarque;
        part memoire : MemoireEmbarquee;
        part radio : ModuleRadioRover;

        // Alimentation
        connection alimCalcul connect energie to calcul;
        connection alimMobilite connect energie to mobilite;
        connection alimPerception connect energie to perception;
        connection alimFlottabilite connect energie to flottabilite;
        connection alimObservation connect energie to observation;
        connection alimRadio connect energie to radio;

        // États, commandes et données
        connection etatBatterie connect energie to calcul;
        connection donneesPerception connect perception to calcul;
        connection commandeMobilite connect calcul to mobilite;
        connection commandeFlottabilite connect calcul to flottabilite;
        connection etatFlottabilite connect flottabilite to calcul;
        connection commandeObservation connect calcul to observation;
        connection donneesObservation connect observation to calcul;
        connection sauvegardeDonnees connect calcul to memoire;

        connection liaisonRadioCalcul connect calcul to radio;

        // Le châssis porte l'ensemble des modules
        connection portage connect chassis to calcul;
    }

    // ===== Vue d'interconnexion de la station =====
    part def StationMateriel {
        part poste : PosteOperateur;
        part manette : ManettePilotage;
        part radio : ModuleRadioStation;
        part serveur : ServeurDonnees;

        connection commandesManette connect manette to poste;
        connection donneesServeur connect poste to serveur;
        connection liaisonRadio connect poste to radio;
    }

    // ===== Système complet : rover + relais radio + station =====
    part def ArchitectureMaterielROVLibre :> ROVLibre {
        part rover : RoverMateriel;
        part relais : RelaisRadio;
        part station : StationMateriel;

        connection liaisonRoverRelais   connect rover to relais;
        connection liaisonRelaisStation connect relais to station;
    }

    // ===== Instance racine =====
    part architectureROVLibre : ArchitectureMaterielROVLibre;
}

// =====================================================================
// 5. BLOCS FONCTIONNELS (séance 2)
// =====================================================================
package blocs_ROVLibre {

    // Blocs communs (groupe)
    part def StationControle;
    part def GestionEnergie;
    part def GestionPilotage;
    part def GestionPerception;
    part def GestionCommunication;
    part def GestionNavigation;
    part def StockageEmbarque;

    // Blocs FI1 – flottabilité réactive (RAMI)
    part def FonctionDetectionImmersion;
    part def CoupureElectrique;
    part def DispositifFlottabilite;
    part def PropulsionAquatique;
}

// =====================================================================
// 6. MATRICE D'ALLOCATION
// =====================================================================
package allocation_ROVLibre {

    private import blocs_ROVLibre::*;
    private import materiel_ROVLibre::ArchitectureMaterielROVLibre;

    part def AllocationROVLibre {

        // ===== Côté fonctionnel =====
        part fonctions {
            part station : StationControle;
            part energie : GestionEnergie;
            part pilotage : GestionPilotage;
            part perception : GestionPerception;
            part communication : GestionCommunication;
            part navigation : GestionNavigation;
            part stockage : StockageEmbarque;

            // FI1 – flottabilité réactive (RAMI)
            part detecteurImmersion : FonctionDetectionImmersion;
            part coupure : CoupureElectrique;
            part flottabilite : DispositifFlottabilite;
            part propulsionAquatique : PropulsionAquatique;
        }

        // ===== Côté matériel =====
        part materiel : ArchitectureMaterielROVLibre;

        // ===== Allocations : bloc fonctionnel -> bloc matériel =====
        // StationControle
        allocate fonctions.station to materiel.station.poste;
        allocate fonctions.station to materiel.station.manette;
        allocate fonctions.station to materiel.station.serveur;

        // GestionEnergie
        allocate fonctions.energie to materiel.rover.energie;

        // GestionPilotage
        allocate fonctions.pilotage to materiel.rover.calcul;
        allocate fonctions.pilotage to materiel.rover.mobilite;
        allocate fonctions.pilotage to materiel.rover.flottabilite;

        // GestionPerception
        allocate fonctions.perception to materiel.rover.perception;
        allocate fonctions.perception to materiel.rover.observation;
        allocate fonctions.perception to materiel.rover.calcul;

        // GestionNavigation
        allocate fonctions.navigation to materiel.rover.calcul;
        allocate fonctions.navigation to materiel.rover.perception;
        allocate fonctions.navigation to materiel.rover.mobilite;

        // GestionCommunication
        allocate fonctions.communication to materiel.rover.radio;
        allocate fonctions.communication to materiel.relais;
        allocate fonctions.communication to materiel.station.radio;

        // StockageEmbarque
        allocate fonctions.stockage to materiel.rover.memoire;

        // FI1 – Flottabilité réactive (RAMI)
        allocate fonctions.detecteurImmersion to materiel.rover.perception;
        allocate fonctions.detecteurImmersion to materiel.rover.calcul;
        allocate fonctions.coupure to materiel.rover.energie;
        allocate fonctions.flottabilite to materiel.rover.flottabilite;
        allocate fonctions.propulsionAquatique to materiel.rover.mobilite;
    }
}

// =====================================================================
// 7. VÉRIFICATION DES EXIGENCES
// =====================================================================
package verification_ROVLibre {

    private import contexte_ROVLibre::definitions::*;
    private import materiel_ROVLibre::*;
    private import requirements_ROVLibre::*;

    // Le système complet (rover + relais + station) qui satisfait les exigences
    part architecture : ArchitectureMaterielROVLibre;

    // ---------------------------------------------------------------
    // Satisfaction
    // ---------------------------------------------------------------

    // Famille « fonctions »
    satisfy requirements_ROVLibre::deplacementTerrestre     by architecture;
    satisfy requirements_ROVLibre::navigationAutonome       by architecture;
    satisfy requirements_ROVLibre::observationEnvironnement by architecture;
    satisfy requirements_ROVLibre::detectionVictime         by architecture;
    satisfy requirements_ROVLibre::adaptationAmphibie       by architecture;
    satisfy requirements_ROVLibre::navigationSurface        by architecture;
    satisfy requirements_ROVLibre::inspectionObstacle       by architecture;
    satisfy requirements_ROVLibre::retourMission            by architecture;

    // Famille « interactionsMaterielles »
    satisfy requirements_ROVLibre::commandeDistance         by architecture;
    satisfy requirements_ROVLibre::transmissionDonnees      by architecture;
    satisfy requirements_ROVLibre::informationEtat          by architecture;
    satisfy requirements_ROVLibre::informationChefEquipe    by architecture;
    satisfy requirements_ROVLibre::maintenanceSysteme       by architecture;

    // Famille « contraintes »
    satisfy requirements_ROVLibre::resistanceEnvironnement  by architecture;
    satisfy requirements_ROVLibre::securiteMouvements       by architecture;
    satisfy requirements_ROVLibre::autonomieEnergetique     by architecture;
    satisfy requirements_ROVLibre::protectionElectronique   by architecture;
    satisfy requirements_ROVLibre::perteCommunication       by architecture;
    satisfy requirements_ROVLibre::securiteFlottabilite     by architecture;

    // ---------------------------------------------------------------
    // Vérification : essais, mesures, analyses, inspections
    // ---------------------------------------------------------------

    // Famille « fonctions »
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

    // Famille « interactionsMaterielles »
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

    // Famille « contraintes »
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
