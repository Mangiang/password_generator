import 'package:flutter/material.dart';

import 'CustomButton.dart';

enum DeleteDialogAction { cancel, delete }

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text("Do you really want to delete this entry ?"),
        content: const Text(
          "Warning: This action is irreversible !",
        ),
        actions: [
          CustomButton(
            type: ButtonType.neutral,
            text: 'Cancel',
            enabled: true,
            onPressed: () => Navigator.pop(context, DeleteDialogAction.cancel),
          ),
          CustomButton(
            type: ButtonType.danger,
            text: 'Delete anyways',
            enabled: true,
            onPressed: () => Navigator.pop(context, DeleteDialogAction.delete),
          ),
        ],
        backgroundColor: const Color(0xff22272e),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        contentTextStyle: const TextStyle(color: Colors.red, fontSize: 16),
      );
}
