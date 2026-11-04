package flux_ROVLibre {

    private import contexte_ROVLibre::definitions::*;
    private import ScalarValues::Boolean;

    action def FluxAdapterImmersion {
        attribute terreDetectee : Boolean;

        action detecterImmersion;
        action activerFlottabilite;
        action alerterTelepilote;
        action naviguerEnSurface;
        action revenirModeTerrestre;

        merge boucle;
        decide testTerre;

        first start;
        then detecterImmersion;
        first detecterImmersion then activerFlottabilite;
        first activerFlottabilite then alerterTelepilote;
        first alerterTelepilote then boucle;

        first boucle then naviguerEnSurface;
        first naviguerEnSurface then testTerre;

        first testTerre if terreDetectee then revenirModeTerrestre;
        first testTerre if not terreDetectee then boucle;

        first revenirModeTerrestre then done;
    }
}