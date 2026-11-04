package FluxInspectionROVLibre {

    private import ScalarValues::Boolean;

    action inspecterDerriereObstacle {

        // Condition d'accessibilite du passage
        attribute passageAccessible : Boolean;

        first start;

        then action recevoirDemandeInspection;
        then action analyserPassage;

        then decide choixPassage;
            if passageAccessible then deployerDispositif;
            else signalerImpossibilite;

        action deployerDispositif;
            then action observerZone;
            then action transmettreImages;
            then action replierDispositif;
            then merge finInspection;

        action signalerImpossibilite;
            then merge finInspection;

        merge finInspection;
        then done;
    }
}
