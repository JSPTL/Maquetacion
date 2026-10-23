import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/login_screen.dart';

void main() => runApp(const MaquetacionApp());

class MaquetacionApp extends StatelessWidget {
  const MaquetacionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maquetación interactiva',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          error: AppColors.error,
          surface: AppColors.surface,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.primary,
          selectionColor: Color(0x337C3AED),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class AppUser {
  AppUser({required this.name, required this.email, required this.password});

  final String name;
  final String email;
  String password;
}

class AuthStore {
  static const demoEmail = 'usuario@correo.com';
  static const demoPassword = 'Password1';

  final Map<String, AppUser> _users = {
    demoEmail: AppUser(
      name: 'Usuario Demo',
      email: demoEmail,
      password: demoPassword,
    ),
  };

  AppUser? currentUser;
  String? recoveryEmail;

  static String _normalize(String email) => email.trim().toLowerCase();

  bool login(String email, String password) {
    final user = _users[_normalize(email)];
    if (user == null || user.password != password) return false;
    currentUser = user;
    return true;
  }

  bool register({
    required String name,
    required String email,
    required String password,
  }) {
    final key = _normalize(email);
    if (_users.containsKey(key)) return false;
    currentUser = _users[key] = AppUser(
      name: name.trim(),
      email: key,
      password: password,
    );
    return true;
  }

  void startPasswordRecovery(String email) {
    recoveryEmail = _normalize(email);
  }

  void resetPassword(String newPassword) {
    _users[recoveryEmail]?.password = newPassword;
    recoveryEmail = null;
  }

  void logout() => currentUser = null;
}

final authStore = AuthStore();

class AppColors {
  AppColors._();

  static const background = Color(0xFFF8F7FD);
  static const surface = Colors.white;
  static const inputFill = Color(0xFFF9FAFB);

  static const primary = Color(0xFF7C3AED);
  static const link = Color(0xFF5B3FE0);

  static const textPrimary = Color(0xFF16152B);
  static const textSecondary = Color(0xFF6B7280);
  static const label = Color(0xFF1F2937);
  static const hint = Color(0xFF9CA3AF);
  static const border = Color(0xFFE5E7EB);

  static const error = Color(0xFFE11D48);
  static const success = Color(0xFF16A34A);
  static const successBackground = Color(0xFFDCFCE7);

  static const yellow = Color(0xFFFACC15);
  static const ringPurple = Color(0xFF8B5CF6);
  static const ringPink = Color(0xFFF472B6);
  static const ringBlue = Color(0xFF0EA5E9);
}

class AppGradients {
  AppGradients._();

  static const primaryButton = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFEC4899)],
  );

  static const purplePink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFA855F7), Color(0xFFEC4899)],
  );

  static const orangePink = LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [Color(0xFFF97316), Color(0xFFEC4899)],
  );

  static const blue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF38BDF8), Color(0xFF3B82F6)],
  );

  static const orangeSquare = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFBBF24), Color(0xFFF97316)],
  );

  static const softBlue = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFBAE6FD), Color(0xFFC7D2FE)],
  );

  static const softPink = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFCE7F3), Color(0xFFFBCFE8)],
  );

  static const softPeach = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFEF3C7), Color(0xFFFED7AA)],
  );
}

class AppTextStyles {
  AppTextStyles._();

  static const fontFamily = 'Inter';

  static const title = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static const label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.label,
  );

  static const input = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const hint = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    color: AppColors.hint,
  );

  static const error = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w500,
    color: AppColors.error,
  );

  static const button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static const small = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static const link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.link,
  );

  static const codeDigit = TextStyle(
    fontFamily: fontFamily,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}

class Validators {
  Validators._();

  static const minPasswordLength = 8;

  static final _emailRegExp = RegExp(
    r'^[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}$',
  );

  static String? email(String value) {
    if (value.trim().isEmpty) return 'El correo electrónico es obligatorio';
    if (!_emailRegExp.hasMatch(value.trim())) {
      return 'Ingresa un correo válido (ejemplo: usuario@dominio.com)';
    }
    return null;
  }

  static String? fullName(String value) =>
      value.trim().isEmpty ? 'El nombre completo es obligatorio' : null;

  static String? loginPassword(String value) =>
      value.isEmpty ? 'La contraseña es obligatoria' : null;

  static String? newPassword(String value) {
    if (value.isEmpty) return 'La contraseña es obligatoria';
    if (!hasMinLength(value)) {
      return 'La contraseña debe tener mínimo $minPasswordLength caracteres';
    }
    return null;
  }

