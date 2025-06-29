import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_hunter/app/controllers/auth_controller.dart';
import 'package:wallet_hunter/app/routes/app_routes.dart';
import 'package:wallet_hunter/app/services/storage_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _fadeController;

  late Animation<double> _logoScale;
  late Animation<double> _logoRotation;
  late Animation<Offset> _textSlide;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Logo scale and rotation animations
    _logoScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoRotation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    // Text slide animation
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo animation
    await _logoController.forward();

    // Start text animation
    await _textController.forward();

    // Start fade animation for buttons
    await _fadeController.forward();

    // Wait a bit then check auth status
    await Future.delayed(const Duration(milliseconds: 500));
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    final storageService = Get.find<StorageService>();
    final isLoggedIn = await storageService.isLoggedIn();

    if (isLoggedIn) {
      Get.offAllNamed(AppRoutes.DASHBOARD);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4A90E2),
              Color(0xFF357ABD),
              Color(0xFF2C3E50),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with logo and text
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScale.value,
                          child: Transform.rotate(
                            angle: _logoRotation.value * 0.1,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.family_restroom,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Animated Text
                    SlideTransition(
                      position: _textSlide,
                      child: FadeTransition(
                        opacity: _textController,
                        child: Column(
                          children: [
                            const Text(
                              'Wallet Hunter',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Family Registration & Management',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom section with features
              Expanded(
                flex: 2,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Features Grid
                        Row(
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                icon: Icons.people,
                                title: 'Family Tree',
                                subtitle: 'Visual family connections',
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFeatureCard(
                                icon: Icons.temple_hindu,
                                title: 'Temple Association',
                                subtitle: 'Auto-linked with Samaj',
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: _buildFeatureCard(
                                icon: Icons.security,
                                title: 'Secure OTP',
                                subtitle: 'Safe authentication',
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildFeatureCard(
                                icon: Icons.download,
                                title: 'Export Data',
                                subtitle: 'PDF family reports',
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Loading indicator
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Loading your family data...',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
