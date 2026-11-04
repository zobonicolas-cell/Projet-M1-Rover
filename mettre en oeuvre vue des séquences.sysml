package vue_sequences_MettreEnOeuvre {

    private import contexte_ROVLibre::definitions::*;

    // Déclaration des sous-systèmes internes pour le diagramme
    package sous_systemes {
        part def Station;
        part def Communication;
        part def Pilotage;
        part def Capteurs;
        part def Energie; 
    }
    private import sous_systemes::*;

    // ==========================================
    // VUE DES SÉQUENCES : Mettre en oeuvre
    // ==========================================
    occurrence def SequenceMettreEnOeuvre {
        doc /* Séquence chronologique d'initialisation : batterie, radio et auto-tests. */
        
        // Lignes de vie
        part telepilote : Telepilote;
        part station : Station;
        part energie : Energie;
        part communication : Communication;
        part pilotage : Pilotage;
        part capteurs : Capteurs;

        // --- 1. Démarrage et diagnostic énergétique ---
        message allumerSysteme of Commande from telepilote to station;
        message verifierBatterie of Commande from station to energie;
        message niveauBatterieOK of EtatSysteme from energie to station;

        // --- 2. Établissement de la liaison radio ---
        message initialiserLiaison of Commande from station to communication;
        message liaisonEtablie of EtatSysteme from communication to station;
        message notifierConnexion of EtatSysteme from station to telepilote;

        // --- 3. Auto-tests (Phase 4) ---
        message lancerAutoTest of Commande from telepilote to station;
        
        // Test de la mobilité
        message testerMotorisation of Commande from station to pilotage;
        message moteursOK of EtatSysteme from pilotage to station;
        
        // Test de la vision
        message testerSenseurs of Commande from station to capteurs;
        message capteursOK of EtatSysteme from capteurs to station;

        // --- 4. Validation opérationnelle ---
        message roverOperationnel of EtatSysteme from station to telepilote {
            doc /* Le système confirme au télépilote que le rover est prêt. */
        }
    }
} 