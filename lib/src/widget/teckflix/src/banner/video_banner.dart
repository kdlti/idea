import 'package:flutter/material.dart';
import 'package:idea/src/widget/teckflix/src/banner/video_banner_logo.dart';

class VideoBanner extends StatefulWidget {
  const VideoBanner({super.key});

  @override
  State<VideoBanner> createState() => _VideoBannerState();
}

class _VideoBannerState extends State<VideoBanner> {
  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = width * 0.56; // Proporção 16:9
        double scale = width / 1920; // Ajuste a escala com base na largura da tela

        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('images/movie01.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.02, 0.98],
                colors: [Color(0xFF121212), Colors.transparent],
              ),
            ),
            child: Stack(
              children: [
                 Positioned(
                  bottom: 100*scale,
                  left: 60*scale,
                  child: Transform.scale(
                      alignment: Alignment.bottomLeft,
                      scale: scale, child: const VideoBannerLogo()),
                ),
                Positioned(
                  left: 60*scale,
                  bottom: 100*scale,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_arrow, color: Colors.black87, size: 50),
                          label: const Text('Assistir', style: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 25, right: 40, top: 10, bottom: 10),
                            backgroundColor: Colors.white, // Defina a cor de fundo desejada
                          ),
                        ),
                        const SizedBox(width: 15),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 30),
                          label: const Text('Mais informações', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                            backgroundColor: Colors.grey.withValues(alpha: 0.5), // Defina a cor de fundo desejada
                            ///backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 100*scale,
                  width: 196,
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.volume_mute_outlined, color: Colors.white, size: 35),
                          splashRadius: 10,
                        ),
                        const SizedBox(width: 10),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 135,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            border: Border(
                              left: BorderSide(width: 2, color: Colors.white38),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            width: 40,
                            height: 40,
                          ),
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
    );
  }
}