import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class RequestCard extends StatelessWidget {
  final ThemeData theme;
  final String name;
  final String hospital;
  final String location;
  final String blood;
  final String units;
  final String time;
  final String date;
  final String? description;
  final String status;
  final String reason;
  final VoidCallback onTap;
  final VoidCallback onCall;

  const RequestCard({
    super.key,
    required this.theme,
    required this.name,
    required this.hospital,
    required this.location,
    required this.blood,
    required this.units,
    required this.time,
    required this.reason,
    required this.onTap,
    required this.onCall,
    required this.status,
    required this.date,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final cs = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 5),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 6),

                      _buildInfoRow(Iconsax.hospital, hospital, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.location, location, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.bag, units, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.timer, time, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.calendar_1, date, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.status, status, theme),
                      const SizedBox(height: 4),
                      _buildInfoRow(Iconsax.data, description!, theme),
                      const SizedBox(height: 4),

                      const SizedBox(height: 10),

                      if (reason.isNotEmpty) ...[
                        Text(
                          "কারণ: $reason",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 47,
                      width: 47,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            blood,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    Material(
                      color: Colors.green.withValues(alpha: 0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: onCall,
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Iconsax.call,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey.shade700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
