import 'package:flutter/material.dart';

import '../main.dart';

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({super.key});

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.95,
      y: 0.04,
      size: 210,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.yellowDot(x: 0.55, y: 0.085, size: 22),
  ];

  final _emailController = TextEditingController();
  final _errorController = TextEditingController(text: 'usuario@correo');
  final _passwordController = TextEditingController(text: 'Password1');
  final _codeControllers = [
    TextEditingController(text: '0'),
    TextEditingController(),
  ];
  final _codeFocusNodes = [FocusNode(), FocusNode()];

  late String? _errorText = Validators.email(_errorController.text);

  @override
  void dispose() {
    _emailController.dispose();
    _errorController.dispose();
    _passwordController.dispose();
    for (final controller in _codeControllers) {
      controller.dispose();
    }
    for (final node in _codeFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onButtonPressed() => showAppMessage(context, 'Botón presionado');

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      onBack: () => Navigator.of(context).pop(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          const Text('Componentes', style: AppTextStyles.title),
          const SizedBox(height: 4),
          const Text(
            'Elementos reutilizables del diseño y sus estados',
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 24),
          _Section(
            title: 'Input',
            children: [
              AppInput(
                label: 'Correo electrónico',
                hint: 'tu@correo.com',
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              AppInput(
                label: 'Correo electrónico',
                hint: 'tu@correo.com',
                controller: _errorController,
                errorText: _errorText,
                onChanged: (value) =>
                    setState(() => _errorText = Validators.email(value)),
              ),
              const SizedBox(height: 16),
              AppInput(
                label: 'Contraseña',
                hint: 'Mínimo 8 caracteres',
                controller: _passwordController,
                isPassword: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Botón',
            children: [
              AppButton(label: 'Botón', onPressed: _onButtonPressed),
              const SizedBox(height: 16),
              AppButton.secondary(label: 'Botón', onPressed: _onButtonPressed),
              const SizedBox(height: 16),
              AppButton(
                label: 'Botón deshabilitado',
                onPressed: _onButtonPressed,
                enabled: false,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Casilla de código',
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var i = 0; i < _codeControllers.length; i++)
                    _CodeBoxSample(
                      controller: _codeControllers[i],
                      focusNode: _codeFocusNodes[i],
                    ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Haz clic en una casilla para ver el estado enfocado.',
                style: AppTextStyles.small,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ],
    );
  }
}

class _CodeBoxSample extends StatelessWidget {
  const _CodeBoxSample({required this.controller, required this.focusNode});

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CodeBox(controller: controller, focusNode: focusNode),
        const SizedBox(height: 8),
        ListenableBuilder(
          listenable: Listenable.merge([controller, focusNode]),
          builder: (context, _) => Text(
            focusNode.hasFocus
                ? 'Enfocada'
                : controller.text.isEmpty
                ? 'Vacía'
                : 'Con dígito',
            style: AppTextStyles.small.copyWith(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
