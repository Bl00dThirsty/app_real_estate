import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../services/authentication_services.dart';
import '../../../../utils/helpers/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final TextEditingController email = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService(); // Instance de AuthService

  void resetControllers() {
    email.clear();
    lastName.clear();
    username.clear();
    password.clear();
    firstName.clear();
    phoneNumber.clear();
  }

  @override
  void onClose() {
    // Ne pas disposer les contrôleurs
    super.onClose();
  }

  /// -- SIGNUP
  Future<void> signup() async {
    try {
      /// Form validation
      if (!signupFormKey.currentState!.validate()) return;

      // Register User in the firebase Authentication & Save user data in the Firebase
      final user = await _authService.signUpWithEmailAndPassword(email.text, password.text, username.text);
      if (user != null) {
        // Save Authenticated user data in the Firebase firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'firstName': firstName.text,
          'lastName': lastName.text,
          'username': username.text,
          'email': email.text,
          'phoneNumber': phoneNumber.text,
          'category': 'visitor', // Initial category
        });

        // Save success message
        TLoaders.successSnackBar(title: 'Succès', message: 'Inscription réussie');

        // Move to home page
        Get.offAllNamed('/home');
      }
    } catch (e) {
      // Show some generic error to the user
      TLoaders.warningSnackBar(title: 'Oh snap', message: e.toString());
    } finally {
      // Remove loader
      // TFullScreenLoader.closeLoadingDialog();
    }
  }
}
