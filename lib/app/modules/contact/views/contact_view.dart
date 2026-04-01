import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donation_app/app/utils/constants/app_colors.dart';
import '../controllers/contact_controller.dart';

class ContactView extends GetView<ContactController> {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    // থিম ভেরিয়েবলগুলো আগে ডিফাইন করে নিলে কোড ক্লিন থাকে
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('যোগাযোগ করুন'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // প্রোফাইল/সাপোর্ট আইকন সেকশন
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Icon(
                  Icons.support_agent_rounded,
                  size: 60,
                  color: AppColors.primary
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "আমরা আপনাকে সাহায্য করতে প্রস্তুত",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.titleLarge?.color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "যেকোনো প্রশ্ন বা জরুরি প্রয়োজনে আমাদের সাথে যোগাযোগ করুন",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30),

            // কন্টাক্ট মেথড কার্ডস
            _buildContactCard(
              context,
              title: "সরাসরি কল করুন",
              subtitle: "+8801746428299",
              icon: Icons.phone_forwarded_rounded,
              color: Colors.green, // কল আইকন সবসময় গ্রিন থাকা ভালো
              onTap: () => controller.makePhoneCall("+8801746428299"),
            ),

            _buildContactCard(
              context,
              title: "ইমেইল পাঠান",
              subtitle: "xyz2024.bangla@gmail.com",
              icon: Icons.email_rounded,
              color: Colors.orange,
              onTap: () => controller.sendEmail("xyz2024.bangla@gmail.com"),
            ),

            _buildContactCard(
              context,
              title: "ফেসবুক পেজ",
              subtitle: "iamabdulahad01", // লিঙ্ক বড় হলে ছোট করে দেখানো ভালো
              icon: Icons.facebook_rounded,
              color: Colors.blue,
              onTap: () => controller.launchWebsite("https://www.facebook.com/iamabdulahad01"),
            ),

            const SizedBox(height: 40),

            // ভার্সন টেক্সট যা থিম অনুযায়ী কালার বদলাবে
            Text(
              "ভার্সন: ১.০.০",
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: isDark ? Colors.white30 : Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: isDark ? 0 : 2, // ডার্ক মোডে এলিভেশন ০ রাখলে ভালো দেখায়
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          // বর্ডার কালার থিম অনুযায়ী হালকা বা গাঢ় হবে
          color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      color: theme.cardColor, // থিমের কার্ড কালার ব্যবহার করা হয়েছে
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // আইকনের পেছনের ব্যাকগ্রাউন্ড হালকা কালার
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        trailing: Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: isDark ? Colors.white24 : Colors.black26
        ),
      ),
    );
  }
}