package fluxActions_remettreEnEtat {

    private import ScalarValues::Boolean;

    action def RemettreEnEtat {
        doc /* Flux d'actions du cas d'utilisation remettreEnEtat (phases 9 et 10). */

        // Conditions de garde des décisions
        attribute interventionNRBC : Boolean;
        attribute flottabiliteUtilisee : Boolean;
        attribute autoTestReussi : Boolean;

        first start;

        then action nettoyerRover {
            doc /* Nettoyage du châssis : boue, poussière, eaux usées. */ }

        then decide verifNRBC;
            if interventionNRBC then decontaminer;
            if not interventionNRBC then apresNettoyage;

        action decontaminer {
            doc /* Décontamination selon la procédure NRBC prévue. */ }
        then apresNettoyage;

        merge apresNettoyage;
        then action rechargerBatteries {
            doc /* Recharge ou remplacement des batteries. */ }
        then action controlerChassisCapteurs {
            doc /* Contrôle visuel du châssis, des chenilles et des capteurs. */ }
        then action nettoyerMoyenObservation {
            doc /* Nettoyage de l'extrémité du moyen d'observation déporté (FI2). */ }

        then decide verifFI1;
            if flottabiliteUtilisee then rearmerFlottabilite;
            if not flottabiliteUtilisee then apresRearmement;

        action rearmerFlottabilite {
            doc /* Réarmement du dispositif de flottabilité après usage de FI1. */ }
        then apresRearmement;

        merge apresRearmement;
        then action lancerAutoTest {
            doc /* Auto-test : caméras, capteurs, motricité, batterie, FI1 et FI2. */ }

        then decide verifAutoTest;
            if autoTestReussi then declarerDisponible;
            if not autoTestReussi then signalerSAV;

        action declarerDisponible {
            doc /* Le rover retourne en stockage, prêt pour la prochaine intervention. */ }
        then done;

        action signalerSAV {
            doc /* Défaut détecté : demande de maintenance au SAV de ROVULUTION. */ }
        then done;
    }
}