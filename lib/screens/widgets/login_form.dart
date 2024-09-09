import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../features/authentication/controllers/signup/signup_controller.dart';
import '../../features/authentication/screens/signup/signup.dart';
import '../../services/authentication_services.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/constants/text_strings.dart';
import '../../utils/validators/validation.dart';
import '../../widgets/toast.dart';

class TLoginForm extends StatefulWidget {
  final bool inLoginProcess;
  final VoidCallback onPressed;

  const TLoginForm({
    super.key,
    required this.inLoginProcess,
    required this.onPressed,
  });

  @override
  State<TLoginForm> createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final SignupController controller = Get.put(SignupController());
  final AuthService _auth = AuthService();
  bool _isSigning = false;
  bool _obscureText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.resetControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// E-Mail
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: TTexts.email,
              ),
              controller: controller.email,
              validator: (value) => TValidator.validateEmail(value),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            /// Password
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: TTexts.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields / 2),
            /// Remember me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // -- Remember Me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TTexts.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(TTexts.forgetPassword),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            /// Sign In Button
            widget.inLoginProcess
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _signIn,
                child: const Text(TTexts.signIn),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Create Account Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: widget.onPressed,
                child: const Text(TTexts.createAccount),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });
    String email = controller.email.text;
    String password = controller.password.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    setState(() {
      _isSigning = false;
    });
    if (user != null) {
      showToast(message: 'Connexion réussie');
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showToast(message: 'Échec de la connexion');
    }
  }
}


