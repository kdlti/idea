import 'package:flutter/material.dart';

class IdeMenuLogo extends StatelessWidget {
  final String logo;

  /// Altura atual do componente
  final double height;

  /// Largura atual do componente
  final double width;

  const IdeMenuLogo({
    required this.logo,
    this.width = 30,
    this.height = 26,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.only(left: 2),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
            width: 20,
            height: 20,
            child: Image(
              image: AssetImage(logo),
            ),
          ),
        ),
      ),
    );
  }
}
