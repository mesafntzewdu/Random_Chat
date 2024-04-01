import 'package:flutter/material.dart';
import 'package:random_chat/services/auth/auth_services.dart';
import 'package:random_chat/component/button.dart';
import 'package:random_chat/component/text_field.dart';
import 'package:random_chat/screen/login.dart';

class Register extends StatelessWidget {
  Register({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  TextEditingController confirmPasswdController = TextEditingController();
  AuthService _auth = AuthService();

  @override
  Widget build(context) {
    void snacBarMethod(String text) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }

    void navigateTab() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    }

    void onRegisterTab() {
      if (passwdController.text != confirmPasswdController.text) {
        snacBarMethod('Password does not match!');
        return;
      }
      _auth.signUP(emailController.text, passwdController.text);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.message,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Well come back!',
              style: TextStyle(fontSize: 35),
            ),
            InputText(
              hintText: 'Your email address',
              obsecure: false,
              textInputControl: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputText(
              hintText: 'Your password',
              obsecure: true,
              textInputControl: passwdController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputText(
              hintText: 'Confirm Your password',
              obsecure: true,
              textInputControl: confirmPasswdController,
            ),
            const SizedBox(
              height: 10,
            ),
            Button(
              label: 'Register',
              onTab: onRegisterTab,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have account?'),
                GestureDetector(
                  onTap: navigateTab,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
