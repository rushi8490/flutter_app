import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'login_button.dart';
import 'package:http/http.dart' as http;

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final String email = "decoration@head.com";
  final String password = "head1234";
  // Initialize controllers for email and password fields
  final TextEditingController emailController = TextEditingController(text: "decoration@head.com");
  final TextEditingController passwordController = TextEditingController(text: "head1234");
  final storage = GetStorage();
  bool isPasswordShown = false;
  bool isLoading = false;  // To manage the loading state
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() async {
    // final bool isFormOkay = _key.currentState?.validate() ?? false;
    // if (isFormOkay) {
    //   Navigator.pushNamed(context, AppRoutes.entryPoint);
    // }

    setState(() {
      isLoading=true;
    });
    const String apiUrl = 'https://avd-assests.uc.r.appspot.com/api/v1/auth/login'; // Replace with your API URL

    // Prepare the data to send in the API request
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Retrieve cookies from the response headers
        final setCookie = response.headers['set-cookie'];
        if (setCookie != null) {
          // Store the cookie in GetStorage
          storage.write('cookie', setCookie);
          debugPrint('Cookie stored: $setCookie');
          setState(() {
            isLoading=false;
          });
        }

        // Navigator.pushNamed(context, AppRoutes.entryPoint);
        Navigator.popAndPushNamed(context, AppRoutes.entryPoint);
      } else {
        setState(() {
          isLoading = false;
        });
        // Handle error
        debugPrint('Login failed: ${response.body}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDefaults.padding),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phone Field
                  const Text("Email"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.number,
                    validator: Validators.requiredWithFieldName('Email').call,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppDefaults.padding),

                  // Password Field
                  const Text("Password"),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: passwordController,
                    validator: Validators.password.call,
                    onFieldSubmitted: (v) => onLogin(),
                    textInputAction: TextInputAction.done,
                    obscureText: !isPasswordShown,
                    decoration: InputDecoration(
                      suffixIcon: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: onPassShowClicked,
                          icon: SvgPicture.asset(
                            AppIcons.eye,
                            width: 24,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Forget Password labelLarge
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  //     },
                  //     child: const Text('Forget Password?'),
                  //   ),
                  // ),
                   const SizedBox(height: 40.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: LoginButton(onPressed: onLogin),
                  ),
                  // Login labelLarge

                ],
              ),
            ),
          ),
          // Loader overlay
          // Full-screen loader overlay
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.5), // Opaque white background
                child: const Center(
                  child: CircularProgressIndicator(), // Centered loader
                ),
              ),
            ),
        ],
      )
    );
  }
}
