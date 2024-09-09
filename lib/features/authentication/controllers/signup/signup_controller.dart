import 'package:app_real_estate/utils/helpers/loaders.dart';
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
      /// TFullScreenLoader.openLoadingDialog("Nous chargons vos informations...", TImages.doceranimation);

      /// check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) return;

      /// Form validation
      if (!signupFormKey.currentState!.validate()) return;

      // Privacy Policy Check

      // Register User in the firebase Authentication & Save user data in the Firebase

      // Save Authenticated user data in the Firebase firestore

      // Save success message

      // Move to verify
    } catch(e) {
      // Show some generic error to the user
      TLoaders.warningSnackBar(title: 'oh snap', message: e.toString());
    } finally {
      // Remove loader
      //TFullScreenLoader
      TLoaders.successSnackBar(title: "title");
    }
  }
}