import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notahub/main.dart';

void main() {
  group('Tests de Widgets - PageAccueil', () {
    testWidgets('Affichage du titre de l\'application', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(find.text('Liste des étudiants'), findsOneWidget);
    });

    testWidgets('Affichage de la liste des étudiants', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(find.text('Nom: Alice'), findsOneWidget);
      expect(find.text('Nom: Bob'), findsOneWidget);
      expect(find.text('Nom: Charlie'), findsOneWidget);
      expect(find.text('Nom: David'), findsOneWidget);
      expect(find.text('Nom: Eve'), findsOneWidget);
    });

    testWidgets('Affichage des moyennes des étudiants', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(find.text('Moyenne : 17.25'), findsOneWidget);
      expect(find.text('Moyenne : 16.5'), findsOneWidget);
      expect(find.text('Moyenne : 11.75'), findsOneWidget);
    });

    testWidgets('Présence du bouton de calcul de moyenne', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Affichage du texte d\'introduction', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(
        find.text('Liste des étudiants et de leurs moyennes :'),
        findsOneWidget,
      );
    });

    testWidgets('Présence de 5 étudiants dans la liste', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      expect(find.byType(ListTile), findsNWidgets(5));
    });

    testWidgets('Les containers ont un style approprié', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsWidgets);
    });
  });

  group('Tests de Widgets - Interaction avec le bouton', () {
    testWidgets('Clic sur le bouton affiche le dialogue', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      expect(find.text('Moyenne des étudiants'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('Le dialogue affiche la moyenne correcte', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      expect(find.textContaining('14.35'), findsOneWidget);
    });

    testWidgets('Fermeture du dialogue avec le bouton OK', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Calculer la moyenne de la classe'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Moyenne des étudiants'), findsNothing);
    });
  });

  group('Tests de Widgets - Navigation', () {
    testWidgets('Clic sur un étudiant navigue vers la page de détails', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Nom: Alice').first);
      await tester.pumpAndSettle();

      expect(find.text('Détails de l\'étudiant'), findsOneWidget);
      expect(find.text('Nom de l\'étudiant : Alice'), findsOneWidget);
      expect(find.text('Moyenne : 17.25'), findsOneWidget);
    });

    testWidgets('La page de détails affiche les bonnes informations', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Nom: Bob'));
      await tester.pumpAndSettle();

      expect(find.text('Nom de l\'étudiant : Bob'), findsOneWidget);
      expect(find.text('Moyenne : 16.5'), findsOneWidget);
    });

    testWidgets('Retour depuis la page de détails', (WidgetTester tester) async {
      await tester.pumpWidget(MonApplication());

      await tester.tap(find.text('Nom: Charlie'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(find.text('Liste des étudiants'), findsOneWidget);
      expect(find.text('Calculer la moyenne de la classe'), findsOneWidget);
    });
  });

  group('Tests de Widgets - DetailPage', () {
    testWidgets('DetailPage affiche correctement les informations', (WidgetTester tester) async {
      final etudiant = Etudiant(nom: 'Test', moyenne: 15.5);

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(),
                          settings: RouteSettings(arguments: etudiant),
                        ),
                      );
                    },
                    child: Text('Go'),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Go'));
      await tester.pumpAndSettle();

      expect(find.text('Nom de l\'étudiant : Test'), findsOneWidget);
      expect(find.text('Moyenne : 15.5'), findsOneWidget);
    });
  });
}