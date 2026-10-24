import 'package:flutter/material.dart';

import '../main.dart';
import 'forgot_password_screen.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.84,
      y: 0.004,
      size: 316,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.circle(
      x: -0.02,
      y: 0.238,
      size: 178,
      gradient: AppGradients.softBlue,
    ),
    DecorShape.yellowDot(x: 0.149, y: 0.1, size: 28),
    DecorShape.ring(x: 0.01, y: 0.738, size: 42, color: AppColors.ringBlue),
    DecorShape.circle(
      x: 0.023,
      y: 0.953,
      size: 132,
      gradient: AppGradients.softPink,
    ),
    DecorShape.roundedSquare(
      x: 0.946,
      y: 0.924,
      size: 64,
      angle: -15,
      gradient: AppGradients.orangeSquare,
    ),
  ];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? get _emailError =>
      _submitted ? Validators.email(_emailController.text) : null;

  String? get _passwordError => _submitted
      ? Validators.required(
          _passwordController.text,
          'La contraseña es obligatoria',
        )
      : null;

  void _onFieldChanged(String _) {
    if (_submitted) setState(() {});
  }

  void _open(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void _submit() {
    setState(() => _submitted = true);

    if (_emailError != null) {
      _emailFocus.requestFocus();
      return;
    }
    if (_passwordError != null) {
      _passwordFocus.requestFocus();
      return;
    }

    FocusScope.of(context).unfocus();
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
      footer: AuthFooterLink(
        question: '¿No tienes cuenta?',
        action: 'Regístrate',
        onTap: () => _open(const RegisterScreen()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: GradientIconBadge(
              icon: Icons.lock_outline_rounded,
              gradient: AppGradients.purplePink,
              size: 72,
              radius: 18,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Bienvenido de nuevo',
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'Inicia sesión para continuar',
            style: AppTextStyles.subtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AppInput(
            label: 'Correo electrónico',
            hint: 'tu@correo.com',
            controller: _emailController,
            focusNode: _emailFocus,
            errorText: _emailError,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _passwordFocus.requestFocus(),
          ),
          const SizedBox(height: 12),
          AppInput(
            label: 'Contraseña',
            hint: '••••••••',
            controller: _passwordController,
            focusNode: _passwordFocus,
            errorText: _passwordError,
            isPassword: true,
            onChanged: _onFieldChanged,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 11),
          Align(
            alignment: Alignment.centerRight,
            child: TextLink(
              text: '¿Olvidaste tu contraseña?',
              onTap: () => _open(const ForgotPasswordScreen()),
            ),
          ),
          const SizedBox(height: 18),
          AppButton(label: 'Iniciar sesión', onPressed: _submit),
          const SizedBox(height: 26),
          const _OrDivider(),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppButton.secondary(
                  label: 'Google',
                  onPressed: () => showFeatureUnavailable(context),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton.secondary(
                  label: 'Apple',
                  onPressed: () => showFeatureUnavailable(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    const line = Expanded(
      child: Divider(height: 1, thickness: 1, color: AppColors.border),
    );

    return Row(
      children: [
        line,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'o continúa con',
            style: AppTextStyles.small.copyWith(fontSize: 12),
          ),
        ),
        line,
      ],
    );
  }
}
