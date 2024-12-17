# Socle Laravel

Ce projet est une application Laravel basé sur Docker.

## Prérequis

Assurez-vous d'avoir les logiciels suivants installés sur votre machine :

- [Docker](https://www.docker.com/get-started)
- [Composer](https://getcomposer.org/)
- [Docker Compose](https://docs.docker.com/compose/install/) 

## Installation

Suivez ces étapes pour déployer le projet sur votre machine :

### Étape 1 : Installation de laravel et  démarrage des conteneurs Docker en arrière-plan 

Exécutez la commande suivante pour commencer :

Si environnement de développement :
```bash
bash start.sh dev
```

Si environnement de production :
```bash
bash start.sh prod
```

NB : -Si vous rencontrez des problèmes de port avec PostgreSQL ou un autre conteneur, vous pouvez soit modifier les ports dans le fichier .env à la racine, soit fermer l’application qui utilise le port en conflit.
