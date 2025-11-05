import 'package:flutter_test/flutter_test.dart';
import 'package:notahub/main.dart';

void main() {
  group('Tests Unitaires - Classe Etudiant', () {
    test('Création d\'un étudiant avec nom et moyenne', () {
      final etudiant = Etudiant(nom: 'Alice', moyenne: 17.25);

      expect(etudiant.nom, 'Alice');
      expect(etudiant.moyenne, 17.25);
    });

    test('Moyenne doit être un double', () {
      final etudiant = Etudiant(nom: 'Bob', moyenne: 16.5);

      expect(etudiant.moyenne, isA<double>());
    });
  });

  group('Tests Unitaires - Calcul de Moyenne', () {
    late PageAccueil pageAccueil;

    setUp(() {
      pageAccueil = PageAccueil();
    });

    test('Calcul de moyenne avec liste normale', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 17.25),
        Etudiant(nom: 'Bob', moyenne: 16.5),
        Etudiant(nom: 'Charlie', moyenne: 11.75),
        Etudiant(nom: 'David', moyenne: 12.75),
        Etudiant(nom: 'Eve', moyenne: 13.5),
      ];

      final moyenne = pageAccueil.calculateMoyenne(etudiants);

      expect(moyenne, closeTo(14.35, 0.01));
    });

    test('Calcul de moyenne avec un seul étudiant', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 15.0),
      ];

      final moyenne = pageAccueil.calculateMoyenne(etudiants);

      expect(moyenne, 15.0);
    });

    test('Calcul de moyenne avec des notes entières', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 10.0),
        Etudiant(nom: 'Bob', moyenne: 20.0),
      ];

      final moyenne = pageAccueil.calculateMoyenne(etudiants);

      expect(moyenne, 15.0);
    });

    test('Calcul de moyenne avec des notes décimales', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 12.33),
        Etudiant(nom: 'Bob', moyenne: 14.67),
        Etudiant(nom: 'Charlie', moyenne: 13.00),
      ];

      final moyenne = pageAccueil.calculateMoyenne(etudiants);

      expect(moyenne, closeTo(13.33, 0.01));
    });

    test('Le résultat doit être un double', () {
      final etudiants = [
        Etudiant(nom: 'Alice', moyenne: 10.0),
        Etudiant(nom: 'Bob', moyenne: 20.0),
      ];

      final moyenne = pageAccueil.calculateMoyenne(etudiants);

      expect(moyenne, isA<double>());
    });
  });
}