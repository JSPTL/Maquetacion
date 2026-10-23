# Maquetación interactiva

---

### 1. Maquetación de las pantallas del diseño

| # | Pantalla | Elementos maquetados |
|---|----------|----------------------|
| 1 | **Inicio de sesión** | Logo con candado en degradado, título "Bienvenido de nuevo", inputs de correo y contraseña (con ojo para mostrar/ocultar), enlace "¿Olvidaste tu contraseña?", botón "Iniciar sesión", separador "o continúa con", botones Google y Apple, pie "¿No tienes cuenta? Regístrate". |
| 2 | **Registro** | Botón atrás, "Crea tu cuenta", inputs de nombre, correo, contraseña y confirmación, casilla de Términos y condiciones / Política de privacidad, botón "Crear cuenta", pie "¿Ya tienes cuenta? Inicia sesión". |
| 3 | **Home** | Avatar circular en degradado, "¡Bienvenido!", píldora con el correo del usuario y botón "Cerrar sesión". |
| 4 | **Recuperar contraseña** | Ícono de correo azul, "¿Olvidaste tu contraseña?", input de correo, botón "Enviar código", pie "¿La recordaste? Inicia sesión". |
| 5 | **Código de verificación** | Ícono de escudo naranja, "Verifica tu correo" con el correo ingresado, 4 casillas de un dígito, contador "Reenviar código en 00:45" y botón "Siguiente". |
| 6 | **Nueva contraseña** | Etiqueta verde "Código verificado", ícono de candado, inputs de nueva contraseña y confirmación, lista de requisitos que se marcan en tiempo real y botón "Restablecer contraseña". |
| — | **Componentes** | Input (normal, con error y contraseña), Botón (principal, secundario y deshabilitado) y Casilla de código (con dígito, vacía y enfocada). |

Cada pantalla tiene sus **formas decorativas** del diseño (burbujas con
degradado, aros, punto amarillo y cuadros redondeados girados), ubicadas en
proporción al tamaño de la ventana.

---

## Herramientas y recursos utilizados

| Herramienta | Uso |
|-------------|-----|
| **Flutter** y **Dart 3** | Framework y lenguaje de la app. |
| **Material 3** (`ThemeData`, `ColorScheme.fromSeed`) | Tema base de la aplicación. |
| **Fuente Inter** (`assets/fonts`, licencia SIL OFL) | Tipografía del diseño en pesos 400, 500, 600 y 700. |
| **Figma** (imagen del diseño) | Referencia de medidas, colores, textos y formas. |
| **Visual Studio 2022** con "Desarrollo para el escritorio con C++" | Necesario para compilar la app de Windows. |
| `LinearGradient` y `BoxShadow` | Botones, íconos, avatar y burbujas en degradado. |
| `Stack` + `Positioned` + `LayoutBuilder` | Formas decorativas ubicadas en proporción a la ventana. |
| `CustomScrollView` + `SliverFillRemaining` | Contenido desplazable con el pie siempre abajo. |
| `Navigator` + `MaterialPageRoute` | Navegación entre pantallas. |
| `TextField`, `TextInputFormatter`, `FocusNode` | Inputs, casillas de un dígito y paso automático entre casillas. |
| `Timer` | Contador de 45 segundos para reenviar el código. |
| `SnackBar` | Mensajes de éxito, error e información. |
| `flutter_test` | Pruebas de la interfaz. |

---

### Cuenta de prueba

| Correo               | Contraseña  |
| -------------------- | ----------- |
| `usuario@correo.com` | `Password1` |

También se puede crear una cuenta desde Registro. No hay backend: los usuarios
se guardan en memoria mientras la app está abierta.

---

## Estructura del proyecto

```
lib/
  main.dart                      App, tema, colores, tipografía, validaciones,
                                 mensajes, datos en memoria y componentes
                                 reutilizables (AppInput, AppButton, CodeBox,
                                 AuthLayout, fondo decorativo, etc.).
  screens/
    login_screen.dart            1 · Inicio de sesión
    register_screen.dart         2 · Registro
    home_screen.dart             3 · Home
    forgot_password_screen.dart  4 · Recuperar contraseña
    verify_code_screen.dart      5 · Código de verificación
    new_password_screen.dart     6 · Nueva contraseña
    components_screen.dart       Componentes
assets/fonts/                    Fuente Inter.
windows/                         Proyecto de escritorio de Windows.
test/widget_test.dart            Pruebas de la interfaz.

```

## Validaciones

- **Correo:** obligatorio y con formato `usuario@dominio.com`.
- **Login:** contraseña obligatoria; si no coincide se muestra
  "Correo o contraseña incorrectos".
- **Registro:** nombre obligatorio, contraseña de mínimo 8 caracteres,
  confirmación igual y correo no registrado. "Crear cuenta" se habilita al
  aceptar los términos.
- **Código de verificación:** "Siguiente" se habilita con los 4 dígitos;
  "Reenviar código" se activa cuando el contador llega a cero.
- **Nueva contraseña:** mínimo 8 caracteres, una mayúscula y un número;
  el botón se habilita cuando se cumplen y ambas contraseñas coinciden.
- Los botones Google y Apple muestran "Funcionalidad no disponible".