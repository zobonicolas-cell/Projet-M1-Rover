package vue_sequences_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    // 1. Déclaration des sous-systèmes internes pour détailler les lignes de vie
    package sous_systemes {
        part def Station;
        part def Communication;
        part def Pilotage;
        part def Navigation;
        part def Stockage;
        part def Capteurs; 
    }
    private import sous_systemes::*;

    // ==========================================
    // REPRODUCTION EXACTE DE TON IMAGE (Scénario Nominal)
    // ==========================================
    occurrence def ScenarioRecuperationNominale { // <-- CORRECTION ICI : "occurrence def"
        
        part chefEquipe : ChefEquipe;
        part telepilote : Telepilote;
        part station : Station;
        part communication : Communication;
        part pilotage : Pilotage;
        part navigation : Navigation;
        part stockage : Stockage;

        message declarerFinMission of Commande from telepilote to station;
        message relayerOrdreFin of Commande from station to communication;
        message transmettreOrdreFin of Commande from communication to pilotage;
        message transmettreDonneesRadio of DonneesMission from communication to stockage;
        message transmettreDonneesStation of DonneesMission from communication to station;
        message LancerRetour of Commande from pilotage to navigation;
        message avancerVersPointRecuperation of DonneesMission from navigation to communication;
        message transmettrePositionStation of DonneesMission from communication to station;
        message signalerPointAttaint of EtatSysteme from navigation to pilotage;
        message securiserRover of EtatSysteme from pilotage to station;
        message transmettreConfirmation of EtatSysteme from station to telepilote;
        message redigerCompteRendu of DonneesMission from station to chefEquipe;
    }

    // ==========================================
    // TON CAS : TRANSMETTRE LES DONNÉES 
    // ==========================================
    occurrence def SequenceTransmettreDonnees { // <-- CORRECTION ICI : "occurrence def"
        
        part analyste : Analyste;
        part station : Station;
        part communication : Communication;
        part capteurs : Capteurs;
        part stockage : Stockage;

        message requeteFlux of Commande from analyste to station;
        message interrogerRover of Commande from station to communication;
        
        message activerAcquisition of Commande from communication to capteurs;
        message envoyerMesuresBrutes of DonneesMission from capteurs to communication;
        
        message archiverDonnees of DonneesMission from communication to stockage;
        message relayerFluxStation of DonneesMission from communication to station;
        
        message afficherDonnees of DonneesMission from station to analyste;
        message validerReception of EtatSysteme from analyste to station;
    }
} 