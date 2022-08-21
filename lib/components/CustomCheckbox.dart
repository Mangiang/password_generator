import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {Key? key, this.isChecked = false, this.onChanged, this.label = ""})
      : super(key: key);

  final String label;
  final bool isChecked;
  final void Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Switch(
            activeColor: Colors.blueAccent,
            inactiveTrackColor: Colors.white24,
            inactiveThumbColor: Colors.black54,
            value: widget.isChecked,
            onChanged: widget.onChanged,
          ),
          Text(
            widget.label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );
}
