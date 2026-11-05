package useCases_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    // Les acteurs du système
    actor telepilote : 'Telepilote';
    actor analyste : 'Analyste';
    actor chefEquipe : 'ChefEquipe';
    actor technicien : 'Technicien';

    // Préparation de la mission
    use case mettreEnOeuvre {
        ref actor telepilote;

        doc /* Préparer le rover avant son utilisation :
               batterie, communication et vérifications. */
    }

    // Déplacement du rover
    use case conduireRover {
        ref actor telepilote;

        doc /* Permettre au télépilote de déplacer
               le rover sur un terrain difficile. */
    }

    use case naviguerAutonome {
        ref actor telepilote;

        doc /* Lancer une exploration autonome
               et suivre le déplacement du rover. */
    }

    // Observation et transmission des données
    use case observerEtAnalyser {
        ref actor analyste;

        doc /* Observer l'environnement et analyser
               les informations recueillies. */
    }

    use case transmettreDonnees {
        ref actor analyste;
        ref actor chefEquipe;

        doc /* Consulter les images, les mesures
               et les informations de mission. */
    }

    // Innovations
    use case adapterImmersion {
        ref actor telepilote;

        doc /* Surveiller et gérer le passage du rover
               en mode flottant en cas d'inondation. */
    }

    use case inspecterDerriereObstacle {
        ref actor telepilote;
        ref actor analyste;

        doc /* Explorer une zone cachée derrière
               un obstacle grâce à un dispositif
               d'observation déployable. */
    }

    // Fin de mission
    use case recupererRover {
        ref actor telepilote;
        ref actor chefEquipe;

        doc /* Organiser le retour du rover
               et récupérer les données de mission. */
    }

    use case remettreEnEtat {
        ref actor technicien;

        doc /* Nettoyer, recharger et contrôler
               le rover après son utilisation. */
    }
}