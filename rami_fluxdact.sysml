package fluxActions_adapterImmersion {

    private import ScalarValues::Boolean;

    action def AdapterImmersion {
        doc /* Flux d'actions du cas d'utilisation adapterImmersion (FI1). */

        // Conditions de garde des décisions
        attribute immersionConfirmee : Boolean;
        attribute flottabiliteSuffisante : Boolean;
        attribute batterieFaible : Boolean;
        attribute solSecAtteint : Boolean;

        first start;

        then action detecterEau {
            doc /* Les capteurs signalent la présence d'eau. */ }
        then action confirmerImmersion {
            doc /* Recoupement de plusieurs capteurs pour écarter flaque, pluie et projection. */ }

        then decide verifImmersion;
            if immersionConfirmee then protegerElectronique;
            if not immersionConfirmee then ignorerFausseAlerte;

        // Chemin alternatif 1 : fausse alerte
        action ignorerFausseAlerte {
            doc /* Aucun déclenchement : le rover reste en mode terrestre. */ }
        then done;

        // Chemin principal
        action protegerElectronique {
            doc /* Isolation des organes électriques contre le court-circuit. */ }
        then action gonfler {
            doc /* Augmentation instantanée du volume : flottabilité positive. */ }

        then decide verifFlottabilite;
            if flottabiliteSuffisante then stabiliser;
            if not flottabiliteSuffisante then gererEchecFlottabilite;

        // Chemin alternatif 2 : échec de la flottabilité
        action gererEchecFlottabilite {
            doc /* Alerte critique, sauvegarde des données, envoi de la dernière position. */ }
        then done;

        action stabiliser {
            doc /* Position stable en surface, capteurs hors de l'eau. */ }
        then action informerTelepilote {
            doc /* Envoi du changement de mode et de l'état : batterie, stabilité. */ }
        then action naviguerSurface {
            doc /* Déplacement piloté sur l'eau ; observation et transmission continuent. */ }

        then decide verifNavigation;
            if batterieFaible then rejoindreRive;
            if solSecAtteint then retourSolSec;
            if not batterieFaible and not solSecAtteint then naviguerSurface;

        // Chemin alternatif 3 : batterie faible
        action rejoindreRive {
            doc /* Retour vers la rive la plus proche. */ }
        then retourSolSec;

        merge retourSolSec;
        then action revenirModeTerrestre {
            doc /* Confirmation du télépilote, dégonflage, reprise de la mission terrestre. */ }
        then done;
    }
}