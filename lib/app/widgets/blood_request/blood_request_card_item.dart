import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../data/helpers/bangla_datetime_formatter.dart';
import '../../utils/constants/app_images.dart';

class BloodRequestCard extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String description;
  final String hospital;
  final String location;
  final String reason;
  final String phone;
  final String bloodGroup;
  final int unit;
  final String status;
  final VoidCallback onCall;
  final VoidCallback onShare;
  final String profileImage;
  final String profileName;
  final String createdAt;


  const BloodRequestCard({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
    required this.hospital,
    required this.location,
    required this.bloodGroup,
    required this.unit,
    required this.status,
    required this.onCall,
    required this.onShare, required this.profileImage, required this.profileName, required this.createdAt, required this.reason, required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.red.withValues(alpha: 0.1),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: profileImage,
                      fit: BoxFit.cover,
                      width: 48,
                      height: 48,
                      placeholder: (context, url) => ClipOval(
                        child: Image.asset(
                          width: 48,
                          height: 48,
                          AppImages.avatarImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      errorWidget: (context, url, error) => ClipOval(
                        child: Image.asset(
                          width: 48,
                          height: 48,
                          AppImages.avatarImage,
                          fit: BoxFit.cover,
                        ),
                      )
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profileName,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        createdAt,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBloodBadge(bloodGroup),
              ],
            ),

            Divider(height: 24, thickness: 0.8, color: colorScheme.outlineVariant),









            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoIcon(
                  context,
                  Iconsax.copy_success,
                  status,
                ),                const SizedBox(width: 15),
                _buildInfoIcon(context, Icons.water_drop_outlined, "পরিমাণ : ${BanglaDateTimeFormatter.toBanglaNumber(unit.toString())} ব্যাগ",),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoIcon(context, Iconsax.arrow_down, "রক্ত দেওয়ার তারিখ ও সময়"),


              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoIcon(context, Iconsax.calendar_1, date),
                const SizedBox(width: 15),
                _buildInfoIcon(context, Icons.access_time, time),
              ],
            ),

            const SizedBox(height: 8),



            _buildInfoIcon(context, Iconsax.hospital, hospital),




            const SizedBox(height: 8),

            _buildInfoIcon(context, Iconsax.location, location),

            const SizedBox(height: 8),

            _buildInfoIcon(context, Icons.info_outline, reason),


            const SizedBox(height: 8),


            Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.4,
                color: colorScheme.onSurface,
              ),
            ),



            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: onCall,
                      icon: const Icon(Iconsax.call, size: 18, color: Colors.white),
                      label: const Text(
                        "ফোন করুন",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: onShare,
                      icon: const Icon(Iconsax.share, size: 18),
                      label: const Text("শেয়ার করুন"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.redAccent,
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )


          ],
        ),
      ),
    );
  }


  Widget _buildBloodBadge(String bloodGroup) {
    return Container(
     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        bloodGroup,
        style: const TextStyle(
          color:AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }


  Widget _buildInfoIcon(BuildContext context, IconData icon, String text, {bool isUrgent = false}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: isUrgent ? Colors.orange : colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }}