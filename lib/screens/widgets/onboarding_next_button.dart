import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../../../utils/helpers/helper_functions.dart';

import '../../utils/constants/colors.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: 25,
      bottom: 20,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape:  const CircleBorder(), backgroundColor: dark ? TColors.primary :  Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),);
  }
}