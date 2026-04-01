import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/helpers/bangla_datetime_formatter.dart';
import '../../../data/helpers/contact_helper.dart';
import '../../../utils/constants/app_config.dart';
import '../../../widgets/blood_request/blood_request_card_item.dart';
import '../controllers/success_request_controller.dart';

class SuccessRequestView extends GetView<SuccessRequestController> {
  const SuccessRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('সফল রক্ত অনুরোধ'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.bloodPosts.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text("কোনো রিকোয়েস্ট নেই")),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.bloodPosts.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final post = controller.bloodPosts[index];
                      final name = post.name ?? '';
                      final hospital = post.hospital ?? '';
                      final location = "ঠিকানা : ${post.location ?? ""}";
                      final phone = post.phone ?? '';
                      final bloodGroup = post.bloodGroup ?? '';
                      final unit = post.unit ?? 0;
                      final time =
                          "সময়: ${BanglaDateTimeFormatter.formatTime(post.time ?? "")}";
                      final date =
                          "তারিখ: ${BanglaDateTimeFormatter.formatDate(post.date ?? "")}";
                      final status = "পোস্টের অবস্থা : ${post.status ?? ''}";
                      final reason = "রোগীর সমস্যা : ${post.reason ?? ''}";
                      final description = "${post.description ?? ''}";
                      final createdAt =
                          "${BanglaDateTimeFormatter.formatBanglaDateTime(post.createdAt ?? "")}";
                      final profileImage =
                          "${AppConfig.baseUrl}/storage/${post.user?.profileImage ?? ""}";
                      final profileName = post.user?.name ?? '';

                      return BloodRequestCard(
                        name: name,
                        date: date,
                        time: time,
                        description: description,
                        hospital: hospital,
                        location: location,
                        bloodGroup: bloodGroup,
                        unit: unit,
                        status: status,
                        reason: reason,
                        phone: phone,
                        profileImage: profileImage,
                        profileName: profileName,
                        createdAt: createdAt,
                        onCall: () => ContactHelper.makeCall(post.phone),
                        onShare: () => ContactHelper.shareBloodRequest(post),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
