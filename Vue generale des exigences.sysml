package requirements_ROVLibre {

    // Exigence principale
    requirement specificationsROVLibre {
        doc /* Le rover doit permettre l'exploration
               de zones dangereuses pour les secours. */
    }

    // Trois familles d'exigences
    requirement fonctions specializes specificationsROVLibre {
        doc /* Fonctions attendues du rover. */
    }

    requirement interactionsMaterielles
        specializes specificationsROVLibre {
        doc /* Échanges entre le rover et les
               éléments extérieurs. */
    }

    requirement contraintes specializes specificationsROVLibre {
        doc /* Conditions que le rover doit respecter. */
    }

    // ====================================
    // 1. EXIGENCES FONCTIONNELLES
    // ====================================

    requirement deplacementTerrestre specializes fonctions {
        doc /* Le rover doit pouvoir se déplacer
               sur des terrains accidentés. */
    }

    requirement navigationAutonome specializes fonctions {
        doc /* Le rover doit pouvoir explorer
               une zone sans pilotage permanent. */
    }

    requirement observationEnvironnement specializes fonctions {
        doc /* Le rover doit permettre d'observer
               les zones dangereuses et les obstacles. */
    }

    requirement detectionVictime specializes fonctions {
        doc /* Le rover doit pouvoir détecter
               la présence possible d'une victime. */
    }

    requirement adaptationAmphibie specializes fonctions {
        doc /* Le rover doit détecter une arrivée
               d'eau et activer automatiquement
               un dispositif de flottabilité. */
    }

    requirement navigationSurface specializes fonctions {
        doc /* Le rover doit pouvoir rester à la surface
               de l'eau et reprendre son déplacement
               terrestre lorsque cela est possible. */
    }

    requirement inspectionObstacle specializes fonctions {
        doc /* Le rover doit permettre d'inspecter
               une zone située derrière un obstacle
               sans déplacer celui-ci. */
    }

    requirement retourMission specializes fonctions {
        doc /* Le rover doit permettre son retour
               après une mission d'exploration. */
    }

    // ====================================
    // 2. EXIGENCES D'INTERACTION
    // ====================================

    requirement commandeDistance specializes interactionsMaterielles {
        doc /* Le télépilote doit pouvoir envoyer
               des commandes au rover. */
    }

    requirement transmissionDonnees specializes interactionsMaterielles {
        doc /* Le rover doit transmettre les images,
               les mesures et les données de mission. */
    }

    requirement informationEtat specializes interactionsMaterielles {
        doc /* Le rover doit informer le télépilote
               de son état et de son mode actif. */
    }

    requirement informationChefEquipe specializes interactionsMaterielles {
        doc /* Le chef d'équipe doit pouvoir consulter
               les informations utiles à la mission. */
    }

    requirement maintenanceSysteme specializes interactionsMaterielles {
        doc /* Le technicien doit pouvoir contrôler,
               recharger et entretenir le rover. */
    }

    // ====================================
    // 3. EXIGENCES DE CONTRAINTE
    // ====================================

    requirement resistanceEnvironnement specializes contraintes {
        doc /* Le rover doit résister aux conditions
               prévues de poussière, de chaleur
               et d'humidité. */
    }

    requirement securiteMouvements specializes contraintes {
        doc /* Le rover ne doit pas provoquer de
               mouvements dangereux pour les victimes
               ou les équipes de secours. */
    }

    requirement autonomieEnergetique specializes contraintes {
        doc /* Le rover doit disposer d'une autonomie
               suffisante pour sa mission. */
    }

    requirement protectionElectronique specializes contraintes {
        doc /* Les composants électroniques doivent
               être protégés contre l'eau et
               les débris. */
    }

    requirement perteCommunication specializes contraintes {
        doc /* Le rover doit adopter un comportement
               sûr lorsque la liaison est perdue. */
    }

    requirement securiteFlottabilite specializes contraintes {
        doc /* Le déploiement de la flottabilité
               ne doit pas mettre en danger
               le rover ou les personnes proches. */
    }
}