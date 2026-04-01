import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final IconData icon;
  final String valueText;
  final VoidCallback onTap;
  final String? errorText;

  const CustomDateField({
    super.key,
    required this.labelText,
    this.hintText,
    required this.icon,
    required this.valueText,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        isEmpty: valueText.isEmpty,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          errorText: errorText,
        ),
        child: Text(
          valueText.isEmpty ?  valueText : valueText,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: valueText.isEmpty
                ? theme.textTheme.bodySmall?.color
                : theme.textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}