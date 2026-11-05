package sequences_RecupererRover {

    private import contexte_ROVLibre::definitions::*;
    private import blocs_ROVLibre::*;

    occurrence def ScenarioRecuperationRover {

        // ===== Participants (une seule ligne de vie chacun) =====
        part chefEquipe : ChefEquipe {
            event occurrence declarationFin;
            event occurrence receptionCompteRendu;
            event occurrence receptionAlerte;
        }
        part telepilote : Telepilote {
            event occurrence receptionConfirmation;
        }
        part station : StationControle {
            event occurrence receptionOrdreFin;
            event occurrence transmissionOrdre;
            event occurrence receptionDonnees;
            event occurrence receptionPosition;
            event occurrence receptionImmobilisation;
            event occurrence envoiConfirmation;
            event occurrence envoiCompteRendu;
            event occurrence receptionDernierePosition;
            event occurrence envoiAlerte;
        }
        part communication : GestionCommunication {
            event occurrence receptionOrdre;
            event occurrence transmissionOrdre;
            event occurrence receptionDonneesRover;
            event occurrence envoiDonnees;
            event occurrence receptionPositionRover;
            event occurrence envoiPosition;
            event occurrence signalPerdu;
            event occurrence envoiDernierePosition;
        }
        part pilotage : GestionPilotage {
            event occurrence receptionOrdre;
            event occurrence demandeRetour;
            event occurrence receptionArrivee;
            event occurrence envoiImmobilisation;
            event occurrence receptionSignalPerdu;
            event occurrence envoiStockage;
            event occurrence receptionIntegrite;
            event occurrence evaluationAccessibilite;
            event occurrence receptionPositionFinale;
            event occurrence envoiDernierePosition;
        }
        part navigation : GestionNavigation {
            event occurrence receptionRetour;
            event occurrence envoiPosition;
            event occurrence envoiArrivee;
            event occurrence receptionDemande;
            event occurrence envoiPositionFinale;
        }
        part stockage : StockageEmbarque {
            event occurrence envoiDonneesStockees;
            event occurrence receptionDonnees;
            event occurrence envoiIntegrite;
        }

        // ===== Phase 1 : ordre de fin de mission =====
        message declarerFinMission of Commande
            from chefEquipe.declarationFin to station.receptionOrdreFin;
        message relayerOrdreFin of Commande
            from station.transmissionOrdre to communication.receptionOrdre;
        message transmettreOrdreFin of Commande
            from communication.transmissionOrdre to pilotage.receptionOrdre;

        // ===== Phase 2 : récupération nominale (liaison active) =====
        message transmettreDonneesRadio of DonneesMission
            from stockage.envoiDonneesStockees to communication.receptionDonneesRover;
        message transmettreDonneesStation of DonneesMission
            from communication.envoiDonnees to station.receptionDonnees;
        message lancerRetour of Commande
            from pilotage.demandeRetour to navigation.receptionRetour;
        message avancerVersPointRecuperation of DonneesMission
            from navigation.envoiPosition to communication.receptionPositionRover;
        message transmettrePositionStation of DonneesMission
            from communication.envoiPosition to station.receptionPosition;
        message signalerPointAtteint of EtatSysteme
            from navigation.envoiArrivee to pilotage.receptionArrivee;
        message securiserRover of EtatSysteme
            from pilotage.envoiImmobilisation to station.receptionImmobilisation;
        message transmettreConfirmation of EtatSysteme
            from station.envoiConfirmation to telepilote.receptionConfirmation;
        message redigerCompteRendu of DonneesMission
            from station.envoiCompteRendu to chefEquipe.receptionCompteRendu;

        // ===== Phase 3 : variante liaison perdue =====
        message verifierLiaison of EtatSysteme
            from communication.signalPerdu to pilotage.receptionSignalPerdu;
        message stockerDonneesLocalement of DonneesMission
            from pilotage.envoiStockage to stockage.receptionDonnees;
        message verifierIntegriteDonnees of EtatSysteme
            from stockage.envoiIntegrite to pilotage.receptionIntegrite;

        // ===== Phase 4 : variante rover inaccessible =====
        message evaluerAccessibilite of Commande
            from pilotage.evaluationAccessibilite to navigation.receptionDemande;
        message renvoyerPositionFinale of DonneesMission
            from navigation.envoiPositionFinale to pilotage.receptionPositionFinale;
        message enregistrerDernierePosition of DonneesMission
            from pilotage.envoiDernierePosition to communication.envoiDernierePosition;
        message transmettreDernierePositionStation of DonneesMission
            from communication.envoiDernierePosition to station.receptionDernierePosition;
        message signalerRoverAbandonne of EtatSysteme
            from station.envoiAlerte to chefEquipe.receptionAlerte;
    }
}