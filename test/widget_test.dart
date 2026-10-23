import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maquetacion_interactiva/main.dart';
import 'package:maquetacion_interactiva/screens/components_screen.dart';
import 'package:maquetacion_interactiva/screens/home_screen.dart';
import 'package:maquetacion_interactiva/screens/login_screen.dart';

Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1280, 720);
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

  testWidgets('La app arranca en Login', (tester) async {
    await pumpApp(tester);

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
  });

  testWidgets('Credenciales incorrectas muestran un error', (tester) async {
    await pumpApp(tester);

    await tester.enterText(inputField('Correo electrónico'), 'otro@correo.com');
    await tester.enterText(inputField('Contraseña'), 'Incorrecta1');
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.text(LoginScreen.wrongCredentialsMessage), findsWidgets);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Login con la cuenta demo abre Home y cierra sesión', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.enterText(
      inputField('Correo electrónico'),
      AuthStore.demoEmail,
    );
    await tester.enterText(inputField('Contraseña'), AuthStore.demoPassword);
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text(AuthStore.demoEmail), findsOneWidget);

    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Mantener presionado el logo abre Componentes', (tester) async {
    await pumpApp(tester);

    await tester.longPress(find.byType(GradientIconBadge));
    await tester.pumpAndSettle();

    expect(find.byType(ComponentsScreen), findsOneWidget);
  });
}
