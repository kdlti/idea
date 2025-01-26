import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdePanelBottomHead extends StatelessWidget {
  const IdePanelBottomHead({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: 27,
      child: Row(
        children: [
          const Text(
            "PanelBottom Head",
            style: TextStyle(fontSize: 10),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              Ide.panelBottomHide();
            },
            child: const Text("x"),
          )
        ],
      ),
    );
  }
}
