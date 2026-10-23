import 'package:flutter/material.dart';

import '../main.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _decorations = [
    DecorShape.circle(
      x: 0.80,
      y: 0.005,
      size: 330,
      gradient: AppGradients.purplePink,
    ),
    DecorShape.yellowDot(x: 0.153, y: 0.157),
    DecorShape.ring(x: 0.025, y: 0.383, size: 46, color: AppColors.ringPink),
    DecorShape.circle(
      x: 0,
      y: 0.866,
      size: 220,
      gradient: AppGradients.softBlue,
    ),
    DecorShape.roundedSquare(
      x: 0.93,
      y: 0.785,
      size: 64,
      angle: -15,
      gradient: AppGradients.orangeSquare,
    ),
  ];

  final String? _email = authStore.currentUser?.email;

  void _logout() {
    authStore.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      decorations: _decorations,
      centered: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: GradientIconBadge(
              icon: Icons.person_outline_rounded,
              gradient: AppGradients.purplePink,
              size: 104,
              iconSize: 52,
              circle: true,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '¡Bienvenido!',
            textAlign: TextAlign.center,
            style: AppTextStyles.title.copyWith(fontSize: 32),
          ),
          const SizedBox(height: 12),
          if (_email != null)
            Center(child: _EmailChip(email: _email))
          else
            const SizedBox(height: 40),
          const SizedBox(height: 48),
          AppButton(label: 'Cerrar sesión', onPressed: _logout),
        ],
      ),
    );
  }
}

class _EmailChip extends StatelessWidget {
  const _EmailChip({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEDE9FE),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.mail_outline_rounded,
            size: 18,
            color: AppColors.primary,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              email,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.link.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
