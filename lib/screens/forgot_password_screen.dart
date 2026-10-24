import 'package:flutter/material.dart';

import '../main.dart';
import 'verify_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.864,
      y: 0.026,
      size: 272,
      gradient: AppGradients.blue,
    ),
    DecorShape.yellowDot(x: 0.877, y: 0.25, size: 24),
    DecorShape.roundedSquare(
      x: 0.01,
      y: 0.958,
      size: 60,
      angle: 20,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.circle(
      x: 0.956,
      y: 0.959,
      size: 143,
      gradient: AppGradients.softPeach,
    ),
  ];

  final _emailController = TextEditingController();
  final _emailFocus = FocusNode();

  bool _submitted = false;

  String? get _emailError =>
      _submitted ? Validators.email(_emailController.text) : null;

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;

    setState(() => _submitted = true);
    if (_emailError != null) {
      _emailFocus.requestFocus();
      return;
    }

    FocusScope.of(context).unfocus();
    session.recoveryEmail = _emailController.text.trim();
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const VerifyCodeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      onBack: () => Navigator.of(context).pop(),
      footer: AuthFooterLink(
        question: '¿La recordaste?',
        action: 'Inicia sesión',
        onTap: () => Navigator.of(context).pop(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: GradientIconBadge(
              icon: Icons.mail_outline_rounded,
              gradient: AppGradients.blue,
            ),
          ),
          const SizedBox(height: 28),
          const Text('¿Olvidaste tu\ncontraseña?', style: AppTextStyles.title),
          const SizedBox(height: 12),
          const Text(
            'Ingresa el correo con el que te registraste y te enviaremos un '
            'código de 4 dígitos.',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 24),
          AppInput(
            label: 'Correo electrónico',
            hint: 'tu@correo.com',
            controller: _emailController,
            focusNode: _emailFocus,
            errorText: _emailError,
            onChanged: (_) {
              if (_submitted) setState(() {});
            },
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 24),
          AppButton(label: 'Enviar código', onPressed: _submit),
        ],
      ),
    );
  }
}
