import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_rickandmorty/presentation/pages/characters_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    // Navega para a página principal após 3 segundos
    _navigationTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CharactersPage(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSplashImage() {
    // GIF animado do Rick and Morty
    return Image.asset(
      'assets/images/rick_morty.gif',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildFallbackGradient();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo da série
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: 1.0 + (_controller.value * 0.1),
                  child: _buildSplashImage(),
                ),
              );
            },
          ),

          // Overlay escuro com gradiente
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Conteúdo principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo/Título com animação
                          Text(
                            'RICK AND MORTY',
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 6,
                              shadows: [
                                Shadow(
                                  color: const Color(0xFF00D4FF)
                                      .withOpacity(0.9 * _fadeAnimation.value),
                                  blurRadius: 30,
                                  offset: const Offset(0, 0),
                                ),
                                Shadow(
                                  color: const Color(0xFFFF6B35)
                                      .withOpacity(0.6 * _fadeAnimation.value),
                                  blurRadius: 20,
                                  offset: const Offset(0, 0),
                                ),
                                const Shadow(
                                  color: Colors.black,
                                  blurRadius: 15,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Subtítulo
                          Opacity(
                            opacity: _fadeAnimation.value,
                            child: Text(
                              'Character Explorer',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[300],
                                letterSpacing: 3,
                                shadows: const [
                                  Shadow(
                                    color: Colors.black,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0A0A),
            Color(0xFF1A1A1A),
            Color(0xFF0A0A0A),
          ],
        ),
      ),
    );
  }
}
