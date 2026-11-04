package flux_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    // Données supplémentaires manipulées dans les flux
    item def Position;
    item def ImageBrute;
    item def AlerteSysteme;

    // ============ mettreEnOeuvre ============
    action def FluxMettreEnOeuvre {
        action verifierBatterie;
        action etablirLiaisonRadio;
        action deployerRelais;
        action autoTest;

        first start;
        then verifierBatterie;
        then etablirLiaisonRadio;
        then deployerRelais;
        then autoTest;
        then decide;
            if autoTestOK then pret;
            if not autoTestOK then diagnostiquer;
        action diagnostiquer;
        then verifierBatterie;   // reboucle après correction
        action pret;
        then done;
        decision decide;
        attribute autoTestOK : ScalarValues::Boolean;
    }

    // ============ conduireRover (FB1) ============
    action def FluxConduireRover {
        in item commande : Commande;
        out item etat : EtatSysteme;

        action recevoirCommande;
        action analyserTerrain;
        action piloterMoteurs;
        action transmettreEtat;

        first start;
        then merge boucle;
        then recevoirCommande;
        then analyserTerrain;
        then piloterMoteurs;
        then transmettreEtat;
        then decide;
        decision decide;
            if missionContinue then boucle;
            if not missionContinue then fin;
        merge boucle;
        action fin;
        then done;
        attribute missionContinue : ScalarValues::Boolean;
    }

    // ============ naviguerAutonome (FB2) ============
    action def FluxNaviguerAutonome {
        action definirObjectif;
        action estimerPosition;      // sans GPS
        action planifierTrajet;
        action avancer;
        action detecterObstacle;
        action contournerObstacle;
        action modeSecuritePerteLiaison;

        first start;
        then definirObjectif;
        then merge boucle;
        then estimerPosition;
        then planifierTrajet;
        then avancer;
        then decideLiaison;
        decision decideLiaison;
            if liaisonPerdue then modeSecuritePerteLiaison;
            if not liaisonPerdue then decideObstacle;
        decision decideObstacle;
            if obstacleDetecte then contournerObstacle;
            if not obstacleDetecte then decideObjectif;
        decision decideObjectif;
            if objectifAtteint then fin;
            if not objectifAtteint then boucle;
        merge boucle;
        action fin;
        then done;
        attribute liaisonPerdue : ScalarValues::Boolean;
        attribute obstacleDetecte : ScalarValues::Boolean;
        attribute objectifAtteint : ScalarValues::Boolean;
    }

    // ============ observerEtAnalyser (FB3, FB4) ============
    action def FluxObserverEtAnalyser {
        action choisirModeVision;   // jour, nuit, fumée
        action acquerirImages;
        action detecterElements;    // obstacles, anomalies, silhouettes
        action signalerVictime;

        first start;
        then choisirModeVision;
        then acquerirImages;
        then detecterElements;
        then decide;
        decision decide;
            if silhouetteDetectee then signalerVictime;
            if not silhouetteDetectee then fin;
        action fin;
        then done;
        attribute silhouetteDetectee : ScalarValues::Boolean;
    }

    // ============ transmettreDonnees (FB5) ============
    action def FluxTransmettreDonnees {
        in item donnees : DonneesMission;
        action collecterDonnees;
        action chiffrerDonnees;
        action envoyerParRadio;
        action stockerLocalement;

        first start;
        then collecterDonnees;
        then chiffrerDonnees;
        then decide;
        decision decide;
            if liaisonDisponible then envoyerParRadio;
            if not liaisonDisponible then stockerLocalement;
        action fin;
        then done;
        attribute liaisonDisponible : ScalarValues::Boolean;
    }

    // ============ adapterImmersion (FI1) ============
    action def FluxAdapterImmersion {
        action detecterImmersion;
        action alerterTelepilote;
        action activerFlottabilite;
        action naviguerEnSurface;
        action detecterSortieEau;
        action revenirModeTerrestre;
        action transmettreDonnees;

        first start;
        then detecterImmersion;
        then activerFlottabilite;
        then alerterTelepilote;
        then merge boucle;
        then naviguerEnSurface;
        then decide;
        decision decide;
            if terreDetectee then detecterSortieEau;
            if not terreDetectee then boucle;
        merge boucle;
        action detecterSortieEau;
        then revenirModeTerrestre;
        then done;
        attribute terreDetectee : ScalarValues::Boolean;
    }

    // ============ inspecterDerriereObstacle (FI2) ============
    action def FluxInspecterDerriereObstacle {
        action reperer Fissure;
        action positionnerRover;
        action deployerObservation;   // moyen souple et ultra-fin
        action observerDerriere;
        action replierObservation;

        first start;
        then reperer Fissure;
        then positionnerRover;
        then deployerObservation;
        then observerDerriere;
        then decide;
        decision decide;
            if fissureOK then replierObservation;
            if not fissureOK then replierObservation;
        then done;
        attribute fissureOK : ScalarValues::Boolean;
    }

    // ============ recupererRover ============
    action def FluxRecupererRover {
        action sauvegarderDonnees;
        action ramenerRover;
        action recupererPhysiquement;

        first start;
        then sauvegarderDonnees;
        then decide;
        decision decide;
            if roverAccessible then ramenerRover;
            if not roverAccessible then fin;
        then recupererPhysiquement;
        action fin;
        then done;
        attribute roverAccessible : ScalarValues::Boolean;
    }

    // ============ remettreEnEtat ============
    action def FluxRemettreEnEtat {
        action nettoyer;
        action recharger;
        action rearmerFlottabilite;
        action verifierObservationDeportee;

        first start;
        then nettoyer;
        then recharger;
        then rearmerFlottabilite;
        then verifierObservationDeportee;
        then done;
    }
}
