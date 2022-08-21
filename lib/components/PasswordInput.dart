import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput(
      {Key? key,
      required this.onChanged,
      this.label,
      this.enabled,
      this.enableCopy,
      this.enableVisibility = true,
      this.value})
      : super(key: key);

  final void Function(String) onChanged;
  final String? label;
  final bool? enabled;
  final bool? enableCopy;
  final bool? enableVisibility;
  final String? value;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isPasswordVisible = false;
  final textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value != null) {
      textController.text = widget.value!;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        decoration: const BoxDecoration(
          color: Color(0xff2d333b),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: TextField(
                controller: textController,
                obscureText: widget.enableVisibility != null && !widget.enableVisibility! ? false : !isPasswordVisible,
                enableSuggestions: false,
                autocorrect: false,
                minLines: 1,
                maxLines: 1,
                maxLength: 256,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: widget.label ?? "",
                  hintStyle: const TextStyle(color: Colors.grey),
                  counterText: "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(style: BorderStyle.none, width: 0)),
                ),
                enabled: widget.enabled,
                onChanged: widget.onChanged,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.enableVisibility == true)
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                if (widget.enableCopy == true)
                  Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
