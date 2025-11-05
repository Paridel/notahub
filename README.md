# NotaHub

Application Flutter - Liste des Étudiants (Correction et Tests)

### Enoncé :
Vous êtes chargé de créer une application Flutter simple pour afficher une liste d'étudiants et leurs notes. Cependant, le code fourni comporte des erreurs intentionnelles que vous devez corriger en utilisant les outils de débogage de Flutter. Une fois les erreurs corrigées, vous devriez créer des tests unitaire, d’intégration et de Widgets.

## Analyse des Erreurs Trouvées

Voici les erreurs identifiées dans le code :

### Erreur 1 : Widget incorrect dans le body du Scaffold

Localisation : PageAccueil, méthode build()
Problème : Utilisation de Padding avec les propriétés mainAxisAlignment et crossAxisAlignment qui n'existent pas pour ce widget
Solution : Remplacer Padding par Column enveloppé dans un Padding

### Erreur 2 : Variable redéclarée dans calculateMoyenne()

Localisation : Méthode calculateMoyenne()
Problème : var total = 0; redéclare la variable total dans la boucle au lieu de l'utiliser
Solution : Supprimer le var dans la boucle

### Erreur 3 : Cast incorrect

Localisation : Méthode calculateMoyenne()
Problème : etudiant.moyenne as int tente de caster un double en int
Solution : Supprimer le cast et utiliser directement le double

### Erreur 4 : Initialisation incorrecte

Localisation : Méthode calculateMoyenne()
Problème : var total = 0; initialise avec un int au lieu d'un double
Solution : Utiliser 0.0 pour initialiser comme double


## Résumé des Corrections
Les 4 erreurs principales ont été corrigées:

Structure du Widget: Remplacement de Padding par Column enveloppé dans Padding
Redéclaration: Suppression du var dans la boucle
Cast invalide: Suppression du cast as int
Type incorrect: Utilisation de 0.0 au lieu de 0

L'application fonctionne maintenant correctement et calcule la moyenne de 14.35 pour les 5 étudiants!

Quelques ressources pour vous aider à démarrer si c'est votre premier projet Flutter :

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

Pour obtenir de l'aide pour démarrer avec le développement Flutter, consultez la
[documentation en ligne](https://docs.flutter.dev/), qui propose des tutoriels, des
exemples, des conseils sur le développement mobile et une référence API complète.
