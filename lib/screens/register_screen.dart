import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final void Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Password does not match")));
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
          emailController.text, passwordController.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Account created")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.message, size: 80),
                  const SizedBox(height: 50),
                  const Text("Let's create a new account",
                      style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 30),
                  MyTextField(
                      controller: emailController,
                      hint: "Email",
                      obsecureText: false),
                  const SizedBox(height: 20),
                  MyTextField(
                      controller: passwordController,
                      hint: "Password",
                      obsecureText: true),
                  const SizedBox(height: 20),
                  MyTextField(
                      controller: confirmPasswordController,
                      hint: "Confirm Password",
                      obsecureText: true),
                  const SizedBox(height: 20),
                  MyButton(onTap: signUp, text: "Register"),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account? ",
                          style: TextStyle(fontSize: 16)),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text("Sign in",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
