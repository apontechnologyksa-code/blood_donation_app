import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/constants/app_colors.dart';
import '../controllers/notice_controller.dart';

class NoticeView extends GetView<NoticeController> {
  const NoticeView({super.key});

  final List<String> notices = const [
    "১. অ্যাকাউন্ট করার পর সাথে সাথে প্রোফাইল আপডেট করুন।",
    "২. প্রোফাইলে সঠিক তথ্য দিন। ভুল তথ্য দিলে অ্যাকাউন্ট ডিলিট করা হবে।",
    "৩. রক্তের পোস্ট করার সময় সঠিক তথ্য প্রদান করতে হবে।",
    "৪. রক্ত চাহিদা সফল হলে সাথে সাথে পোস্টটি আপডেট করুন।",
    "৫. নিয়মিত প্রোফাইল ও পোস্ট চেক করুন যেন তথ্য আপডেট থাকে।",
    "৬. অন্যদের সাহায্য করার জন্য সদা প্রস্তুত থাকুন।",
    "৭. অন্য ব্যবহারকারীদের তথ্য যাচাই করার চেষ্টা করুন, ভুল তথ্য দেখলে রিপোর্ট করুন।",
    "৮. রক্তদান বা রিকোয়েস্ট সংক্রান্ত জরুরি খবর অবশ্যই অ্যাপের নোটিশে আপডেট করুন।",
    "৯. ব্যক্তিগত তথ্য কখনও অন্য কারো সাথে শেয়ার করবেন না।",
    "১০. অ্যাপ ব্যবহার করে যদি কারো নিরাপত্তা বা প্রাইভেসি হুমকির মুখে আসে, সঙ্গে সঙ্গে প্রশাসনকে জানান।",
    "১১. নিয়মিত লগইন করে আপনার ডোনেশন ও রিকোয়েস্ট স্ট্যাটাস চেক করুন।",
    "১২. রক্ত চাহিদা পূরণ হলে সকল পোস্ট আপডেট করে অন্যদের সাহায্য করুন।",
    "১৩. রক্তদানের অন্তত ৪ মাস পর পুনরায় রক্তদান করুন। আপনার স্বাস্থ্যই আমাদের কাছে সবার আগে।",
    "১৪. রক্তদানের আগে পর্যাপ্ত পানি পান করুন এবং পুষ্টিকর খাবার গ্রহণ করুন।",
    "১৫. কোনো দাতার সাথে কথা বলার সময় সৌজন্যবোধ বজায় রাখুন। দুর্ব্যবহার করলে আইডি স্থায়ীভাবে ব্লক করা হতে পারে।",
    "১৬. রক্তদান বা গ্রহণের জন্য কোনো প্রকার আর্থিক লেনদেন করবেন না। রক্তদান একটি নিঃস্বার্থ মানবিক সেবা।",
    "১৭. ভুল করে ভুল গ্রুপে রিকোয়েস্ট দেবেন না, এতে সময় অপচয় হয় যা রোগীর জীবনের জন্য ঝুঁকিপূর্ণ।",
    "১৮. আপনার ফোন নম্বর বা প্রোফাইল অ্যাক্টিভ রাখুন যেন প্রয়োজনে রোগীরা আপনার সাথে যোগাযোগ করতে পারে।",
    "১৯. রক্ত দান শেষ করার পর আপনার ডোনেশন হিস্ট্রি আপডেট করুন, যাতে পরবর্তী ৪ মাস আপনাকে 'Available' না দেখায়।",
    "২০. রক্তদাতার যাতায়াত বা প্রয়োজনীয় সামান্য খরচের বিষয়ে রিকোয়েস্ট করার আগেই দাতার সাথে পরিষ্কার কথা বলে নিন।",
    "২১. কোনো ভুয়া পোস্ট বা প্রতারক চক্রের সন্ধান পেলে সরাসরি 'রিপোর্ট' অপশন ব্যবহার করে এডমিনকে জানান।",
    "২২. অন্যের বিপদে পাশে দাঁড়িয়ে এই মানবিক প্ল্যাটফর্মকে সমৃদ্ধ করতে সহায়তা করুন।",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'নোটিশসমূহ',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primary, Colors.white],
            stops: const [0.0, 0.3, 0.6],
          ),
        ),
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            itemCount: notices.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade100,
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.red.shade700,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    notices[index],
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
