import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/network_manager.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// -- SIGNUP
  Future<void> signup() async {
    try{
      // Start Loading

      // Form validation
      final isConnected = await NetworkManager.instance.isConnected();
      // Privacy Policy Check

      // Register User in the firebase Authentication & Save user data in the Firebase

      // Save Authenticated user data in the Firebase firestore

      // Save success message

      // Move to verify
    } catch(e) {
      // Show some generic error to the user
    } finally {
      // Remove loader
    }
  }
}