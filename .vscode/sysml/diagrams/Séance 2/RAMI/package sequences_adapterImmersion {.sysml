package sequences_adapterImmersion {

    // ===== Acteurs externes
    part def ZoneInondee;
    part def Telepilote;

    // ===== Blocs fonctionnels identifiés
    part def DetecteurImmersion;
    part def UniteControle;
    part def CoupureElectrique;
    part def DispositifFlottabilite;
    part def PropulsionAquatique;
    part def GestionEnergie;
    part def StationControle;

    // ===== Messages échangés
    item def ContactEau;
    item def SignalImmersion;
    item def OrdreProtection;
    item def OrdreGonflage;
    item def EtatFlottabilite;
    item def AlerteModeAquatique;
    item def AlerteCritique;
    item def NiveauBatterie;
    item def Commande;
    item def OrdreDeplacement;
    item def ConfirmationSolSec;
    item def OrdreDegonflage;
    item def EtatSysteme;

    // ------------------------------------------------------------
    // Séquence 1 : scénario nominal
    // ------------------------------------------------------------
    occurrence def S1_Nominal {
        doc /* Immersion confirmée, flottabilité acquise, navigation en surface
               puis retour au mode terrestre. */

        part eau : ZoneInondee {
            event occurrence contactEnvoye;
        }
        part detecteur : DetecteurImmersion {
            event occurrence contactRecu;
            then event occurrence signalEnvoye;
        }
        part controle : UniteControle {
            event occurrence signalRecu;
            then event occurrence protectionEnvoyee;
            then event occurrence gonflageEnvoye;
            then event occurrence etatFlottRecu;
            then event occurrence alerteEnvoyee;
            then event occurrence commandeRecue;
            then event occurrence deplacementEnvoye;
            then event occurrence solSecRecu;
            then event occurrence degonflageEnvoye;
            then event occurrence etatEnvoye;
        }
        part coupure : CoupureElectrique {
            event occurrence protectionRecue;
        }
        part flottabilite : DispositifFlottabilite {
            event occurrence gonflageRecu;
            then event occurrence etatFlottEnvoye;
            then event occurrence degonflageRecu;
        }
        part propulsion : PropulsionAquatique {
            event occurrence deplacementRecu;
        }
        part station : StationControle {
            event occurrence alerteRecue;
            then event occurrence alerteAffichee;
            then event occurrence commandeRecue;
            then event occurrence commandeEnvoyee;
            then event occurrence solSecRecu;
            then event occurrence solSecEnvoye;
            then event occurrence etatRecu;
        }
        part telepilote : Telepilote {
            event occurrence alerteVue;
            then event occurrence commandeEnvoyee;
            then event occurrence solSecEnvoye;
        }

        message m1 of ContactEau from eau.contactEnvoye to detecteur.contactRecu;
        then message m2 of SignalImmersion from detecteur.signalEnvoye to controle.signalRecu;
        then message m3 of OrdreProtection from controle.protectionEnvoyee to coupure.protectionRecue;
        then message m4 of OrdreGonflage from controle.gonflageEnvoye to flottabilite.gonflageRecu;
        then message m5 of EtatFlottabilite from flottabilite.etatFlottEnvoye to controle.etatFlottRecu;
        then message m6 of AlerteModeAquatique from controle.alerteEnvoyee to station.alerteRecue;
        then message m7 of AlerteModeAquatique from station.alerteAffichee to telepilote.alerteVue;
        then message m8 of Commande from telepilote.commandeEnvoyee to station.commandeRecue;
        then message m9 of Commande from station.commandeEnvoyee to controle.commandeRecue;
        then message m10 of OrdreDeplacement from controle.deplacementEnvoye to propulsion.deplacementRecu;
        then message m11 of ConfirmationSolSec from telepilote.solSecEnvoye to station.solSecRecu;
        then message m12 of ConfirmationSolSec from station.solSecEnvoye to controle.solSecRecu;
        then message m13 of OrdreDegonflage from controle.degonflageEnvoye to flottabilite.degonflageRecu;
        then message m14 of EtatSysteme from controle.etatEnvoye to station.etatRecu;
    }

    // ------------------------------------------------------------
    // Séquence 2 : fausse alerte (flaque, pluie, projection)
    // ------------------------------------------------------------
    occurrence def S2_FausseAlerte {
        doc /* L'immersion n'est pas confirmée : aucun déclenchement,
               l'événement est seulement journalisé à la station. */

        part eau : ZoneInondee {
            event occurrence contactEnvoye;
        }
        part detecteur : DetecteurImmersion {
            event occurrence contactRecu;
            then event occurrence signalEnvoye;
        }
        part controle : UniteControle {
            event occurrence signalRecu;
            then event occurrence etatEnvoye;
        }
        part station : StationControle {
            event occurrence etatRecu;
        }

        message m1 of ContactEau from eau.contactEnvoye to detecteur.contactRecu;
        then message m2 of SignalImmersion from detecteur.signalEnvoye to controle.signalRecu;
        then message m3 of EtatSysteme from controle.etatEnvoye to station.etatRecu;
    }

    // ------------------------------------------------------------
    // Séquence 3 : échec de la flottabilité
    // ------------------------------------------------------------
    occurrence def S3_EchecFlottabilite {
        doc /* Le gonflage ne suffit pas : alerte critique, sauvegarde des
               données et envoi de la dernière position pour la récupération. */

        part eau : ZoneInondee {
            event occurrence contactEnvoye;
        }
        part detecteur : DetecteurImmersion {
            event occurrence contactRecu;
            then event occurrence signalEnvoye;
        }
        part controle : UniteControle {
            event occurrence signalRecu;
            then event occurrence protectionEnvoyee;
            then event occurrence gonflageEnvoye;
            then event occurrence etatFlottRecu;
            then event occurrence alerteEnvoyee;
        }
        part coupure : CoupureElectrique {
            event occurrence protectionRecue;
        }
        part flottabilite : DispositifFlottabilite {
            event occurrence gonflageRecu;
            then event occurrence etatFlottEnvoye;
        }
        part station : StationControle {
            event occurrence alerteRecue;
            then event occurrence alerteAffichee;
        }
        part telepilote : Telepilote {
            event occurrence alerteVue;
        }

        message m1 of ContactEau from eau.contactEnvoye to detecteur.contactRecu;
        then message m2 of SignalImmersion from detecteur.signalEnvoye to controle.signalRecu;
        then message m3 of OrdreProtection from controle.protectionEnvoyee to coupure.protectionRecue;
        then message m4 of OrdreGonflage from controle.gonflageEnvoye to flottabilite.gonflageRecu;
        then message m5 of EtatFlottabilite from flottabilite.etatFlottEnvoye to controle.etatFlottRecu;
        then message m6 of AlerteCritique from controle.alerteEnvoyee to station.alerteRecue;
        then message m7 of AlerteCritique from station.alerteAffichee to telepilote.alerteVue;
    }

    // ------------------------------------------------------------
    // Séquence 4 : batterie faible pendant la navigation en surface
    // ------------------------------------------------------------
    occurrence def S4_BatterieFaible {
        doc /* En mode aquatique, la batterie devient faible : le télépilote
               est alerté et ramène le rover vers la rive la plus proche. */

        part energie : GestionEnergie {
            event occurrence niveauEnvoye;
        }
        part controle : UniteControle {
            event occurrence niveauRecu;
            then event occurrence alerteEnvoyee;
            then event occurrence commandeRecue;
            then event occurrence deplacementEnvoye;
        }
        part propulsion : PropulsionAquatique {
            event occurrence deplacementRecu;
        }
        part station : StationControle {
            event occurrence alerteRecue;
            then event occurrence alerteAffichee;
            then event occurrence commandeRecue;
            then event occurrence commandeEnvoyee;
        }
        part telepilote : Telepilote {
            event occurrence alerteVue;
            then event occurrence commandeEnvoyee;
        }

        message m1 of NiveauBatterie from energie.niveauEnvoye to controle.niveauRecu;
        then message m2 of AlerteCritique from controle.alerteEnvoyee to station.alerteRecue;
        then message m3 of AlerteCritique from station.alerteAffichee to telepilote.alerteVue;
        then message m4 of Commande from telepilote.commandeEnvoyee to station.commandeRecue;
        then message m5 of Commande from station.commandeEnvoyee to controle.commandeRecue;
        then message m6 of OrdreDeplacement from controle.deplacementEnvoye to propulsion.deplacementRecu;
    }
}