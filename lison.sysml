package VueContexte_RoverApex {
    private import ScalarValues::*;

    doc /* 
         * SEANCE 1 - Vue générale du contexte du système ROVER-APEX
         * Projet : Rover d'inspection et d'intervention (ROVULUTION / TECHNOVA Engineering)
         * Auteurs : Lison Millot & Jami Sommen
         */

    // =========================================================================
    // 1. DÉFINITION DES FLUX ÉCHANGÉS (ITEMS)
    // =========================================================================
    item def CommandePilotage {
        attribute modePilotage : String;
        attribute consigneVitesse : Real;
        attribute ordreLargageBalise : Boolean;
    }

    item def FluxTelemetrieEtVideo {
        attribute fluxVideoHD : String;
        attribute fluxThermiqueIR : String;
        attribute nuagePointsLiDAR : String;
        attribute niveauRSSI : Real;
        attribute alerteBlocage : Boolean;
    }

    item def MesuresPhysicoChimiques {
        attribute temperatureAmbiante : Real;
        attribute tauxGazToxique : Real;
        attribute niveauRadiationNRBC : Real;
    }

    item def EchantillonPreleve {
        attribute natureSolideOuSurface : String;
        attribute estConfineHermetiquement : Boolean;
    }

    item def ActionMecaniqueSol {
        attribute effortTraction : Real;
        attribute frequenceVibrationHz : Real;
        attribute forceAppuiBrasN : Real;
        attribute pousseeImpulsionnelleN : Real;
    }

    item def ContrainteEnvironnementale {
        attribute typeObstacle : String;      // Gravats, boue, cavité, pente jusqu'à 35°
        attribute attenuationOndesdB : Real;  // Parois en béton armé, sous-sol
        attribute temperatureC : Real;        // -10°C à +55°C
        attribute expositionEauPoussiere : Boolean;
    }

    item def EnergieElectrique {
        attribute tensionV : Real;
        attribute capaciteWh : Real;
    }

    // =========================================================================
    // 2. DÉFINITION DES PORTS D'INTERFACE
    // =========================================================================
    port def PortCommunicationRadio {
        in item commandes : CommandePilotage;
        out item donnees : FluxTelemetrieEtVideo;
    }

    port def PortInteractionTerrain {
        in item contraintes : ContrainteEnvironnementale;
        out item actionsMecaniques : ActionMecaniqueSol;
    }

    port def PortPrelevementEtMesure {
        in item mesuresBrutes : MesuresPhysicoChimiques;
        in item echantillon : EchantillonPreleve;
    }

    port def PortMaintenanceEtCharge {
        in item chargeElectrique : EnergieElectrique;
        in item rechargeBalises : Integer;
        in item rechargeCartoucheGaz : Boolean;
    }

    // =========================================================================
    // 3. DÉFINITION DU SYSTÈME D'INTÉRÊT ET DES ÉLÉMENTS EXTERNES
    // =========================================================================
    part def SystemeRoverApex {
        attribute masseTotaleKg : Real = 11.5;
        attribute indiceProtection : String = "IP67";
        attribute nombreMicroBalisesEmbarquees : Integer = 6;

        port portRadio : PortCommunicationRadio;
        port portTerrain : PortInteractionTerrain;
        port portInspection : PortPrelevementEtMesure;
        port portLogistique : PortMaintenanceEtCharge;
    }

    part def OperateurIntervention {
        doc /* Opérateur Sécurité Civile (USAR/Pompiers), Défense (NEDEX/RAID/Génie) ou Industriel */
        port portConsole : ~PortCommunicationRadio;
    }

    part def TechnicienMaintenance {
        doc /* Opérateur assurant le reconditionnement (batterie, micro-balises, cartouche pneumatique) */
        port portSupport : ~PortMaintenanceEtCharge;
    }

    part def MilieuHostileEtDecombres {
        doc /* Zone effondrée, souterraine, boueuse ou contaminée NRBC avec parois en béton armé */
        port portSolEtObstacles : ~PortInteractionTerrain;
        port portAtmosphereEtCibles : ~PortPrelevementEtMesure;
    }

    part def ReseauMicroBalisesDeployees {
        doc /* Nœuds relais autonomes largués au sol formant le réseau maillé (Mesh) */
        port portRelaisVersRover : ~PortCommunicationRadio;
        port portRelaisVersOperateur : PortCommunicationRadio;
    }

    part def ReferentielNormatifEtSecurite {
        doc /* Cadre réglementaire : Directives Machines, CEM, RED, ANFR, IP67 et MIL-STD-810 */
        attribute normesApplicables : String = "CE-Machines, CEM, RED-ANFR, IP67, MIL-STD-810";
    }

    // =========================================================================
    // 4. ASSEMBLAGE DU CONTEXTE GLOBAL (VUE D'INTERCONNEXION DU CONTEXTE)
    // =========================================================================
    part ContexteOperationnelRoverApex {
        part roverApex : SystemeRoverApex;
        part operateur : OperateurIntervention;
        part technicien : TechnicienMaintenance;
        part environnementHostile : MilieuHostileEtDecombres;
        part reseauMeshRelais : ReseauMicroBalisesDeployees;
        part cadreNormatif : ReferentielNormatifEtSecurite;

        // Connexions de communication (via le réseau maillé de micro-balises ou en vue directe)
        connect operateur.portConsole to reseauMeshRelais.portRelaisVersOperateur;
        connect reseauMeshRelais.portRelaisVersRover to roverApex.portRadio;

        // Interactions physiques et d'inspection avec la zone d'intervention
        connect roverApex.portTerrain to environnementHostile.portSolEtObstacles;
        connect roverApex.portInspection to environnementHostile.portAtmosphereEtCibles;

        // Connexion de reconditionnement et charge avant/après mission
        connect technicien.portSupport to roverApex.portLogistique;
    }
}