package exigences_ROVLibre {

    private import contexte_ROVLibre::definitions::*;

    // ===== Exigences fonctionnelles de base
    package fonctionnelles {
        requirement <'EF1'> deplacementTousTerrains {
            subject systeme : ROVLibre;
            doc /* Le système doit se déplacer sur béton, gravats, terre, boue,
                   pentes jusqu'à 30° et escaliers (à valider). */
        }
        requirement <'EF2'> navigationAutonome {
            subject systeme : ROVLibre;
            doc /* Le système doit se localiser et cartographier la zone sans GPS,
                   et progresser seul vers un objectif désigné. */
        }
        requirement <'EF3'> perteLiaison {
            subject systeme : ROVLibre;
            doc /* En cas de perte de liaison, le rover doit s'immobiliser en
                   sécurité puis tenter de revenir au dernier point de liaison. */
        }
        requirement <'EF4'> observationToutTemps {
            subject systeme : ROVLibre;
            doc /* Le système doit fournir une image exploitable de jour, de nuit
                   et à travers la fumée. */
        }
        requirement <'EF5'> detectionAutomatique {
            subject systeme : ROVLibre;
            doc /* Le système doit signaler automatiquement obstacles, anomalies
                   et silhouettes humaines à l'analyste. */
        }
        requirement <'EF6'> transmissionTempsReel {
            subject systeme : ROVLibre;
            doc /* Le système doit transmettre images, mesures et position de façon
                   chiffrée, avec une latence vidéo inférieure à 300 ms (à valider). */
        }
        requirement <'EF7'> conservationDonnees {
            subject systeme : ROVLibre;
            doc /* Les données de mission doivent être conservées à la station de
                   contrôle même si le rover n'est pas récupéré. */
        }
    }

    // ===== Exigences liées aux innovations
    package innovantes {
        requirement <'EI1'> detectionImmersion {
            subject systeme : ROVLibre;
            doc /* FI1 : le rover doit détecter seul une immersion et acquérir une
                   flottabilité positive en moins de 2 s (à valider), avant que l'eau
                   n'atteigne ses organes électriques. */
        }
        requirement <'EI2'> absenceDeclenchementIntempestif {
            subject systeme : ROVLibre;
            doc /* FI1 ne doit jamais se déclencher sous l'effet d'une flaque, de la
                   pluie, d'une projection d'eau, d'un choc ou du stockage. */
        }
        requirement <'EI3'> navigationSurface {
            subject systeme : ROVLibre;
            doc /* En mode aquatique, le rover doit rester stable sans se retourner,
                   capteurs hors de l'eau, dans un courant jusqu'à 1 m/s (à valider). */
        }
        requirement <'EI4'> retourModeTerrestre {
            subject systeme : ROVLibre;
            doc /* Sur un sol sec, le rover doit retrouver sa configuration terrestre
                   sur commande ou confirmation du télépilote. */
        }
        requirement <'EI5'> infiltrationFissure {
            subject systeme : ROVLibre;
            doc /* FI2 : le moyen d'observation doit passer dans une fissure de 5 mm
                   (à valider) et se déployer sur au moins 1 m (à valider). */
        }
        requirement <'EI6'> inspectionSansPerturbation {
            subject systeme : ROVLibre;
            doc /* FI2 : le déploiement ne doit pas déplacer les débris, et l'image
                   doit rester exploitable dans l'obscurité et la poussière. */
        }
        requirement <'EI7'> replisSur {
            subject systeme : ROVLibre;
            doc /* FI2 : le moyen d'observation doit être replié et rangé sans rester
                   coincé ni être perdu. */
        }
    }

    // ===== Environnement et robustesse (FB6)
    package environnement {
        requirement <'EE1'> etancheite {
            subject systeme : ROVLibre;
            doc /* Le rover doit être protégé contre la poussière et l'immersion
                   temporaire (indice IP67, à valider). */
        }
        requirement <'EE2'> temperatureStockage {
            subject systeme : ROVLibre;
            doc /* Le système doit supporter un stockage entre -20 °C et +60 °C,
                   sans dégradation ni déclenchement de FI1 et FI2. */
        }
        requirement <'EE3'> resistanceChocs {
            subject systeme : ROVLibre;
            doc /* Le système doit résister aux vibrations du transport routier et
                   aux chocs de la manutention sur terrain accidenté. */
        }
    }

    // ===== Contraintes de mise en œuvre et réglementaires
    package contraintes {
        requirement <'EC1'> transportabilite {
            subject systeme : ROVLibre;
            doc /* Le système doit être transportable par deux personnes, avec une
                   masse du rover inférieure à 40 kg (à valider). */
        }
        requirement <'EC2'> miseEnOeuvreRapide {
            subject systeme : ROVLibre;
            doc /* Le rover doit être opérationnel en moins de 5 min (à valider),
                   manipulable avec des gants, auto-test compris. */
        }
        requirement <'EC3'> autonomie {
            subject systeme : ROVLibre;
            doc /* Le rover doit avoir une autonomie d'au moins 2 h (à valider),
                   avec une batterie remplaçable sur le terrain. */
        }
        requirement <'EC4'> reglementation {
            subject systeme : ROVLibre;
            doc /* Le système doit respecter le règlement Machines, les directives RED
                   et CEM, le règlement Batteries et, pour les sites à risque, ATEX. */
        }
        requirement <'EC5'> nonArme {
            subject systeme : ROVLibre;
            doc /* Le système ne doit embarquer aucune arme. */
        }
    }
}