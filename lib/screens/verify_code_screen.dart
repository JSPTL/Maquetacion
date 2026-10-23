import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../main.dart';
import 'new_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  static const codeLength = 4;
  static const resendSeconds = 45;
  static const emailFallback = 'tu correo electrónico';

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.872,
      y: 0.024,
      size: 280,
      gradient: AppGradients.orangePink,
    ),
    DecorShape.ring(
      x: 0.861,
      y: 0.222,
      size: 50,
      color: AppColors.ringPurple,
      strokeWidth: 6,
    ),
    DecorShape.roundedSquare(
      x: 0.015,
      y: 0.968,
      size: 60,
      angle: 25,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.circle(
      x: 0.931,
      y: 0.96,
      size: 145,
      gradient: AppGradients.softBlue,
    ),
  ];

  static const _boxSize = 60.0;
  static const _boxGap = 20.0;

  final _controllers = List.generate(
    VerifyCodeScreen.codeLength,
    (_) => TextEditingController(),
  );
  final _focusNodes = List.generate(
    VerifyCodeScreen.codeLength,
    (_) => FocusNode(),
  );

  Timer? _timer;
  int _secondsLeft = VerifyCodeScreen.resendSeconds;

  String get _email => authStore.recoveryEmail ?? VerifyCodeScreen.emailFallback;
  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);
  bool get _canResend => _secondsLeft == 0;

  String get _countdownText {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNodes.first.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    _secondsLeft = VerifyCodeScreen.resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) timer.cancel();
    });
  }

  void _onDigitChanged(int index, String value) {
    setState(() {});
    if (value.isNotEmpty && index < VerifyCodeScreen.codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onBackspaceWhenEmpty(int index) {
    if (index == 0) return;
    setState(() => _controllers[index - 1].clear());
    _focusNodes[index - 1].requestFocus();
  }

  void _resendCode() {
    setState(_startCountdown);
    showAppMessage(context, 'Te reenviamos el código a $_email');
  }

  void _submit() {
    if (!_isComplete) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const NewPasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const Align(
            alignment: Alignment.centerLeft,
            child: GradientIconBadge(
              icon: Icons.verified_user_outlined,
              gradient: AppGradients.orangePink,
            ),
          ),
          const SizedBox(height: 28),
          const Text('Verifica tu correo', style: AppTextStyles.title),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: 'Escribe el código de 4 dígitos que enviamos a\n',
              children: [
                TextSpan(
                  text: _email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 28),
          _buildCodeRow(),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('¿No te llegó? ', style: AppTextStyles.small),
              TextLink(
                text: _canResend
                    ? 'Reenviar código'
                    : 'Reenviar código en $_countdownText',
                onTap: _canResend ? _resendCode : null,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'Siguiente',
            enabled: _isComplete,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Widget _buildCodeRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const count = VerifyCodeScreen.codeLength;
        const designWidth = count * _boxSize + (count - 1) * _boxGap;
        final scale = math.min(1.0, constraints.maxWidth / designWidth);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < count; i++) ...[
              if (i > 0) SizedBox(width: _boxGap * scale),
              CodeBox(
                controller: _controllers[i],
                focusNode: _focusNodes[i],
                size: _boxSize * scale,
                onChanged: (value) => _onDigitChanged(i, value),
                onBackspaceWhenEmpty: () => _onBackspaceWhenEmpty(i),
              ),
            ],
          ],
        );
      },
    );
  }
}
