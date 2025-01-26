import 'package:flutter/material.dart';

class VideoBannerLogo extends StatefulWidget {
  const VideoBannerLogo({super.key});

  @override
  State<VideoBannerLogo> createState() => _VideoBannerLogoState();
}

class _VideoBannerLogoState extends State<VideoBannerLogo> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _textController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _positionAnimation;
  late Animation<Offset> _textPositionAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _positionAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(-140, 250)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textPositionAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, 100)).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 5000), () {
        _controller.reverse();
      });
    });

    _textController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 5500), () {
        _textController.reverse();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 685,
      height: 600,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: _positionAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                ),
              );
            },
            child: const SizedBox(
              width: 685,
              height: 290,
              child: Image(image: AssetImage('images/logo01.webp'), fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 35),
          AnimatedBuilder(
            animation: _textController,
            builder: (context, child) {
              return Transform.translate(
                offset: _textPositionAnimation.value,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: child,
                ),
              );
            },
            child: const Column(
              children: [
                SizedBox(
                  width: 685,
                  child: Text(
                    "Assista à minissérie agora",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      height: 1.2,
                      letterSpacing: 0.1,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 685,
                  child: Text(
                    "Um ex-fuzileiro naval deixa um rastro de sangue para proteger um menino que foge de terríveis assassinos contratados por traficantes de drogas.",
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.2,
                      letterSpacing: 0.1,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}