package sequences_remettreEnEtat {

    // ===== Acteur et blocs fonctionnels
    part def Technicien;
    part def DispositifFlottabilite;
    part def GestionEnergie;
    part def StationControle;
    part def UniteControle;

    // ===== Messages échangés
    item def Rearmement;
    item def Recharge;
    item def DemandeAutoTest;
    item def DemandeEtat;
    item def EtatFlottabilite;
    item def NiveauBatterie;
    item def RapportAutoTest;

    occurrence def S1_RemiseEnEtatNominale {
        doc /* Après une mission avec usage de FI1 : le technicien réarme la
               flottabilité, recharge la batterie et lance l'auto-test, qui réussit. */

        part technicien : Technicien {
            event occurrence rearmementEnvoye;
            then event occurrence rechargeEnvoyee;
            then event occurrence autoTestDemande;
            then event occurrence rapportVu;
        }
        part flottabilite : DispositifFlottabilite {
            event occurrence rearmementRecu;
            then event occurrence demandeRecue;
            then event occurrence etatEnvoye;
        }
        part energie : GestionEnergie {
            event occurrence rechargeRecue;
            then event occurrence demandeRecue;
            then event occurrence niveauEnvoye;
        }
        part station : StationControle {
            event occurrence autoTestRecu;
            then event occurrence autoTestEnvoye;
            then event occurrence rapportRecu;
            then event occurrence rapportAffiche;
        }
        part controle : UniteControle {
            event occurrence autoTestRecu;
            then event occurrence demandeFlottEnvoyee;
            then event occurrence etatFlottRecu;
            then event occurrence demandeEnergieEnvoyee;
            then event occurrence niveauRecu;
            then event occurrence rapportEnvoye;
        }

        message m1 of Rearmement from technicien.rearmementEnvoye to flottabilite.rearmementRecu;
        then message m2 of Recharge from technicien.rechargeEnvoyee to energie.rechargeRecue;
        then message m3 of DemandeAutoTest from technicien.autoTestDemande to station.autoTestRecu;
        then message m4 of DemandeAutoTest from station.autoTestEnvoye to controle.autoTestRecu;
        then message m5 of DemandeEtat from controle.demandeFlottEnvoyee to flottabilite.demandeRecue;
        then message m6 of EtatFlottabilite from flottabilite.etatEnvoye to controle.etatFlottRecu;
        then message m7 of DemandeEtat from controle.demandeEnergieEnvoyee to energie.demandeRecue;
        then message m8 of NiveauBatterie from energie.niveauEnvoye to controle.niveauRecu;
        then message m9 of RapportAutoTest from controle.rapportEnvoye to station.rapportRecu;
        then message m10 of RapportAutoTest from station.rapportAffiche to technicien.rapportVu;
    }
}