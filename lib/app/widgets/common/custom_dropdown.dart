import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;

  final String? Function(T?)? validator;
  final bool isExpanded;

  const CustomDropdown({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        validator: validator,
        isExpanded: isExpanded,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.grey.shade700,
        ),
        decoration: InputDecoration(
          filled: true,
          labelText: labelText,
          hintText: hintText,

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),

          prefixIcon: Icon(icon, color: Colors.grey.shade600),

          floatingLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