  static String? confirmPassword(String password, String confirmation) {
    if (confirmation.isEmpty) return 'Confirma tu contraseña';
    if (password != confirmation) return 'Las contraseñas no coinciden';
    return null;
  }

  static bool hasMinLength(String value) => value.length >= minPasswordLength;
  static bool hasUppercase(String value) =>
      value.contains(RegExp(r'[A-ZÁÉÍÓÚÑ]'));
  static bool hasNumber(String value) => value.contains(RegExp(r'[0-9]'));

  static bool meetsAllPasswordRequirements(String value) =>
      hasMinLength(value) && hasUppercase(value) && hasNumber(value);
}

enum AppMessageType { info, success, error }

void showAppMessage(
  BuildContext context,
  String message, {
  AppMessageType type = AppMessageType.info,
}) {
  final (IconData icon, Color color) = switch (type) {
    AppMessageType.info => (Icons.info_outline_rounded, AppColors.primary),
    AppMessageType.success => (
      Icons.check_circle_outline_rounded,
      AppColors.success,
    ),
    AppMessageType.error => (Icons.error_outline_rounded, AppColors.error),
  };
  final width = math.min(420.0, MediaQuery.sizeOf(context).width - 48);

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: width,
        backgroundColor: AppColors.textPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
        content: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.body.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
}

void showFeatureUnavailable(BuildContext context) =>
    showAppMessage(context, 'Funcionalidad no disponible');

