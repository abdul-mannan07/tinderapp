import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderapp/provider/name_screen_provider.dart';
import 'package:tinderapp/presentation/screens/browsing_flow/bottomnavigation_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<NameProvider>(context, listen: false);
    provider.disableSignUpMode();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        final provider = Provider.of<NameProvider>(context, listen: false);
        provider.clearControllers();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 4,
            centerTitle: true,
            title: const Text(
              "Sign In",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<NameProvider>(
              builder: (context, provider, child) {
                // provider.isSignUp ;

                return Form(
                  key: _globalKey,
                  child: Column(
                    children: [
                      // Email Field
                      TextFormField(
                        controller: provider.emailController,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                        ),
                        validator: (value) => provider.validateEmail(),
                      ),
                      const SizedBox(height: 20),

                      // Password Field
                      TextFormField(
                        controller: provider.passwordController,
                        style: const TextStyle(color: Colors.black),
                        obscureText: provider.obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              provider.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () => provider.toggleObscure(),
                          ),
                        ),
                        validator: (value) => provider.validatePassword(),
                      ),
                      const SizedBox(height: 30),

                      // Sign In Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: provider.isFormValid
                                ? Colors.pink
                                : Colors.grey,
                          ),
                          onPressed: provider.isFormValid && !provider.isLoading
                              ? () async {
                                  if (_globalKey.currentState!.validate()) {
                                    final uid = await provider.signIn();
                                    if (uid != null && mounted) {
                                      provider
                                          .clearControllers(); // clear AFTER successful sign-in
                                      print(
                                        'Email: ${provider.emailController.text}',
                                      ); // should be empty
                                      print(
                                        'Password: ${provider.passwordController.text}',
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const BottomNavScreen(),
                                        ),
                                      );
                                    }
                                  }
                                }
                              : null,
                          child: provider.isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
