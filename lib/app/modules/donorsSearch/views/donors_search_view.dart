import 'package:blood_donation_app/app/modules/bloodGroupSearchTab/views/blood_group_search_tab_view.dart';
import 'package:blood_donation_app/app/modules/locationSearchTab/views/location_search_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/donors_search_controller.dart';


class DonorsSearchView extends StatelessWidget {
  const DonorsSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ডোনার খুঁজুন'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: "রক্তের গ্রুপ"),
              Tab(text: "লোকেশন"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BloodGroupSearchTabView(),
            LocationSearchTabView(),
          ],
        ),
      ),
    );
  }
}




