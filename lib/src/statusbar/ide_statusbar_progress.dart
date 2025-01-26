import 'package:flutter/material.dart';
import 'package:idea/package.dart';

class IdeStatusbarProgress extends StatefulWidget {
  final bool inProgress;
  final double width;
  final double height;
  final double borderRadius;

  const IdeStatusbarProgress({
    Key? key,
    this.inProgress = false,
    this.width = 200,
    this.height = 5,
    this.borderRadius = 5,
  }) : super(key: key);

  @override
  State<IdeStatusbarProgress> createState() => IdeStatusbarProgressState();
}

class IdeStatusbarProgressState extends State<IdeStatusbarProgress> {
  bool inProgress = false;

  @override
  void initState() {
    inProgress = widget.inProgress;
    Ide.initState("IdeStatusbarProgressState", this);
    super.initState();
  }

  void updateProgress(bool value) {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          inProgress = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.centerLeft,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: inProgress
          ? const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
            )
          : const SizedBox.shrink(),
    );
  }
}
