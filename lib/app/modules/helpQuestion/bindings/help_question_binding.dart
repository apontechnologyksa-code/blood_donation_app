import 'package:get/get.dart';

import '../controllers/help_question_controller.dart';

class HelpQuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HelpQuestionController());
  }
}
