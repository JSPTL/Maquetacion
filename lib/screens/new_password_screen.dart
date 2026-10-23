import 'package:flutter/material.dart';

import '../main.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  static const successMessage =
      'Contraseña restablecida. Inicia sesión con tu nueva contraseña.';

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.86,
      y: 0.005,
      size: 316,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.yellowDot(x: 0.91, y: 0.27, size: 22),
    DecorShape.circle(
      x: 0.065,
      y: 0.925,
      size: 128,
      gradient: AppGradients.softBlue,
    ),
    DecorShape.roundedSquare(
      x: 0.93,
      y: 0.927,
      size: 64,
      angle: 18,
      gradient: AppGradients.orangeSquare,
    ),
  ];

  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _confirmFocus = FocusNode();

  String get _password => _passwordController.text;
  String get _confirmation => _confirmController.text;

  bool get _canSubmit =>
      Validators.meetsAllPasswordRequirements(_password) &&
      _confirmation == _password;

  String? get _confirmError =>
      _confirmation.isNotEmpty && _password != _confirmation
      ? 'Las contraseñas no coinciden'
      : null;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _onChanged(String _) => setState(() {});

  void _submit() {
    if (!_canSubmit) return;
    authStore.resetPassword(_password);
    showAppMessage(
      context,
      NewPasswordScreen.successMessage,
      type: AppMessageType.success,
    );
    backToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const _VerifiedTag(),
          const SizedBox(height: 22),
          const GradientIconBadge(
            icon: Icons.lock_outline_rounded,
            gradient: AppGradients.purplePink,
          ),
          const SizedBox(height: 26),
          const Text('Crea una nueva\ncontraseña', style: AppTextStyles.title),
          const SizedBox(height: 12),
          const Text(
            'Tu nueva contraseña debe ser diferente a las que usaste antes.',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 24),
          AppInput(
            label: 'Nueva contraseña',
            hint: '••••••••',
            controller: _passwordController,
            isPassword: true,
            onChanged: _onChanged,
            onSubmitted: (_) => _confirmFocus.requestFocus(),
          ),
          const SizedBox(height: 16),
          AppInput(
            label: 'Confirmar contraseña',
            hint: '••••••••',
            controller: _confirmController,
            focusNode: _confirmFocus,
            isPassword: true,
            errorText: _confirmError,
            onChanged: _onChanged,
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 15),
          _PasswordRequirement(
            text: 'Mínimo 8 caracteres',
            met: Validators.hasMinLength(_password),
          ),
          const SizedBox(height: 6),
          _PasswordRequirement(
            text: 'Al menos una mayúscula',
            met: Validators.hasUppercase(_password),
          ),
          const SizedBox(height: 6),
          _PasswordRequirement(
            text: 'Al menos un número',
            met: Validators.hasNumber(_password),
          ),
          const SizedBox(height: 22),
          AppButton(
            label: 'Restablecer contraseña',
            enabled: _canSubmit,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _VerifiedTag extends StatelessWidget {
  const _VerifiedTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.successBackground,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_rounded, size: 14, color: AppColors.success),
          const SizedBox(width: 6),
          Text(
            'Código verificado',
            style: AppTextStyles.small.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordRequirement extends StatelessWidget {
  const _PasswordRequirement({required this.text, required this.met});

  final String text;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: met ? AppColors.successBackground : AppColors.surface,
            border: Border.all(
              color: met ? AppColors.successBackground : AppColors.border,
              width: 1.5,
            ),
          ),
          child: met
              ? const Icon(
                  Icons.check_rounded,
                  size: 12,
                  color: AppColors.success,
                )
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.body.copyWith(
              color: met ? AppColors.textSecondary : AppColors.hint,
            ),
          ),
        ),
      ],
    );
  }
}
