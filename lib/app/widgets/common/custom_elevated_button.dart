import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String text;
  final bool isLoading;
  final Color? color;
  final Color? textColor;

  const CustomElevatedButton({
    super.key,
    this.onPress,
    required this.text,
    this.isLoading = false,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {

    final bgColor = color ?? const Color(0xFFE53935);
    final txtColor = textColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: bgColor.withValues(alpha: 0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(txtColor),
          ),
        )
            : Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: txtColor,
          ),
        ),
      ),
    );
  }
}