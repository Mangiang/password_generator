import 'package:flutter/material.dart';
import 'package:password_generator/state/PasswordState.dart';
import 'package:password_generator/utils/PasswordGenerator.dart';
import 'package:provider/provider.dart';

class ActionsRow extends StatefulWidget {
  const ActionsRow({Key? key}) : super(key: key);

  @override
  State<ActionsRow> createState() => _ActionsRowState();
}

class _ActionsRowState extends State<ActionsRow> {
  bool generateEnabled = false;

  Future<void> generatePassword(PasswordState state) async {
    if (generateEnabled) {
      state.updatePassword(await PasswordGenerator.getPassword(state));
    }
  }

  bool generateEnable(PasswordState state) {
    return state.passphrase1.isNotEmpty &&
        state.passphrase2.isNotEmpty &&
        state.desiredLength > 0;
  }

  @override
  Widget build(BuildContext context) =>
      Consumer<PasswordState>(builder: (context, state, child) {
        generateEnabled = generateEnable(state);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Delete'),
              ),
            ),
            const SizedBox(width: 50),
            Expanded(
              child: ElevatedButton(
                onPressed: generateEnabled ? () => generatePassword(state) : null,
                child: Text(
                  'Generate',
                  style: TextStyle(
                      color: generateEnabled ? Colors.white : Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      generateEnabled
                          ? const Color(0xff347d39)
                          : const Color(0xff929292)),
                ),
              ),
            ),
          ],
        );
      });
}
