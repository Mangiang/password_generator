import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/PasswordState.dart';
import '../utils/PasswordGenerator.dart';

class ValidationButton extends StatefulWidget {
  const ValidationButton({Key? key, required this.enabled}) : super(key: key);

  final bool enabled;

  @override
  State<ValidationButton> createState() => _ValidationButtonState();
}

class _ValidationButtonState extends State<ValidationButton> {
  Color buttonColor = const Color(0xff347d39);

  Future<void> generatePassword(PasswordState state) async {
    if (widget.enabled) {
      state.updatePassword(await PasswordGenerator.getPassword(state));
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<PasswordState>(
        builder: (context, state, child) => ElevatedButton(
          onPressed: widget.enabled ? () => generatePassword(state) : null,
          child: Text(
            'Generate',
            style:
                TextStyle(color: widget.enabled ? Colors.white : Colors.grey),
          ),
          onHover: (bool isHover) {
            if (widget.enabled) {
              setState(() {
                buttonColor =
                    isHover ? const Color(0xff649467) : const Color(0xff347d39);
              });
            }
            ;
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(widget.enabled
                ? buttonColor
                : const Color(0xff2d333b)),
          ),
        ),
      );
}
