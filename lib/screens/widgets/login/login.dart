import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/login_signup/social_button.dart';
import '../../../services/authentication_services.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../common/widgets/login_signup/form_divider.dart';
import '../login_form.dart';
import '../login_header.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool inLoginProcess = false;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              /// Logo, Titre & Sous-titre
              const TLoginHeader(),


              /// Form
              TLoginForm(inLoginProcess: inLoginProcess,onPressed: () => signIn()),

              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),

              const SizedBox(height: TSizes.spaceBtwSections),
              /// Footer

              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
  signIn() {
    setState(() {
      inLoginProcess = true;
      AuthService().signInWithGoogle();
    });
  }
}


