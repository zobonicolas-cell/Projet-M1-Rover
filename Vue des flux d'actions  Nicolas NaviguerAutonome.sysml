
package FluxNavigationROVLibre {

    private import ScalarValues::Boolean;

    action naviguerAutonome {

        // Condition fournie par la perception du rover
        attribute obstacleDetecte : Boolean;

        first start;

        then action recevoirDestination;
        then action analyserTerrain;
        then action detecterObstacles;

        then decide choixObstacle;
            if obstacleDetecte then adapterTrajet;
            else maintenirTrajet;

        action adapterTrajet;
            then merge repriseNavigation;

        action maintenirTrajet;
            then merge repriseNavigation;

        merge repriseNavigation;
        then action poursuivreDeplacement;
        then action transmettreEtat;
        then done;
    }
}
