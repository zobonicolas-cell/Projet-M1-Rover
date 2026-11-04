package flux_ROVLibre {

    private import contexte_ROVLibre::definitions::*;
    private import ScalarValues::Boolean;

    action def FluxConduireRover {
        in item commande : Commande;
        out item etat : EtatSysteme;

        attribute obstacleBloquant : Boolean;
        attribute missionContinue : Boolean;

        action recevoirCommande;
        action analyserTerrain;
        action arreterRover;
        action piloterMoteurs;
        action transmettreEtat;
        action fin;

        merge boucle;
        decide testObstacle;
        merge suite;
        decide testFin;

        first start;
        then boucle;

        first boucle then recevoirCommande;
        first recevoirCommande then analyserTerrain;
        first analyserTerrain then testObstacle;

        first testObstacle if obstacleBloquant then arreterRover;
        first testObstacle if not obstacleBloquant then piloterMoteurs;

        first arreterRover then suite;
        first piloterMoteurs then suite;

        first suite then transmettreEtat;
        first transmettreEtat then testFin;

        first testFin if missionContinue then boucle;
        first testFin if not missionContinue then fin;

        first fin then done;
    }
}