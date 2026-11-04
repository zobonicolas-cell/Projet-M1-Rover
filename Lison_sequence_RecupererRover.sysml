package sequences_RecupererRover {

    private import contexte_ROVLibre::definitions::*;
    private import blocs_ROVLibre::*;

    // ===== Scénario 1 : liaison active, rover accessible =====
    occurrence def ScenarioRecuperationNominale {
        part chefEquipe : ChefEquipe {
            event occurrence declarationFin;
            event occurrence receptionCompteRendu;
        }
        part telepilote : Telepilote {
            event occurrence receptionConfirmation;
        }
        part station : StationControle {
            event occurrence receptionOrdreFin;
            event occurrence transmissionOrdre;
            event occurrence receptionDonnees;
            event occurrence receptionPosition;
            event occurrence envoiCompteRendu;
            event occurrence envoiConfirmation;
        }
        part communication : GestionCommunication {
            event occurrence receptionOrdre;
            event occurrence transmissionOrdre;
            event occurrence receptionDonneesRover;
            event occurrence envoiDonnees;
            event occurrence receptionPositionRover;
            event occurrence envoiPosition;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionOrdre;
            event occurrence demandeRetour;
            event occurrence receptionArrivee;
            event occurrence envoiImmobilisation;
        }
        part navigation : GestionNavigation {
            event occurrence receptionRetour;
            event occurrence envoiPosition;
            event occurrence envoiArrivee;
        }
        part stockage : StockageEmbarque {
            event occurrence envoiDonneesStockees;
        }

        message declarerFinMission of Commande from chefEquipe.declarationFin to station.receptionOrdreFin;
        message relayerOrdreFin of Commande from station.transmissionOrdre to communication.receptionOrdre;
        message transmettreOrdreFin of Commande from communication.transmissionOrdre to pilotage.receptionOrdre;
        message transmettreDonneesRadio of DonneesMission from stockage.envoiDonneesStockees to communication.receptionDonneesRover;
        message transmettreDonneesStation of DonneesMission from communication.envoiDonnees to station.receptionDonnees;
        message lancerRetour of Commande from pilotage.demandeRetour to navigation.receptionRetour;
        message avancerVersPointRecuperation of DonneesMission from navigation.envoiPosition to communication.receptionPositionRover;
        message transmettrePositionStation of DonneesMission from communication.envoiPosition to station.receptionPosition;
        message signalerPointAtteint of EtatSysteme from navigation.envoiArrivee to pilotage.receptionArrivee;
        message securiserRover of EtatSysteme from pilotage.envoiImmobilisation to station.envoiConfirmation;
        message transmettreConfirmation of EtatSysteme from station.envoiConfirmation to telepilote.receptionConfirmation;
        message redigerCompteRendu of DonneesMission from station.envoiCompteRendu to chefEquipe.receptionCompteRendu;
    }

    // ===== Scénario 2 : liaison perdue =====
    occurrence def ScenarioRecuperationSansLiaison {
        part chefEquipe : ChefEquipe {
            event occurrence declarationFin;
        }
        part station : StationControle {
            event occurrence receptionOrdreFin;
            event occurrence transmissionOrdre;
        }
        part communication : GestionCommunication {
            event occurrence receptionOrdre;
            event occurrence transmissionOrdre;
            event occurrence signalPerdu;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionOrdre;
            event occurrence envoiStockage;
            event occurrence receptionConfirmation;
        }
        part stockage : StockageEmbarque {
            event occurrence receptionDonnees;
            event occurrence envoiIntegrite;
        }

        message declarerFinMission of Commande from chefEquipe.declarationFin to station.receptionOrdreFin;
        message relayerOrdreFin of Commande from station.transmissionOrdre to communication.receptionOrdre;
        message transmettreOrdreFin of Commande from communication.transmissionOrdre to pilotage.receptionOrdre;
        message verifierLiaison of EtatSysteme from communication.signalPerdu to pilotage.receptionOrdre;
        message stockerDonneesLocalement of DonneesMission from pilotage.envoiStockage to stockage.receptionDonnees;
        message verifierIntegriteDonnees of EtatSysteme from stockage.envoiIntegrite to pilotage.receptionConfirmation;
    }

    // ===== Scénario 3 : rover inaccessible =====
    occurrence def ScenarioRoverInaccessible {
        part chefEquipe : ChefEquipe {
            event occurrence receptionAlerte;
        }
        part station : StationControle {
            event occurrence receptionPosition;
            event occurrence envoiAlerte;
        }
        part communication : GestionCommunication {
            event occurrence receptionPositionRover;
            event occurrence envoiPosition;
        }
        part pilotage : GestionPilotage {
            event occurrence evaluationAccessibilite;
            event occurrence envoiDernierePosition;
        }
        part navigation : GestionNavigation {
            event occurrence receptionDemande;
            event occurrence envoiPositionFinale;
        }

        message evaluerAccessibilite of Commande from pilotage.evaluationAccessibilite to navigation.receptionDemande;
        message renvoyerPositionFinale of DonneesMission from navigation.envoiPositionFinale to pilotage.envoiDernierePosition;
        message enregistrerDernierePosition of DonneesMission from pilotage.envoiDernierePosition to communication.receptionPositionRover;
        message transmettrePositionStation of DonneesMission from communication.envoiPosition to station.receptionPosition;
        message signalerRoverAbandonne of EtatSysteme from station.envoiAlerte to chefEquipe.receptionAlerte;
    }
}