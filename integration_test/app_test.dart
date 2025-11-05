import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notahub/main.dart' as app;
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Tests d\'Intégration - Flux complet de l\'application', () {
    testWidgets('Scénario complet: Affichage, navigation et calcul de moyenne',
            (WidgetTester tester) async {

          app.main();
          await tester.pumpAndSettle();

          expect(find.text('Liste des étudiants'), findsOneWidget);
          expect(find.text('Nom: Alice'), findsOneWidget);
          expect(find.byType(ListTile), findsNWidgets(5));

          await tester.drag(
            find.byType(ListView),
            const Offset(0, -300),
          );
          await tester.pumpAndSettle();

          expect(find.text('Nom: Eve'), findsOneWidget);

          await tester.tap(find.text('Calculer la moyenne de la classe'));
          await tester.pumpAndSettle();

          expect(find.text('Moyenne des étudiants'), findsOneWidget);
          expect(find.textContaining('14.35'), findsOneWidget);

          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();

          await tester.drag(
            find.byType(ListView),
            const Offset(0, 300),
          );
          await tester.pumpAndSettle();

          await tester.tap(find.text('Nom: Alice').first);
          await tester.pumpAndSettle();


          expect(find.text('Détails de l\'étudiant'), findsOneWidget);
          expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
          expect(find.text('Moyenne : 17.25'), findsOneWidget);


          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();

          expect(find.text('Liste des étudiants'), findsOneWidget);
        });

    testWidgets('Navigation vers tous les étudiants', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final etudiants = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
      final moyennes = ['17.25', '16.5', '11.75', '12.75', '13.5'];

      for (int i = 0; i < etudiants.length; i++) {

        if (i > 0) {
          await tester.tap(find.byType(BackButton));
          await tester.pumpAndSettle();
        }

        if (i > 2) {
          await tester.drag(
            find.byType(ListView),
            const Offset(0, -200),
          );
          await tester.pumpAndSettle();
        }

        await tester.tap(find.text('Nom: ${etudiants[i]}').first);
        await tester.pumpAndSettle();

        expect(find.text('Nom de l\'étudiant : ${etudiants[i]}'), findsOneWidget);
        expect(find.text('Moyenne : ${moyennes[i]}'), findsOneWidget);
      }
    });

    testWidgets('Test de la persistance après plusieurs interactions',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          for (int i = 0; i < 3; i++) {
            await tester.tap(find.text('Calculer la moyenne de la classe'));
            await tester.pumpAndSettle();

            expect(find.textContaining('14.35'), findsOneWidget);

            await tester.tap(find.text('OK'));
            await tester.pumpAndSettle();
          }

          for (int i = 0; i < 2; i++) {
            await tester.tap(find.text('Nom: Bob'));
            await tester.pumpAndSettle();

            expect(find.text('Nom de l\'étudiant : Bob'), findsOneWidget);

            await tester.tap(find.byType(BackButton));
            await tester.pumpAndSettle();

            expect(find.text('Liste des étudiants'), findsOneWidget);
          }

          expect(find.byType(ListTile), findsNWidgets(5));
        });

    testWidgets('Test de défilement complet de la liste',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          await tester.drag(
            find.byType(ListView),
            const Offset(0, -500),
          );
          await tester.pumpAndSettle();

          expect(find.text('Nom: Eve'), findsOneWidget);

          await tester.drag(
            find.byType(ListView),
            const Offset(0, 500),
          );
          await tester.pumpAndSettle();

          expect(find.text('Nom: Alice'), findsOneWidget);
        });
  });

  group('Tests d\'Intégration - Cas limites', () {
    testWidgets('Navigation rapide entre les pages', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Nom: Alice').first);
      await tester.pump(const Duration(milliseconds: 100));

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.text('Liste des étudiants'), findsOneWidget);
    });

    testWidgets('Ouverture et fermeture rapide du dialogue',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          await tester.tap(find.text('Calculer la moyenne de la classe'));
          await tester.pump(const Duration(milliseconds: 100));

          await tester.tap(find.text('OK'));
          await tester.pumpAndSettle();

          expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);
        });
  });
}