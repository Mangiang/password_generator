import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/PasswordState.dart';
import '../utils/PasswordGenerator.dart';

class DangerButton extends StatefulWidget {
  const DangerButton({Key? key, required this.enabled}) : super(key: key);

  final bool enabled;

  @override
  State<DangerButton> createState() => _DangerButtonState();
}

class _DangerButtonState extends State<DangerButton> {
  Color buttonColor = const Color(0xff70383a);
  Color textColor = const Color(0xffc93c37);

  @override
  Widget build(BuildContext context) => Consumer<PasswordState>(
        builder: (context, state, child) => ElevatedButton(
          onPressed: widget.enabled
              ? () => PasswordGenerator.removeFromDataFile(state)
              : null,
          child: Text(
            'Delete',
            style: TextStyle(
              color: textColor,
            ),
          ),
          onHover: (bool isHover) {
            if (widget.enabled) {
              setState(() {
                buttonColor =
                    isHover ? const Color(0xffc93c37) : const Color(0xff2d333b);
                textColor = isHover ? Colors.white : const Color(0xffc93c37);
              });
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
        ),
      );
}
