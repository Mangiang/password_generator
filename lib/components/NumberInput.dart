import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/utils/NumericalRangeFormatter.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({
    Key? key,
    required this.value,
    required this.onChanged,
    this.label,
  }) : super(key: key);

  final int value;
  final void Function(String)? onChanged;
  final String? label;

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: const BoxDecoration(
            color: Color(0xff2d333b),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            onChanged: widget.onChanged,
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: const TextInputType.numberWithOptions(
                decimal: false, signed: false),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              NumericalRangeFormatter(min: 0, max: 256),
            ],
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.label ?? "",
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              filled: true,
              fillColor: const Color(0xff2d333b),
            ),
          ),
        ),
      );
}
