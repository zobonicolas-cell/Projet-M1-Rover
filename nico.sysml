
package environnement_rovlibre {

    // 1. Définition des éléments du système
    package composants {

        // Personne qui utilise le rover
        part def Pilote;

        // Éléments extérieurs au rover
        part def TabletteCommande;
        part def LiaisonSansFil;
        part def ZoneExploration;
        part def Debris;

        // Système étudié
        part def RoverInspection;
    }

    private import composants::*;

    // 2. Vue des interconnexions
    part def VueEnvironnement {

        // Éléments présents dans le contexte
        part pilote: Pilote;
        part tablette: TabletteCommande;
        part liaison: LiaisonSansFil;
        part zone: ZoneExploration;
        part debris: Debris[*];

        // Rover principal
        part rovLibre: RoverInspection;

        // Interactions entre les éléments
        flow donnelesInstructions from pilote to tablette;
        flow 'transmetdesOrdresà' from tablette to rovLibre;
        flow communiquePar from rovLibre to liaison;
        flow seDeplaceDans from rovLibre to zone;
        flow seLibereDes from rovLibre to debris;
    }
}
