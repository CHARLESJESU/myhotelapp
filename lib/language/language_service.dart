import 'package:get/get.dart';
import 'language_controller.dart';

class LanguageService {
  static Future<void> initialize() async {
    Get.put(LanguageController());
    await Get.find<LanguageController>().loadPreferredLanguage();
  }
  
  static LanguageController get controller => Get.find<LanguageController>();
}