package flux_actions_TransmettreDonnees {

    private import contexte_ROVLibre::definitions::*;
    private import useCases_ROVLibre::*;

    action def FluxTransmettreDonnees {
        doc /* Décrit le processus interne du rover pour collecter, sécuriser et envoyer les flux. */
        
        // Définition des actions internes du système
        action acquerirFluxVideo;
        action releverCapteursTelemetriques;
        action compilerEtChiffrerDonnees;
        action emettreSignalRadio;
        action verifierIntegriteTransmission;

        // Définition de l'enchaînement logique (logigramme)
        first acquerirFluxVideo;
        first releverCapteursTelemetriques; 
        
        then compilerEtChiffrerDonnees;
        then emettreSignalRadio;
        then verifierIntegriteTransmission;
    }
}