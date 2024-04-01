import 'package:flutter/material.dart';
import 'package:random_chat/screen/dashboard.dart';
import 'package:random_chat/services/auth/auth_services.dart';
import 'package:random_chat/component/button.dart';
import 'package:random_chat/component/text_field.dart';
import 'package:random_chat/screen/register.dart';

class Login extends StatelessWidget {
  Login({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();

  @override
  Widget build(context) {
    void navigateTab() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Register()));
    }

    void loginTab() async {
      final service = AuthService();
      try {
        service.userCredential(emailController.text, passwdController.text);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return Dashboard();
        // }));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Faild to login'),
          ),
        );
      }
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
            Button(label: 'Login', onTab: loginTab),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You don\'t have account?'),
                GestureDetector(
                  onTap: navigateTab,
                  child: Text(
                    'Register',
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
