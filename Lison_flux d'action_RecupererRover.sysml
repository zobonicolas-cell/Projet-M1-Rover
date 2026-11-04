package flux_RecupererRover {

    private import contexte_ROVLibre::definitions::*;
    private import ScalarValues::Boolean;

    action def FluxRecupererRover {
        in item ordreFinMission : Commande;
        out item donneesSauvegardees : DonneesMission;
        out item etat : EtatSysteme;

        // Conditions utilisées par les décisions
        attribute liaisonActive : Boolean;
        attribute roverAccessible : Boolean;
        attribute pointAtteint : Boolean;

        // ---- Fin de mission
        action declarerFinMission;

        // ---- Branche A : sauvegarde des données
        action verifierLiaison;
        action transmettreDonneesRadio;
        action stockerDonneesLocalement;
        action verifierIntegriteDonnees;

        // ---- Branche B : récupération du rover
        action evaluerAccessibilite;
        action lancerRetour;
        action avancerVersPointRecuperation;
        action immobiliserRover;
        action securiserRover;
        action recupererPhysiquement;
        action enregistrerDernierePosition;
        action signalerRoverAbandonne;

        // ---- Clôture
        action redigerCompteRendu;
        action fin;

        // ---- Nœuds de contrôle
        fork forkFin;
        join joinFin;

        decide testLiaison;
        merge sauvegardeFaite;

        decide testAccessible;
        merge boucleRetour;
        decide testArrivee;
        merge finRecuperation;

        // ---- Enchaînement
        first start;
        then declarerFinMission;
        first declarerFinMission then forkFin;

        // Branche A
        first forkFin then verifierLiaison;
        first verifierLiaison then testLiaison;

        first testLiaison if liaisonActive then transmettreDonneesRadio;
        first testLiaison if not liaisonActive then stockerDonneesLocalement;

        first transmettreDonneesRadio then sauvegardeFaite;
        first stockerDonneesLocalement then sauvegardeFaite;

        first sauvegardeFaite then verifierIntegriteDonnees;
        first verifierIntegriteDonnees then joinFin;

        // Branche B
        first forkFin then evaluerAccessibilite;
        first evaluerAccessibilite then testAccessible;

        first testAccessible if roverAccessible then lancerRetour;
        first testAccessible if not roverAccessible then enregistrerDernierePosition;

        first lancerRetour then boucleRetour;
        first boucleRetour then avancerVersPointRecuperation;
        first avancerVersPointRecuperation then testArrivee;

        first testArrivee if pointAtteint then immobiliserRover;
        first testArrivee if not pointAtteint then boucleRetour;

        first immobiliserRover then securiserRover;
        first securiserRover then recupererPhysiquement;
        first recupererPhysiquement then finRecuperation;

        first enregistrerDernierePosition then signalerRoverAbandonne;
        first signalerRoverAbandonne then finRecuperation;

        first finRecuperation then joinFin;

        // Clôture
        first joinFin then redigerCompteRendu;
        first redigerCompteRendu then fin;
        first fin then done;
    }
}