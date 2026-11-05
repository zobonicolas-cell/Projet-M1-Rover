package sequences_ConduireRover {

    private import contexte_ROVLibre::definitions::*;
    private import blocs_ROVLibre::*;

    occurrence def ScenarioConduireRover {

        // ===== Participants (une seule ligne de vie chacun) =====
        part telepilote : Telepilote {
            event occurrence envoiCommande;
            event occurrence receptionEtat;
            event occurrence receptionAlerteObstacle;
            event occurrence receptionAlerteBatterie;
        }
        part station : StationControle {
            event occurrence receptionCommande;
            event occurrence transmissionCommande;
            event occurrence receptionRetour;
            event occurrence affichageEtat;
            event occurrence receptionAlerteObstacle;
            event occurrence affichageAlerteObstacle;
            event occurrence receptionAlerteBatterie;
            event occurrence affichageAlerteBatterie;
        }
        part communication : GestionCommunication {
            event occurrence receptionRadio;
            event occurrence transmissionPilotage;
            event occurrence receptionDonnees;
            event occurrence receptionEtatRover;
            event occurrence envoiRetour;
            event occurrence receptionAlerteObstacleRover;
            event occurrence envoiAlerteObstacle;
            event occurrence receptionAlerteBatterieRover;
            event occurrence envoiAlerteBatterie;
        }
        part energie : GestionEnergie {
            event occurrence envoiNiveauBatterie;
            event occurrence envoiNiveauCritique;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionBatterie;
            event occurrence receptionBatterieCritique;
            event occurrence receptionOrdre;
            event occurrence demandeAnalyse;
            event occurrence receptionTerrain;
            event occurrence receptionObstacle;
            event occurrence envoiEtat;
            event occurrence envoiAlerteObstacle;
            event occurrence envoiAlerteBatterie;
        }
        part perception : GestionPerception {
            event occurrence receptionDemande;
            event occurrence envoiTerrain;
            event occurrence envoiDonnees;
            event occurrence envoiObstacle;
        }

        // ===== Phase 1 : contrôle de l'état et envoi de la commande =====
        message verifierEtatSysteme of EtatSysteme
            from energie.envoiNiveauBatterie to pilotage.receptionBatterie;
        message recevoirCommande of Commande
            from telepilote.envoiCommande to station.receptionCommande;
        message relayerCommande of Commande
            from station.transmissionCommande to communication.receptionRadio;
        message validerCommande of Commande
            from communication.transmissionPilotage to pilotage.receptionOrdre;

        // ===== Phase 2 : analyse du terrain =====
        message analyserTerrain of Commande
            from pilotage.demandeAnalyse to perception.receptionDemande;

        // ===== Phase 3 : cycle nominal =====
        message resultatAnalyseTerrain of DonneesMission
            from perception.envoiTerrain to pilotage.receptionTerrain;
        message collecterDonnees of DonneesMission
            from perception.envoiDonnees to communication.receptionDonnees;
        message transmettreEtat of EtatSysteme
            from pilotage.envoiEtat to communication.receptionEtatRover;
        message transmettreDonnees of DonneesMission
            from communication.envoiRetour to station.receptionRetour;
        message transmettreEtatTelepilote of EtatSysteme
            from station.affichageEtat to telepilote.receptionEtat;

        // ===== Phase 4 : variante obstacle bloquant =====
        message resultatAnalyseObstacle of DonneesMission
            from perception.envoiObstacle to pilotage.receptionObstacle;
        message arreterRover of EtatSysteme
            from pilotage.envoiAlerteObstacle to communication.receptionAlerteObstacleRover;
        message transmettreAlerteObstacle of EtatSysteme
            from communication.envoiAlerteObstacle to station.receptionAlerteObstacle;
        message transmettreAlerteObstacleTelepilote of EtatSysteme
            from station.affichageAlerteObstacle to telepilote.receptionAlerteObstacle;

        // ===== Phase 5 : variante batterie critique =====
        message verifierNiveauCritique of EtatSysteme
            from energie.envoiNiveauCritique to pilotage.receptionBatterieCritique;
        message signalerBatterieCritique of EtatSysteme
            from pilotage.envoiAlerteBatterie to communication.receptionAlerteBatterieRover;
        message transmettreAlerteBatterie of EtatSysteme
            from communication.envoiAlerteBatterie to station.receptionAlerteBatterie;
        message transmettreAlerteBatterieTelepilote of EtatSysteme
            from station.affichageAlerteBatterie to telepilote.receptionAlerteBatterie;
    }
}