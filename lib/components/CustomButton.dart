import 'package:flutter/material.dart';

enum ButtonType { success, danger, neutral }

enum ColorState {
  backgroundColorDefault,
  backgroundColorHoverEnter,
  backgroundColorHoverExit,
  textColorDefault,
  textColorHoverEnter,
  textColorHoverExit,
}

const Map<ButtonType, Map<ColorState, Color>> colors = {
  ButtonType.danger: {
    ColorState.backgroundColorDefault: Color(0xff2d333b),
    ColorState.backgroundColorHoverEnter: Color(0xffc93c37),
    ColorState.backgroundColorHoverExit: Color(0xff2d333b),
    ColorState.textColorDefault: Color(0xffc93c37),
    ColorState.textColorHoverEnter: Colors.white,
    ColorState.textColorHoverExit: Color(0xffc93c37),
  },
  ButtonType.success: {
    ColorState.backgroundColorDefault: Color(0xff2d333b),
    ColorState.backgroundColorHoverEnter: Color(0xff347d39),
    ColorState.backgroundColorHoverExit: Color(0xff2d333b),
    ColorState.textColorDefault: Color(0xff347d39),
    ColorState.textColorHoverEnter: Colors.white,
    ColorState.textColorHoverExit: Color(0xff347d39),
  },
  ButtonType.neutral: {
    ColorState.backgroundColorDefault: Color(0xff2d333b),
    ColorState.backgroundColorHoverEnter: Color(0xff9e9e9e),
    ColorState.backgroundColorHoverExit: Color(0xff2d333b),
    ColorState.textColorDefault: Color(0xff9e9e9e),
    ColorState.textColorHoverEnter: Colors.white,
    ColorState.textColorHoverExit: Color(0xff9e9e9e),
  }
};

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.enabled,
      required this.onPressed,
      required this.type})
      : super(key: key);

  final bool enabled;
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Color buttonColor = Colors.white;
  Color textColor = Colors.black;

  @override
  void initState() {
    super.initState();
    buttonColor = colors[widget.type]![ColorState.backgroundColorDefault]!;
    textColor = colors[widget.type]![ColorState.textColorDefault]!;
  }

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        child: Text(
          widget.text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        onHover: (bool isHover) {
          if (widget.enabled) {
            setState(() {
              buttonColor = isHover
                  ? colors[widget.type]![ColorState.backgroundColorHoverEnter]!
                  : colors[widget.type]![ColorState.backgroundColorHoverExit]!;
              textColor = isHover
                  ? colors[widget.type]![ColorState.textColorHoverEnter]!
                  : colors[widget.type]![ColorState.textColorHoverExit]!;
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      );
}
