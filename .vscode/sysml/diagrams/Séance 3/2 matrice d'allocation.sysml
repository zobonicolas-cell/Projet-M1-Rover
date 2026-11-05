// =====================================================================
// 1. Blocs fonctionnels (identifiés en séance 2)
// =====================================================================
package blocs_ROVLibre {

    // Blocs communs (groupe)
    part def StationControle;
    part def GestionEnergie;
    part def GestionPilotage;
    part def GestionPerception;
    part def GestionCommunication;
    part def GestionNavigation;
    part def StockageEmbarque;

    // Blocs FI1 – flottabilité réactive (RAMI)
    part def DetecteurImmersion;
    part def CoupureElectrique;
    part def DispositifFlottabilite;
    part def PropulsionAquatique;
}

// =====================================================================
// 2. Architecture matérielle
// =====================================================================
package materiel_ROVLibre {

    // Composants du rover
    part def Batterie;
    part def Calculateur;
    part def TrainChenilleEtPropulseurs;
    part def ModuleFlottabilite;
    part def Capteurs;          // LiDAR, capteurs d'eau, capteurs d'environnement
    part def Cameras;           // caméras jour et thermique
    part def ModuleRadio;
    part def Memoire;

    // Composants de la station de contrôle
    part def Poste;
    part def Manette;
    part def Serveur;

    // Relais radio déposables
    part def RelaisRadio;

    part def Rover {
        part energie : Batterie;
        part calcul : Calculateur;
        part mobilite : TrainChenilleEtPropulseurs;
        part flottabilite : ModuleFlottabilite;
        part perception : Capteurs;
        part observation : Cameras;
        part radio : ModuleRadio;
        part memoire : Memoire;
    }

    part def StationDeControle {
        part poste : Poste;
        part manette : Manette;
        part serveur : Serveur;
        part radio : ModuleRadio;
    }

    part def ArchitectureMaterielROVLibre {
        part rover : Rover;
        part station : StationDeControle;
        part relais : RelaisRadio[*];
    }
}

// =====================================================================
// 3. Matrice d'allocation
// =====================================================================
package allocation_ROVLibre {

    private import blocs_ROVLibre::*;
    private import materiel_ROVLibre::*;

    allocation def AllocationROVLibre {

        // ===== Côté fonctionnel =====
        part fonctions {
            part station : StationControle;
            part energie : GestionEnergie;
            part pilotage : GestionPilotage;
            part perception : GestionPerception;
            part communication : GestionCommunication;
            part navigation : GestionNavigation;
            part stockage : StockageEmbarque;

            // FI1 – flottabilité réactive
            part detecteurImmersion : DetecteurImmersion;
            part coupure : CoupureElectrique;
            part flottabilite : DispositifFlottabilite;
            part propulsionAquatique : PropulsionAquatique;
        }

        // ===== Côté matériel =====
        part materiel : ArchitectureMaterielROVLibre;

        // ===== Allocations : bloc fonctionnel -> composant matériel =====

        // Station de contrôle
        allocate fonctions.station to materiel.station.poste;
        allocate fonctions.station to materiel.station.manette;
        allocate fonctions.station to materiel.station.serveur;

        // Énergie
        allocate fonctions.energie to materiel.rover.energie;

        // Pilotage et mobilité
        allocate fonctions.pilotage to materiel.rover.calcul;
        allocate fonctions.pilotage to materiel.rover.mobilite;

        // Perception
        allocate fonctions.perception to materiel.rover.perception;
        allocate fonctions.perception to materiel.rover.observation;
        allocate fonctions.perception to materiel.rover.calcul;

        // Navigation
        allocate fonctions.navigation to materiel.rover.calcul;
        allocate fonctions.navigation to materiel.rover.perception;

        // Communication
        allocate fonctions.communication to materiel.rover.radio;
        allocate fonctions.communication to materiel.relais;
        allocate fonctions.communication to materiel.station.radio;

        // Stockage embarqué
        allocate fonctions.stockage to materiel.rover.memoire;

        // FI1 – Flottabilité réactive
        allocate fonctions.detecteurImmersion to materiel.rover.perception;
        allocate fonctions.detecteurImmersion to materiel.rover.calcul;
        allocate fonctions.coupure to materiel.rover.energie;
        allocate fonctions.flottabilite to materiel.rover.flottabilite;
        allocate fonctions.propulsionAquatique to materiel.rover.mobilite;
    }
}