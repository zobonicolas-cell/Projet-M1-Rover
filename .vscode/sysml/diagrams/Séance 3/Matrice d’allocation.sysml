// =====================================================================
// Blocs fonctionnels (identifiés en séance 2)
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
// Matrice d'allocation
// =====================================================================
package allocation_ROVLibre {

    private import blocs_ROVLibre::*;
    private import materiel_ROVLibre::*;

    part def AllocationROVLibre {

        // ===== Côté fonctionnel (blocs identifiés en séance 2) =====
        part fonctions {
            part station : StationControle;
            part energie : GestionEnergie;
            part pilotage : GestionPilotage;
            part perception : GestionPerception;
            part communication : GestionCommunication;
            part navigation : GestionNavigation;
            part stockage : StockageEmbarque;

            // FI1 – flottabilité réactive (RAMI)
            part detecteurImmersion : DetecteurImmersion;
            part coupure : CoupureElectrique;
            part flottabilite : DispositifFlottabilite;
            part propulsionAquatique : PropulsionAquatique;
        }

        // ===== Côté matériel =====
        part materiel : ArchitectureMaterielROVLibre;

        // ===== Allocations : bloc fonctionnel -> bloc matériel =====
        // StationControle
        allocate fonctions.station to materiel.station.poste;
        allocate fonctions.station to materiel.station.manette;
        allocate fonctions.station to materiel.station.serveur;

        // GestionEnergie
        allocate fonctions.energie to materiel.rover.energie;

        // GestionPilotage
        allocate fonctions.pilotage to materiel.rover.calcul;
        allocate fonctions.pilotage to materiel.rover.mobilite;
        allocate fonctions.pilotage to materiel.rover.flottabilite;

        // GestionPerception
        allocate fonctions.perception to materiel.rover.perception;
        allocate fonctions.perception to materiel.rover.observation;
        allocate fonctions.perception to materiel.rover.calcul;

        // GestionNavigation
        allocate fonctions.navigation to materiel.rover.calcul;
        allocate fonctions.navigation to materiel.rover.perception;
        allocate fonctions.navigation to materiel.rover.mobilite;

        // GestionCommunication
        allocate fonctions.communication to materiel.rover.radio;
        allocate fonctions.communication to materiel.relais;
        allocate fonctions.communication to materiel.station.radio;

        // StockageEmbarque
        allocate fonctions.stockage to materiel.rover.memoire;

        // FI1 – Flottabilité réactive (RAMI)
        allocate fonctions.detecteurImmersion to materiel.rover.perception;
        allocate fonctions.detecteurImmersion to materiel.rover.calcul;
        allocate fonctions.coupure to materiel.rover.energie;
        allocate fonctions.flottabilite to materiel.rover.flottabilite;
        allocate fonctions.propulsionAquatique to materiel.rover.mobilite;
    }
}