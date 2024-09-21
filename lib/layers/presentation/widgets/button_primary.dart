import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const ButtonPrimary({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
