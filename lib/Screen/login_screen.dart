import 'package:cinema/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  static String screenName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // To balance the bottom Expanded Widget
            Expanded(child: Container()),
            // Logo Placeholder
            SvgPicture.asset('assets/icons/AppIcon.svg'),
            const SizedBox(height: 50.0),
            // Email TextField
            emailInputField(),
            const SizedBox(height: 20.0),
            // Password TextField
            passwordInputField(),
            const SizedBox(height: 15),
            // Forgot Password Text
            forgetPaswordButton(),
            const SizedBox(height: 15),
            // Login Button
            loginButton(),
            const SizedBox(height: 20.0),
            const SizedBox(height: 20.0),
            // Social Media Buttons
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: darkTheme.colorScheme.onPrimary),
                          child: SvgPicture.asset(
                            'assets/icons/google.svg',
                            height: 30,
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Google',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 45,
                    ), // Placeholder for Google logo
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: darkTheme.colorScheme.onPrimary),
                          child: SvgPicture.asset(
                            'assets/icons/facebook.svg',
                            height: 34,
                            width: 34,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Facebook',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkTheme.colorScheme.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {},
      child: Text(
        'Login',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: darkTheme.colorScheme.onPrimary),
      ),
    );
  }

  Row forgetPaswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: const Text(
            'Forgot password?',
          ),
        ),
      ],
    );
  }

  TextField passwordInputField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.visibility_off,
          color: darkTheme.colorScheme.primaryContainer,
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: darkTheme.colorScheme.primary,
        ),
        hintText: 'Password',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: darkTheme.colorScheme.primary,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  TextField emailInputField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.email,
          color: darkTheme.colorScheme.primary,
        ),
        hintText: 'Email',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: darkTheme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
