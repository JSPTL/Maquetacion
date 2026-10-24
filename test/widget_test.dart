import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maquetacion_interactiva/main.dart';
import 'package:maquetacion_interactiva/screens/home_screen.dart';
import 'package:maquetacion_interactiva/screens/login_screen.dart';

Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(390, 844);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MaquetacionApp());
  await tester.pumpAndSettle();
}

Finder inputField(String label) => find.descendant(
  of: find.widgetWithText(AppInput, label),
  matching: find.byType(TextField),
);

void main() {
  setUpAll(() async {
    final loader = FontLoader('Inter');
    for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
      loader.addFont(rootBundle.load('assets/fonts/Inter-$weight.ttf'));
    }
    await loader.load();
  });

  testWidgets('La app arranca en Login con barra de estado', (tester) async {
    await pumpApp(tester);

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.byType(AppStatusBar), findsOneWidget);
  });

  testWidgets('Correo inválido muestra error y no avanza', (tester) async {
    await pumpApp(tester);

    await tester.enterText(inputField('Correo electrónico'), 'usuario@correo');
    await tester.enterText(inputField('Contraseña'), 'clave');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(
      find.text('Ingresa un correo válido (ejemplo: usuario@dominio.com)'),
      findsOneWidget,
    );
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Login válido abre Home con el correo y cierra sesión', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.enterText(
      inputField('Correo electrónico'),
      'usuario@dominio.com',
    );
    await tester.enterText(inputField('Contraseña'), 'clave');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('usuario@dominio.com'), findsOneWidget);

    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Google muestra "Funcionalidad no disponible"', (tester) async {
    await pumpApp(tester);

    await tester.ensureVisible(find.text('Google'));
    await tester.tap(find.text('Google'));
    await tester.pump();

    expect(find.text('Funcionalidad no disponible'), findsOneWidget);
  });
}
