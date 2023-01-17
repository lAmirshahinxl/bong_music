import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Color backgroundColor;
  final double radius;

  const SubmitButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 150,
    this.height = 45,
    this.radius = 30,
    this.textColor = Colors.black,
    this.backgroundColor = const Color(0xffFFC70D),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius),
      color: backgroundColor,
      child: InkWell(
        onTap: () {
          onPressed();
        },
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
