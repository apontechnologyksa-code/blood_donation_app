import 'dart:convert';

import 'package:blood_donation_app/app/data/model/post.dart';
import 'package:blood_donation_app/app/data/services/blood_services.dart';
import 'package:get/get.dart';

import '../../../data/helpers/app_snackbar.dart';

class MyBloodPostController extends GetxController {
  final BloodServices bloodServices = BloodServices();
  final isLoading = false.obs;

  final posts = <Post>[].obs;

  final searchPost = <Post>[].obs;
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getBloodPost();
  }

  void getBloodPost() async {
    try {
      isLoading.value = true;

      final response = await bloodServices.bloodPostShow();
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['status'] == true) {
        List data = result['data'];

        posts.clear();
        for (int i = 0; i < data.length; i++) {
          posts.add(Post.fromJson(data[i]));
        }

        applySearch(searchText.value);
      } else {
        showAppSnackbar(
          title: "Error",
          message: result['message'],
          isError: true,
        );
      }
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        message: "Something went wrong",
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deletePost(String id) async {
    try {
      final response = await bloodServices.bloodDelete(id);
      final result = jsonDecode(response.body);

      if (response.statusCode == 200 && result['status'] == true) {
        showAppSnackbar(
          title: "সাফল্য",
          message: "পোস্টটি সফলভাবে মুছে ফেলা হয়েছে",
        );

        getBloodPost();
      } else {
        showAppSnackbar(
          title: "Error",
          message: result['message'],
          isError: true,
        );

      }
    } catch (e) {
      showAppSnackbar(
        title: "Error",
        message: "Something went wrong : $e",
        isError: true,
      );
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    applySearch(value);
  }

  void applySearch(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      searchPost.assignAll(posts);
      return;
    }

    searchPost.assignAll(
      posts.where((e) {
        final name = (e.name ?? "").toLowerCase();
        final hospital = (e.hospital ?? "").toLowerCase();
        final location = (e.location ?? "").toLowerCase();
        final bloodGroup = (e.bloodGroup ?? "").toLowerCase();
        final time = (e.time ?? "").toLowerCase();
        final date = (e.date ?? "").toLowerCase();
        final reason = (e.reason ?? "").toLowerCase();
        final description = (e.description ?? "").toLowerCase();

        return name.contains(q) ||
            hospital.contains(q) ||
            location.contains(q) ||
            bloodGroup.contains(q) ||
            time.contains(q) ||
            date.contains(q) ||
            reason.contains(q) ||
            description.contains(q);
      }).toList(),
    );
  }

  void clearSearch() {
    searchText.value = '';
    searchPost.assignAll(posts);
  }
}