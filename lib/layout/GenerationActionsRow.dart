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
  void GeneratePassword(PasswordState state) {
    if (state.passphrase1.isNotEmpty && state.passphrase2.isNotEmpty) {
      state.updatePassword(PasswordGenerator.getPassword(state));
    }
  }

  @override
  Widget build(BuildContext context) => Row(
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
            child: Consumer<PasswordState>(
              builder: (context, state, child) {
                return ElevatedButton(
                  onPressed: () => GeneratePassword(state),
                  child: const Text(
                    'Generate',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xff347d39))),
                );
              },
            ),
          ),
        ],
      );
}
