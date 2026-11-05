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

        // GestionCommunication
        allocate fonctions.communication to materiel.rover.radio;
        allocate fonctions.communication to materiel.relais;
        allocate fonctions.communication to materiel.station.radio;

        // StockageEmbarque
        allocate fonctions.stockage to materiel.rover.memoire;
    }
}
