package environnement_microbalises {

    // 1. Définition des éléments du système
    package composants {

        // Personnes interagissant avec le réseau
        part def OperateurEOD;
        part def PosteCommandement;

        // Éléments extérieurs et environnement
        part def ObstacleRadio;
        part def MicroBalise; // Une fois larguée, elle fait le lien dans l'environnement

        // Système étudié
        part def RoverUGV;
    }

    private import composants::*;

    // 2. Vue des interconnexions (Contexte de l'innovation)
    part def VueDeploiementBalises {

        // Éléments présents dans le contexte
        part operateur: OperateurEOD;
        part poste: PosteCommandement;
        part obstacle: ObstacleRadio;
        part balise: MicroBalise[*]; // [*] car le rover peut en larguer plusieurs

        // Rover principal
        part rover: RoverUGV;

        // Interactions entre les éléments modélisant l'usage de l'innovation
        flow seHeurteA from rover to obstacle;
        flow 'deploiePhysiquement' from rover to balise;
        flow 'transmetSignalTactiqueà' from rover to balise;
        flow 'relaieReseauVers' from balise to poste;
        flow 'superviseVia' from operateur to poste;
    }
}