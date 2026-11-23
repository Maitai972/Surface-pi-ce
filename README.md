# Surface pièce — outil terrain

Outil personnel (PWA hors ligne) pour dessiner le contour d'une pièce et calculer sa surface à partir des mesures relevées (triangulation + formule de Héron).

**Application en ligne :** https://maitai972.github.io/Surface-pi-ce/

## Installer l'application
- **iPhone / iPad (Safari)** : Partager → *Sur l'écran d'accueil*
- **Android (Chrome)** : menu ⋮ → *Installer l'application*
- **PC (Edge / Chrome)** : icône *Installer* dans la barre d'adresse

Après une première ouverture avec Internet, l'app fonctionne sans connexion.
Les données restent stockées localement dans le navigateur de chaque appareil (pas de synchronisation).

## Utilisation locale sous Windows (sans Internet)
Voir `LISEZ-MOI.txt` : double-cliquer sur `lancer-sur-pc.bat` (serveur local sur http://localhost:8765/).

## Fichiers
| Fichier | Rôle |
|---|---|
| `index.html` | Application complète (HTML/CSS/JS autonome) |
| `sw.js` | Service worker (mise en cache hors ligne) |
| `manifest.webmanifest` | Manifeste PWA |
| `icons/` | Icônes 192 et 512 px |
| `lancer-sur-pc.bat`, `serveur-local.ps1` | Lancement local sous Windows |
