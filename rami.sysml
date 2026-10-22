package contexte_rover {
    
    package definitions {
        part def Operateur;
        part def Smartphone;
        part def ReseauWiFi;
        part def Terrain;
        part def Obstacle;
        part def RobotRover;
    }

    private import definitions::*;

    part def VueContexteRover {
        
        part operateur: Operateur;
        part smartphone: Smartphone;
        part reseauWiFi: ReseauWiFi;
        part terrain: Terrain;
        part obstacle: Obstacle[*];
        
        part rover: RobotRover;

        flow controle from operateur to smartphone;
        flow envoieCommande from smartphone to rover;
        flow connecte from rover to reseauWiFi;
        flow rouleSur from rover to terrain;
        flow detecte from rover to obstacle;
    }
}


package useCases_Rover {
    
    private import contexte_rover::definitions::*;

    actor operateur: Operateur;

    use case controlerRoverDistance {
        ref actor operateur;
    }

    use case afficherDonneesCapteurs {
        ref actor operateur;
    }

    use case eviterObstacles {
        ref actor operateur;
    }

    use case surveillerNiveauBatterie {
        ref actor operateur;
    }

    use case activerModeAutonome {
        ref actor operateur;
    }

    use case transmettreFluxVideo {
        ref actor operateur;
    }
}