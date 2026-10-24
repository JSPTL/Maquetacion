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

Cada pantalla tiene la **barra de estado** (9:41, señal, wifi y batería) y sus **formas decorativas** del diseño (burbujas con
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

### Datos

No hay backend: cualquier correo con formato válido y una contraseña permiten
entrar. El correo ingresado en Login o Registro se guarda en memoria y se
muestra en Home. La ventana de Windows abre en formato móvil (390 × 844).

---

## Estructura del proyecto

```
lib/
  main.dart                      App, tema, colores, tipografía, validaciones,
                                 mensajes, datos compartidos y componentes
                                 reutilizables (AppInput, AppButton, CodeBox,
                                 AuthLayout, barra de estado, fondo decorativo).
  screens/
    login_screen.dart            1 · Inicio de sesión
    register_screen.dart         2 · Registro
    home_screen.dart             3 · Home
    forgot_password_screen.dart  4 · Recuperar contraseña
    verify_code_screen.dart      5 · Código de verificación
    new_password_screen.dart     6 · Nueva contraseña
assets/fonts/                    Fuente Inter.
windows/                         Proyecto de escritorio de Windows.
test/widget_test.dart            Pruebas de la interfaz.

```

## Validaciones

- **Correo:** obligatorio y con formato `usuario@dominio.com`.
- **Campos obligatorios:** ningún formulario se envía con campos vacíos.
- **Login:** con correo válido y contraseña lleva a Home.
- **Registro:** la contraseña y su confirmación deben coincidir.
  "Crear cuenta" se habilita al aceptar los términos.
- **Código de verificación:** "Siguiente" se habilita con los 4 dígitos;
  "Reenviar código" se activa cuando el contador llega a cero.
- **Nueva contraseña:** mínimo 8 caracteres, una mayúscula y un número;
  el botón se habilita cuando se cumplen y ambas contraseñas coinciden, y
  regresa a Login con un mensaje de éxito.
- Los botones Google y Apple muestran "Funcionalidad no disponible".