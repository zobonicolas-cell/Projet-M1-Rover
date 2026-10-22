package contexte_rover {
    
    // 1. Définition des blocs (Le moule)
    package definitions {
        // L'acteur principal
        part def Operateur;

        // Les éléments du contexte (L'environnement extérieur)
        part def Smartphone; // Interface de contrôle
        part def ReseauWiFi; // Communication
        part def Terrain;    // Surface de déplacement
        part def Obstacle;   // Éléments à éviter

        // Le système principal
        part def RobotRover;
    }

    private import definitions::*;

    // 2. La vue des interconnexions (Le diagramme)
    part def VueContexteRover {
        
        // Création des objets
        part operateur: Operateur;
        part smartphone: Smartphone;
        part reseauWiFi: ReseauWiFi;
        part terrain: Terrain;
        part obstacle: Obstacle[*]; // [*] = yqder ykounou plusieurs obstacles
        
        part rover: RobotRover;

        // Les relations et interactions (Flows)
        flow controle from operateur to smartphone;
        flow envoieCommande from smartphone to rover;
        flow connecte from rover to reseauWiFi;
        flow rouleSur from rover to terrain;
        flow detecte from rover to obstacle;
    }
}