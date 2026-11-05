
package SequencesROVLibre {

    private import contexte_ROVLibre::definitions::*;

    package composantsNavigation {

        part def ModuleNavigation;
        part def ModuleCapteurs;
        part def ModuleMotorisation;
        part def StationControle;

        item def Destination;
        item def MesuresTerrain;
        item def Trajet;
    }

    private import composantsNavigation::*;

    occurrence sequenceNavigationAutonome {

        // Composants qui participent au scénario
        part station : StationControle;
        part navigation : ModuleNavigation;
        part capteurs : ModuleCapteurs;
        part motorisation : ModuleMotorisation;

        // 1. Réception de la destination
        message definirDestination
            of Destination
            from station to navigation;

        // 2. Analyse du terrain
        message demanderMesures
            from navigation to capteurs;

        message envoyerMesures
            of MesuresTerrain
            from capteurs to navigation;

        // 3. Calcul du trajet
        message commanderDeplacement
            of Trajet
            from navigation to motorisation;

        // 4. Retour d'information
        message etatDeplacement
            from motorisation to navigation;

        message informerStation
            from navigation to station;
    }
}
