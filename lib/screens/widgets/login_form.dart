import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/authentication/screens/signup/signup.dart';
import '../../screens/widgets/login/login.dart';
import '../../services/authentication_services.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';

class TLoginForm extends StatelessWidget {
  TLoginForm({
    super.key,
    required this.inLoginProcess,
    required this.onPressed,
  });
  final bool inLoginProcess;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// E-Mail
            TextFormField(
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email,),

            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            TextFormField(
              decoration: const InputDecoration(prefixIcon: Icon(Iconsax.password_check), labelText: TTexts.password, suffixIcon: Icon(Iconsax.eye_slash)),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),

            /// Remember me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -- Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value){}),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                TextButton(onPressed: (){}, child: const Text(TTexts.forgetPassword))
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign In Button

            SizedBox(
              width: double.infinity,

            ),
            inLoginProcess ? Center(child: CircularProgressIndicator(),) : SizedBox(width: double.infinity, child: OutlinedButton(onPressed: onPressed, child: const Text(TTexts.signIn))),
            const SizedBox(height: TSizes.spaceBtwItems),
            /// Create Account Button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) => SignupScreen()),);}, child: const Text(TTexts.createAccount)),),

            //const SizedBox(height: TSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}