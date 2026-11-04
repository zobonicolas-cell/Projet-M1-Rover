package projet_rover {
    
    package parts {
        /* acteurs */
        part def Utilisateur;
        part def OperateurEOD :> Utilisateur; // L'opérateur EOD est un type d'utilisateur
        part def PosteCommandement;
        
        /* contexte (système) */
        part def RoverUGV;
    }

    package useCases {
        private import projet_rover::parts::*;
        
        // Instanciation des acteurs
        actor utilisateur: Utilisateur;
        actor operateur: OperateurEOD ::> utilisateur;
        actor poste: PosteCommandement;

        // Définition des cas d'utilisation et liaison avec les acteurs
        use case inspecterZoneSensible {
            ref actor operateur;
        }
        
        use case detecterEnginsExplosifs {
            ref actor operateur;
        }
        
        use case maintenirLiaisonRadio {
            ref actor operateur;
            ref actor poste;
        }
        
        use case superviserMission {
            ref actor poste;
        }
    }
}