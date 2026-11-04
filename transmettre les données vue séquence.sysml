package vue_sequences_TransmettreDonnees {

    private import contexte_ROVLibre::definitions::*;
    private import useCases_ROVLibre::*;

    action def SequenceTransmettreDonnees {
        doc /* Décrit les échanges chronologiques entre le rover et l'analyste. */
        
        // Acteurs impliqués (Lignes de vie)
        part rov : ROVLibre;
        part ana : Analyste;

        // Échanges de messages exploitant l'item "DonneesMission" (images, mesures, position)
        message envoiVideo of DonneesMission from rov to ana {
            doc /* Le rover transmet le flux vidéo de la caméra principale. */
        }
        
        message envoiTelemetrie of DonneesMission from rov to ana {
            doc /* Le rover envoie les données de positionnement et les mesures environnementales. */
        }
        
        message accusReception of EtatSysteme from ana to rov {
            doc /* La station de l'analyste confirme la bonne réception ou demande une retransmission. */
        }
    }
}