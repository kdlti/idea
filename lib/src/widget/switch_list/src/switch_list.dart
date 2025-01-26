import 'package:flutter/material.dart';
import 'package:idea/src/widget/switch_list/package.dart';

class IdeSwitchList extends StatefulWidget {
  final List<IdeSwitchListOption> children;
  final ValueChanged<IdeSwitchListOption>? onValueChanged;
  final bool showDivider;
  final IdeSwitchListStyle? style;

  const IdeSwitchList({
    super.key,
    required this.children,
    this.onValueChanged,
    this.showDivider = true,
    this.style,
  });

  @override
  _IdeListSwitchState createState() => _IdeListSwitchState();
}

class _IdeListSwitchState extends State<IdeSwitchList> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        List<Widget> children = <Widget>[];
        for (var element in widget.children) {
          if (widget.children.indexOf(element) > 0 && widget.showDivider) {
            children.add(const Divider(height: 0, endIndent: 0, indent: 0));
          }
          children.add(
            IdeSwitchListItem(
              style: widget.style,
              enabled: element.enabled,
              title: element.title,
              subTitle: element.subTitle,
              value: element.value,
              icon: element.icon,
              onChanged: widget.onValueChanged != null
                  ? (value) {
                      setState(() {
                        element.value = value;
                        widget.onValueChanged!(element);
                      });
                    }
                  : null,
            ),
          );
        }
        return Column(children: children);
      },
    );
  }
}
