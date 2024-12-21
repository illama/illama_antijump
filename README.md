Saut Limité pour FiveM

Un script visant à limiter les sauts pour rendre les mouvements des joueurs plus réalistes sur les serveurs FiveM. Compatible avec ESX et facilement configurable.
Fonctionnalités

    Limitation du délai entre les sauts.
    Gestion des sauts en fonction des actions (course, escalade, véhicule).
    Notifications informant les joueurs des restrictions.
    Configuration facile pour ajuster les délais et les paramètres.

Installation

    Téléchargement : Téléchargez le script et placez-le dans le dossier resources de votre serveur.
    Ajout au server.cfg :

    ensure saut_limite

    Configuration : Modifiez les paramètres dans le fichier config.lua pour adapter les limites à vos besoins.

Configuration

Le script est entièrement configurable grâce aux paramètres suivants :

Config = {
    MaxJumpsWhileRunning = 2,          -- Nombre maximum de sauts autorisés pendant la course.
    JumpResetTime = 5000,             -- Temps en ms avant de réinitialiser le compteur de sauts.
    MinimumSpeedForCheck = 3.0,       -- Vitesse minimale pour considérer que le joueur court.
    EnableNotifications = true,       -- Active/désactive les notifications (affichées via ESX).
    MinimumJumpDelay = 10000          -- Délai minimum entre deux sauts (en ms).
}

Fonctionnement

    Limite des sauts :
        Le saut est temporairement désactivé si le joueur tente de sauter avant la fin du délai défini.
        Un message est affiché pour notifier le joueur.

    Actions spécifiques :
        Le saut est désactivé uniquement lorsque le joueur court ou effectue des actions particulières (hors escalade).

    Notifications :
        Les messages peuvent être affichés via ESX ou dans la console (mode débogage).

Dépendances

    ESX Legacy pour la gestion des notifications (facultatif).
    Aucun autre module requis.

Crédits

Développé par Illama.
