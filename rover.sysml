package MonPremierModele {
    // Définition d'un système simple (ex: un système de commande de vélo)
    part def SystemeVeloCommande {
        attribute poids : Real;
        port capteurVitesse;
    }

    // Instanciation du système
    part monVeloCommande : SystemeVeloCommande {
        poids = 12.5;
    }
}