import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle,
  });

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: 200, //THelperFunctions.screenWidth() * 0.5, // 0.8
            height: 500, //THelperFunctions.screenHeight() * 0.5, // 0.6
            image: AssetImage(image),
          ),
          Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center ),
          const SizedBox(height: 10,),
          Text(subTitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center )
        ],
      ),

    );
  }
}