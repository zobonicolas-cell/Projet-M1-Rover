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

