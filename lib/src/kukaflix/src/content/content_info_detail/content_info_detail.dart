import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class ContentInfoDetail extends StatelessWidget {
  const ContentInfoDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = const Color(0xFF181818);

    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        width: 430,
        height: 420,
      child: Center(child: Row(
        children: [
          KukaflixButtonPlay(),
          KukaflixButtonPlay(),
        ],
      )),
    );
  }
}
