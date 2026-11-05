package flux_actions_MettreEnOeuvre {

    private import contexte_ROVLibre::definitions::*;
    private import useCases_ROVLibre::*;

    action def FluxMettreEnOeuvre {
        doc /* Décrit la logique d'initialisation interne du rover (Phase 4). */
        
        // Définition des actions internes
        action demarrerSystemeCentral;
        action controlerNiveauBatterie;
        action etablirConnexionRadio;
        action executerAutoTestsMobilite;
        action executerAutoTestsVision;
        action validerEtatOperationnel;

        // Enchaînement logique
        first demarrerSystemeCentral;
        then controlerNiveauBatterie;
        then etablirConnexionRadio;
        
        // Les tests de mobilité et de vision peuvent se faire en parallèle
        then executerAutoTestsMobilite;
        then executerAutoTestsVision;
        
        // Validation finale une fois les tests terminés
        then validerEtatOperationnel;
    }
} 