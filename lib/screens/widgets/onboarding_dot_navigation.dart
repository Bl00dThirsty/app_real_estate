import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../../utils/device/device_utility.dart';


class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: 10,
      //effect: ExpandingDotsEffect(activateDotColor: TColors.dark, dotHeight: 6),
      child: SmoothPageIndicator(controller: controller.pageController, onDotClicked: controller.dotNavigationClick, count: 3, effect: ExpandingDotsEffect(activeDotColor: dark ? TColors.light: TColors.dark,  dotHeight: 6),),
    );
  }
}