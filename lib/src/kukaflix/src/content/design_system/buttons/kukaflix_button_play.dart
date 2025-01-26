import 'package:flutter/material.dart';
import 'package:idea/src/kukaflix/src/content/design_system/buttons/KukaflixIconButton.dart';
import 'package:idea/src/kukaflix/src/content/design_system/kukaflix_design_system_icons.dart';

class KukaflixButtonPlay extends KukaflixIconButton {
  KukaflixButtonPlay({super.key})
      : super(
            svgIcon: KukaflixDesignSystemIcons.playerPlayFilled,
            svgIconHover: KukaflixDesignSystemIcons.playerPlayFilled,
            svgIconPressed: KukaflixDesignSystemIcons.playerPlayFilled,
            background: Colors.transparent,
            backgroundHover: Colors.white54,
            backgroundPressed: Colors.white,
            borderColor: Colors.white30,
            borderColorHover: Colors.black,
            borderColorPressed: Colors.white,
            iconColor: Colors.black87,
            iconColorHover: Colors.black54,
            iconColorPressed: Colors.black,
            splashColor: Colors.white,
            splashColorHover: Colors.white54,
            splashColorPressed: Colors.white,
            width: 50,
            height: 50,
            borderWidth: 2,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            margin: const EdgeInsets.only(left: 0, right: 5),
            onPressed: () {
              print('Play button pressed');
            });
}
