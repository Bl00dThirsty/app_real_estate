import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../screens/widgets/login/login.dart';

//import '../login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();


  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// Mise à jour de l'index de la page lorsqu'on scrolle
  void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Sauter pour la page spécifiée
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);

  }

  void nextPage() {
    if(currentPageIndex.value == 2) {
      // final storage = GetStorage();
      Get.offAll(const LoginScreen());

      /*if (kDebugMode) {
        print('=============================== GET STORAGE Next button =================================');
        print(storage.read('IsFirstTime'));
      }*/

      // Get.offAll(const LoginScreen());
    }
    else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}



