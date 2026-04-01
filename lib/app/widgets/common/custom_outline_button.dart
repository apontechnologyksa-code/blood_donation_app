import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;

  const CustomOutlineButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,

                ),
              )
            : Text(text, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
