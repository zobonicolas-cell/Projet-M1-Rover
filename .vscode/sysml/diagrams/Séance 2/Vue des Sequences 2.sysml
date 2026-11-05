
package SequenceInspectionROVLibre {

    private import contexte_ROVLibre::definitions::*;

    package composantsInspection {

        part def StationControle;
        part def ModuleCommande;
        part def CapteurPassage;
        part def DispositifObservation;
        part def ModuleTransmission;

        item def DonneesPassage;
        item def ImagesInspection;
    }

    private import composantsInspection::*;

    occurrence sequenceInspectionObstacle {

        // Composants du scénario
        part station : StationControle;
        part commande : ModuleCommande;
        part capteur : CapteurPassage;
        part observation : DispositifObservation;
        part transmission : ModuleTransmission;

        // 1. Demande d'inspection
        message demanderInspection
            from station to commande;

        // 2. Vérification du passage
        message verifierPassage
            from commande to capteur;

        message envoyerEtatPassage
            of DonneesPassage
            from capteur to commande;

        // 3. Déploiement du dispositif
        message deployerDispositif
            from commande to observation;

        // 4. Acquisition des images
        message capturerImages
            from commande to observation;

        message transmettreImages
            of ImagesInspection
            from observation to transmission;

        // 5. Envoi des informations
        message envoyerImages
            of ImagesInspection
            from transmission to station;

        // 6. Fin de l'inspection
        message replierDispositif
            from commande to observation;

        message confirmerFinInspection
            from commande to station;
    }
}
