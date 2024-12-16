# Socle Laravel

Ce projet est une application Laravel basé sur Docker.

## Prérequis

Assurez-vous d'avoir les logiciels suivants installés sur votre machine :

- [Docker](https://www.docker.com/get-started)
- [Composer](https://getcomposer.org/)
- [Docker Compose](https://docs.docker.com/compose/install/) 

## Installation

Suivez ces étapes pour déployer le projet sur votre machine :

### Étape 1 : Configuration des variables d'environnement 

Copier le contenu du fichier .env.dev vers le fichier .env à la racine  :

```bash
cp .env.dev .env
```
Copier le contenu du fichier docker-compose-dev.yml vers le fichier docker-compose.yml à la racine  :

```bash
cp docker-compose-dev.yml docker-compose.yml
```
NB : -Si vous êtes en prod, il faut utiliser les fichier de la version prod (docker-compose-prod.yml, .env.prod ...)

### Étape 2 : Installation de laravel et  démarrage des conteneurs Docker en arrière-plan 

Exécutez la commande suivante pour commencer :

```bash
bash start.sh
```

NB : -Si vous rencontrez des problèmes de port avec PostgreSQL ou autre conteneur , modifiez les ports ou fermez l'application qui utilise le port en conflit.