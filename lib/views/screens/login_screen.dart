import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:quiz_app_with_animation/controllers/firebase_auth_controller.dart';
import 'package:quiz_app_with_animation/views/screens/home_screen.dart';
import 'package:quiz_app_with_animation/views/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebaseAuthController = FirebaseAuthController();

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      try {
        await firebaseAuthController.login(
          email: emailController.text,
          password: passwordController.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login xatosi: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 50),
                const Gap(30),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos email kiriting";
                    }
                    return null;
                  },
                ),
                const Gap(15),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Iltimos parolni kiriting";
                    }
                    return null;
                  },
                ),
                const Gap(50),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: FilledButton(
                    onPressed: _login,
                    child: const Text("Tizimga kirish"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                      return const RegisterScreen();
                    }));
                  },
                  child: const Text("Ro'yxatdan o'tish"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
