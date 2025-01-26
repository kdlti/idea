import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeEventsLog extends StatefulWidget {
  const IdeEventsLog({super.key});

  @override
  _CalledIdePanelBottomState createState() => _CalledIdePanelBottomState();
}

class _CalledIdePanelBottomState extends State<IdeEventsLog> {
  @override
  void initState() {
    Ide.initState("IdeEventsLog", this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child:  Center(
        child: Row(
          children:  [
            const Text(
              "Ide Event Log",
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
      ),
    );
  }
}
