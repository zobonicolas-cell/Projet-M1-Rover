package contexte_ROVLibre {

    package definitions {
        // Le système étudié : rover + station de contrôle + relais radio
        part def ROVLibre;

        // Équipe d'intervention
        part def Telepilote;
        part def Analyste;
        part def ChefEquipe;
        part def Technicien;

        // Environnement de la mission
        part def Terrain;
        part def ZoneInondee;
        part def Obstacle;
        part def Victime;
        part def Atmosphere;      // fumée, poussière, chaleur, obscurité

        // Éléments échangés
        item def Commande;
        item def DonneesMission;  // images, mesures, position, cartographie
        item def EtatSysteme;     // mode terrestre/aquatique, batterie, alertes
    }

    private import definitions::*;

    part def VueContexteROVLibre {
        part systeme : ROVLibre;

        part telepilote : Telepilote;
        part analyste : Analyste;
        part chefEquipe : ChefEquipe;
        part technicien : Technicien;

        part terrain : Terrain;
        part zoneInondee : ZoneInondee[*];
        part obstacle : Obstacle[*];
        part victime : Victime[*];
        part atmosphere : Atmosphere;

        // Échanges d'information avec l'équipe
        flow commandes of Commande from telepilote to systeme;
        flow etat of EtatSysteme from systeme to telepilote;
        flow donnees of DonneesMission from systeme to analyste;
        flow compteRendu of DonneesMission from systeme to chefEquipe;
        connection entretient connect technicien to systeme;

        // Interactions avec l'environnement
        connection rouleSur connect systeme to terrain;
        connection flotteSur connect systeme to zoneInondee;    // FI1
        connection inspecteAuDela connect systeme to obstacle;  // FI2
        connection detecte connect systeme to victime;
        connection subit connect systeme to atmosphere;         // FB6
    }
}


package useCases_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    use case def CasROVLibre {
        subject systeme : ROVLibre;
    }

    // ---- Avant la mission
    use case mettreEnOeuvre : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Rendre le rover opérationnel en quelques minutes :
                           batterie, liaison radio, relais, auto-test (phase 4). */ }
    }

    // ---- Reconnaissance terrestre (fonctionnalités de base)
    use case conduireRover : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Déplacer le rover sur tout type de terrain en mode piloté (FB1). */ }
        include transmettreDonnees;
    }

    use case naviguerAutonome : CasROVLibre {
        actor telepilote : Telepilote;
        objective { doc /* Progresser seul vers un objectif sans GPS et réagir
                           de façon sûre en cas de perte de liaison (FB2). */ }
        include transmettreDonnees;
    }

    use case observerEtAnalyser : CasROVLibre {
        actor analyste : Analyste;
        actor victime : Victime[*];
        objective { doc /* Observer de jour, de nuit et dans la fumée, et repérer
                           obstacles, anomalies et silhouettes (FB3, FB4). */ }
        include transmettreDonnees;
    }

    use case transmettreDonnees : CasROVLibre {
        actor analyste : Analyste;
        objective { doc /* Envoyer en temps réel et de façon sécurisée images,
                           mesures et position (FB5). */ }
    }

    // ---- Fonctionnalités innovantes
    use case adapterImmersion : CasROVLibre {
        actor zoneInondee : ZoneInondee;
        actor telepilote : Telepilote;
        objective { doc /* FI1 : détecter seul l'immersion, acquérir une flottabilité
                           positive, naviguer en surface puis revenir au mode terrestre. */ }
        include transmettreDonnees;
    }

    use case inspecterDerriereObstacle : CasROVLibre {
        actor telepilote : Telepilote;
        actor analyste : Analyste;
        actor obstacle : Obstacle;
        objective { doc /* FI2 : déployer un moyen d'observation souple et ultra-fin
                           dans une fissure pour voir derrière l'obstacle, puis le replier. */ }
        include transmettreDonnees;
    }

    // ---- Fin de mission
    use case recupererRover : CasROVLibre {
        actor telepilote : Telepilote;
        actor chefEquipe : ChefEquipe;
        objective { doc /* Ramener le rover et sauvegarder les données de mission,
                           même si le rover n'est pas récupéré (phase 8). */ }
    }

    use case remettreEnEtat : CasROVLibre {
        actor technicien : Technicien;
        objective { doc /* Nettoyer, recharger, réarmer la flottabilité et vérifier
                           le moyen d'observation déporté (phases 9 et 10). */ }
    }
}