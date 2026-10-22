
package ProjetRovExploration {

    // Definition de notre rover d'exploration
    part def RoverExploration {

        // Caracteristiques du rover
        attribute autonomie : Real;
        attribute vitesse : Real;

        // Equipements du rover
        port camera;
        port capteurs;
        port communication;

        // Deplacement et navigation
        part deplacement;
        part navigationAutonome;

        // Observation et transmission
        part observation;
        part analyseDonnees;
        part transmissionDonnees;

        // Resistance aux conditions difficiles
        part protection;

        // Innovation 1 : se liberer des debris
        part autoDegagement;

        // Innovation 2 : se remettre droit
        part autoRedressement;
    }

    // Instanciation de notre rover
    part rovLibre : RoverExploration {
        autonomie = 0.0;
        vitesse = 0.0;
    }
}

