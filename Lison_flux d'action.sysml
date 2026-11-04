package flux_ROVLibre {

    action def FluxAdapterImmersion {
        action detecterImmersion;
        action activerFlottabilite;
        action alerterTelepilote;
        action naviguerEnSurface;
        action revenirModeTerrestre;

        first start;
        then detecterImmersion;
        then activerFlottabilite;
        then alerterTelepilote;
        then boucle;

        merge boucle;
        then naviguerEnSurface;
        then testTerre;

        decide testTerre;
            if terreDetectee then revenirModeTerrestre;
            else boucle;

        action revenirModeTerrestre;
        then done;

        attribute terreDetectee : ScalarValues::Boolean;
    }
}