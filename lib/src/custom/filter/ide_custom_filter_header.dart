import 'package:flutter/material.dart';

class IdeCustomFilterHeader extends StatelessWidget {
  const IdeCustomFilterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 0),
      child: Row(
        children: [
          const Text(
            "Filtros",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.close, size: 20),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ),
        ],
      ),
    );
  }
}
