package blocs_ROVLibre {

    part def StationControle;
    part def GestionEnergie;
    part def GestionPilotage;
    part def GestionPerception;
    part def GestionCommunication;
    part def GestionNavigation;
    part def StockageEmbarque;
}
package sequences_ConduireRover {

    private import contexte_ROVLibre::definitions::*;
    private import blocs_ROVLibre::*;

    // ===== Scénario 1 : cycle nominal =====
    occurrence def ScenarioConduireNominal {
        part telepilote : Telepilote {
            event occurrence envoiCommande;
            event occurrence receptionEtat;
        }
        part station : StationControle {
            event occurrence receptionCommande;
            event occurrence transmissionCommande;
            event occurrence receptionRetour;
            event occurrence affichageEtat;
        }
        part communication : GestionCommunication {
            event occurrence receptionRadio;
            event occurrence transmissionPilotage;
            event occurrence receptionDonnees;
            event occurrence receptionEtatRover;
            event occurrence envoiRetour;
        }
        part energie : GestionEnergie {
            event occurrence envoiNiveauBatterie;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionBatterie;
            event occurrence receptionOrdre;
            event occurrence demandeAnalyse;
            event occurrence receptionTerrain;
            event occurrence envoiEtat;
        }
        part perception : GestionPerception {
            event occurrence receptionDemande;
            event occurrence envoiTerrain;
            event occurrence envoiDonnees;
        }

        message verifierEtatSysteme of EtatSysteme from energie.envoiNiveauBatterie to pilotage.receptionBatterie;
        message recevoirCommande of Commande from telepilote.envoiCommande to station.receptionCommande;
        message relayerCommande of Commande from station.transmissionCommande to communication.receptionRadio;
        message validerCommande of Commande from communication.transmissionPilotage to pilotage.receptionOrdre;
        message analyserTerrain of Commande from pilotage.demandeAnalyse to perception.receptionDemande;
        message resultatAnalyseTerrain of DonneesMission from perception.envoiTerrain to pilotage.receptionTerrain;
        message collecterDonnees of DonneesMission from perception.envoiDonnees to communication.receptionDonnees;
        message transmettreEtat of EtatSysteme from pilotage.envoiEtat to communication.receptionEtatRover;
        message transmettreDonnees of DonneesMission from communication.envoiRetour to station.receptionRetour;
        message transmettreEtatTelepilote of EtatSysteme from station.affichageEtat to telepilote.receptionEtat;
    }

    // ===== Scénario 2 : obstacle bloquant =====
    occurrence def ScenarioConduireObstacle {
        part telepilote : Telepilote {
            event occurrence envoiCommande;
            event occurrence receptionAlerte;
        }
        part station : StationControle {
            event occurrence receptionCommande;
            event occurrence transmissionCommande;
            event occurrence receptionAlerte;
            event occurrence affichageAlerte;
        }
        part communication : GestionCommunication {
            event occurrence receptionRadio;
            event occurrence transmissionPilotage;
            event occurrence receptionAlerteRover;
            event occurrence envoiAlerte;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionOrdre;
            event occurrence demandeAnalyse;
            event occurrence receptionObstacle;
            event occurrence envoiAlerte;
        }
        part perception : GestionPerception {
            event occurrence receptionDemande;
            event occurrence envoiObstacle;
        }

        message recevoirCommande of Commande from telepilote.envoiCommande to station.receptionCommande;
        message relayerCommande of Commande from station.transmissionCommande to communication.receptionRadio;
        message validerCommande of Commande from communication.transmissionPilotage to pilotage.receptionOrdre;
        message analyserTerrain of Commande from pilotage.demandeAnalyse to perception.receptionDemande;
        message resultatAnalyseTerrain of DonneesMission from perception.envoiObstacle to pilotage.receptionObstacle;
        message arreterRover of EtatSysteme from pilotage.envoiAlerte to communication.receptionAlerteRover;
        message transmettreEtat of EtatSysteme from communication.envoiAlerte to station.receptionAlerte;
        message transmettreEtatTelepilote of EtatSysteme from station.affichageAlerte to telepilote.receptionAlerte;
    }

    // ===== Scénario 3 : batterie critique =====
    occurrence def ScenarioConduireBatterieCritique {
        part telepilote : Telepilote {
            event occurrence receptionAlerte;
        }
        part station : StationControle {
            event occurrence receptionAlerte;
            event occurrence affichageAlerte;
        }
        part communication : GestionCommunication {
            event occurrence receptionAlerteRover;
            event occurrence envoiAlerte;
        }
        part energie : GestionEnergie {
            event occurrence envoiNiveauCritique;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionBatterie;
            event occurrence envoiAlerte;
        }

        message verifierEtatSysteme of EtatSysteme from energie.envoiNiveauCritique to pilotage.receptionBatterie;
        message signalerBatterieCritique of EtatSysteme from pilotage.envoiAlerte to communication.receptionAlerteRover;
        message transmettreEtat of EtatSysteme from communication.envoiAlerte to station.receptionAlerte;
        message transmettreEtatTelepilote of EtatSysteme from station.affichageAlerte to telepilote.receptionAlerte;
    }
}
