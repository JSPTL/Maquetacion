import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.878,
      y: 0.02,
      size: 286,
      gradient: AppGradients.orangePink,
    ),
    DecorShape.ring(
      x: 0.837,
      y: 0.212,
      size: 52,
      color: AppColors.ringPurple,
    ),
    DecorShape.yellowDot(x: 0.939, y: 0.281, size: 22),
    DecorShape.roundedSquare(
      x: 0.005,
      y: 0.97,
      size: 60,
      angle: 25,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.circle(
      x: 0.946,
      y: 0.964,
      size: 156,
      gradient: AppGradients.softBlue,
    ),
  ];

  static const _fieldGap = 14.0;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _submitted = false;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  String? get _nameError => _submitted
      ? Validators.required(
          _nameController.text,
          'El nombre completo es obligatorio',
        )
      : null;

  String? get _emailError =>
      _submitted ? Validators.email(_emailController.text) : null;

  String? get _passwordError => _submitted
      ? Validators.required(
          _passwordController.text,
          'La contraseña es obligatoria',
        )
      : null;

  String? get _confirmError => _submitted
      ? Validators.confirmPassword(
          _passwordController.text,
          _confirmController.text,
        )
      : null;

  bool get _hasErrors =>
      _nameError != null ||
      _emailError != null ||
      _passwordError != null ||
      _confirmError != null;

  void _onFieldChanged(String _) {
    if (_submitted) setState(() {});
  }

  void _submit() {
    if (!_acceptedTerms) return;
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);
    if (_hasErrors) return;

    session.email = _emailController.text.trim();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      onBack: () => Navigator.of(context).pop(),
      footer: AuthFooterLink(
        question: '¿Ya tienes cuenta?',
        action: 'Inicia sesión',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const Text('Crea tu cuenta', style: AppTextStyles.title),
          const SizedBox(height: 4),
          const Text(
            'Completa tus datos para empezar',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 24),
          AppInput(
            label: 'Nombre completo',
            hint: 'Juan Pérez',
            controller: _nameController,
            errorText: _nameError,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _emailFocus.requestFocus(),
          ),
          const SizedBox(height: _fieldGap),
          AppInput(
            label: 'Correo electrónico',
            hint: 'tu@correo.com',
            controller: _emailController,
            focusNode: _emailFocus,
            errorText: _emailError,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
          const SizedBox(height: _fieldGap),
          AppInput(
            label: 'Contraseña',
            hint: 'Mínimo 8 caracteres',
            controller: _passwordController,
            focusNode: _passwordFocus,
            errorText: _passwordError,
            isPassword: true,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _confirmFocus.requestFocus(),
          ),
          const SizedBox(height: _fieldGap),
          AppInput(
            label: 'Confirmar contraseña',
            hint: 'Repite tu contraseña',
            controller: _confirmController,
            focusNode: _confirmFocus,
            errorText: _confirmError,
            isPassword: true,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          _TermsCheckbox(
            value: _acceptedTerms,
            onToggle: () => setState(() => _acceptedTerms = !_acceptedTerms),
          ),
          const SizedBox(height: 23),
          AppButton(
            label: 'Crear cuenta',
            enabled: _acceptedTerms,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _TermsCheckbox extends StatelessWidget {
  const _TermsCheckbox({required this.value, required this.onToggle});

  final bool value;
  final VoidCallback onToggle;

  static final _textStyle = AppTextStyles.small.copyWith(height: 1.3);
  static final _linkStyle = _textStyle.copyWith(
    color: AppColors.link,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        key: const Key('register-terms'),
        behavior: HitTestBehavior.opaque,
        onTap: onToggle,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: value ? AppGradients.purplePink : null,
                color: value ? null : AppColors.surface,
                border: value
                    ? null
                    : Border.all(color: AppColors.border, width: 1.5),
              ),
              child: value
                  ? const Icon(
                      Icons.check_rounded,
                      size: 15,
                      color: Colors.white,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: _textStyle,
                  children: [
                    const TextSpan(text: 'Acepto los '),
                    TextSpan(text: 'Términos y condiciones', style: _linkStyle),
                    const TextSpan(text: ' y la '),
                    TextSpan(text: 'Política de privacidad', style: _linkStyle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