void backToLogin(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

enum DecorShapeType { circle, ring, roundedSquare }

class DecorShape {
  const DecorShape.circle({
    required this.x,
    required this.y,
    required this.size,
    this.gradient,
  }) : type = DecorShapeType.circle,
       color = null,
       strokeWidth = 0,
       angle = 0;

  const DecorShape.ring({
    required this.x,
    required this.y,
    required this.size,
    required Color this.color,
    this.strokeWidth = 5,
  }) : type = DecorShapeType.ring,
       gradient = null,
       angle = 0;

  const DecorShape.roundedSquare({
    required this.x,
    required this.y,
    required this.size,
    required this.gradient,
    this.angle = 0,
  }) : type = DecorShapeType.roundedSquare,
       color = null,
       strokeWidth = 0;

  const DecorShape.yellowDot({required this.x, required this.y, this.size = 26})
    : type = DecorShapeType.circle,
      gradient = null,
      color = AppColors.yellow,
      strokeWidth = 0,
      angle = 0;

  final DecorShapeType type;
  final double x;
  final double y;
  final double size;
  final Gradient? gradient;
  final Color? color;
  final double strokeWidth;
  final double angle;
}

class DecorativeBackground extends StatelessWidget {
  const DecorativeBackground({
    super.key,
    required this.shapes,
    required this.child,
  });

  final List<DecorShape> shapes;
  final Widget child;

  static const designSize = Size(390, 844);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final scale = math.min(
          width / designSize.width,
          height / designSize.height,
        );

        return ClipRect(
          child: Stack(
            children: [
              for (final shape in shapes)
                Positioned(
                  left: shape.x * width - shape.size * scale / 2,
                  top: shape.y * height - shape.size * scale / 2,
                  width: shape.size * scale,
                  height: shape.size * scale,
                  child: IgnorePointer(child: _buildShape(shape, scale)),
                ),
              Positioned.fill(child: child),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShape(DecorShape shape, double scale) {
    final decoration = switch (shape.type) {
      DecorShapeType.circle => BoxDecoration(
        shape: BoxShape.circle,
        gradient: shape.gradient,
        color: shape.color,
      ),
      DecorShapeType.ring => BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: shape.color!,
          width: shape.strokeWidth * scale,
        ),
      ),
      DecorShapeType.roundedSquare => BoxDecoration(
        borderRadius: BorderRadius.circular(14 * scale),
        gradient: shape.gradient,
      ),
    };

    return Transform.rotate(
      angle: shape.angle * math.pi / 180,
      child: DecoratedBox(decoration: decoration),
    );
  }
}

class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.decorations,
    required this.child,
    this.footer,
    this.onBack,
    this.centered = false,
  });

  final List<DecorShape> decorations;
  final Widget child;
  final Widget? footer;
  final VoidCallback? onBack;
  final bool centered;

  static const maxContentWidth = 420.0;
  static const horizontalPadding = 24.0;

  Widget _constrained(Widget child) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxContentWidth),
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        32,
        horizontalPadding,
        24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (onBack != null)
            Align(
              alignment: Alignment.centerLeft,
              child: AppBackButton(onPressed: onBack!),
            ),
          child,
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: DecorativeBackground(
        shapes: decorations,
        child: CustomScrollView(
          slivers: [
            if (centered)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _constrained(content),
              )
            else
              SliverToBoxAdapter(child: _constrained(content)),
            if (footer != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      horizontalPadding,
                      24,
                      horizontalPadding,
                      30,
                    ),
                    child: footer,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return Tooltip(
      message: 'Atrás',
      child: Material(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onPressed,
          child: const SizedBox.square(
            dimension: 42,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 22,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  }) : secondary = false;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
  }) : secondary = true;

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final isEnabled = enabled && onPressed != null;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: isEnabled ? 1 : 0.45,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: secondary ? null : AppGradients.primaryButton,
            color: secondary ? AppColors.surface : null,
            borderRadius: borderRadius,
            border: secondary ? Border.all(color: AppColors.border) : null,
            boxShadow: !secondary && isEnabled
                ? const [
                    BoxShadow(
                      color: Color(0x407C3AED),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: isEnabled ? onPressed : null,
              child: Center(
                child: Text(
                  label,
                  style: AppTextStyles.button.copyWith(
                    color: secondary ? AppColors.textPrimary : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.focusNode,
    this.errorText,
    this.isPassword = false,
    this.onChanged,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscured = true;

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: color, width: width),
      );

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(widget.label, style: AppTextStyles.label),
        const SizedBox(height: 8),
        SizedBox(
          height: 52,
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword && _obscured,
            obscuringCharacter: '•',
            autocorrect: false,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            style: AppTextStyles.input,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.inputFill,
              hintText: widget.hint,
              hintStyle: AppTextStyles.hint,
              contentPadding: const EdgeInsets.all(16),
              enabledBorder: _border(
                hasError ? AppColors.error : AppColors.border,
              ),
              focusedBorder: _border(
                hasError ? AppColors.error : AppColors.primary,
                1.5,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      tooltip: _obscured
                          ? 'Mostrar contraseña'
                          : 'Ocultar contraseña',
                      onPressed: () => setState(() => _obscured = !_obscured),
                      icon: Icon(
                        _obscured
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Text(widget.errorText!, style: AppTextStyles.error),
        ],
      ],
    );
  }
}

class CodeBox extends StatefulWidget {
  const CodeBox({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onBackspaceWhenEmpty,
    this.size = 64,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onBackspaceWhenEmpty;
  final double size;

  @override
  State<CodeBox> createState() => _CodeBoxState();
}

class _CodeBoxState extends State<CodeBox> {
  late final _keyListenerNode = FocusNode(
    skipTraversal: true,
    onKeyEvent: (node, event) {
      if (event.logicalKey == LogicalKeyboardKey.backspace &&
          event is! KeyUpEvent &&
          widget.controller.text.isEmpty) {
        widget.onBackspaceWhenEmpty?.call();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    },
  );

  @override
  void dispose() {
    _keyListenerNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([widget.focusNode, widget.controller]),
      builder: (context, _) {
        final isFocused = widget.focusNode.hasFocus;
        final isFilled = widget.controller.text.isNotEmpty;

        return Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isFocused
                  ? AppColors.primary
                  : isFilled
                  ? const Color(0xFFD1D5DB)
                  : AppColors.border,
              width: isFocused ? 2 : 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F111827),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Focus(
            focusNode: _keyListenerNode,
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              onChanged: widget.onChanged,
              textAlign: TextAlign.center,
              showCursor: false,
              enableInteractiveSelection: false,
              style: AppTextStyles.codeDigit,
              inputFormatters: [_SingleDigitFormatter()],
              decoration: const InputDecoration(
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SingleDigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return newValue.text.isEmpty ? const TextEditingValue() : oldValue;
    }
    return TextEditingValue(
      text: digits.substring(digits.length - 1),
      selection: const TextSelection.collapsed(offset: 1),
    );
  }
}

class GradientIconBadge extends StatelessWidget {
  const GradientIconBadge({
    super.key,
    required this.icon,
    required this.gradient,
    this.size = 62,
    this.radius = 16,
    this.iconSize,
    this.circle = false,
  });

  final IconData icon;
  final Gradient gradient;
  final double size;
  final double radius;
  final double? iconSize;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circle ? null : BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.last.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: iconSize ?? size * 0.42),
    );
  }
}

class TextLink extends StatelessWidget {
  const TextLink({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Text(text, style: AppTextStyles.link),
        ),
      ),
    );
  }
}

class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.question,
    required this.action,
    required this.onTap,
  });

  final String question;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('$question ', style: AppTextStyles.small),
        TextLink(text: action, onTap: onTap),
      ],
    );
  }
}
