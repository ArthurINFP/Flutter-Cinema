import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/features/home/home_screen_route.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_event.dart';
import 'package:cinema/core/features/login/presentation/bloc/login_bloc/login_state.dart';
import 'package:cinema/core/features/login/presentation/register_screen_route.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:cinema/core/themes/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late LoginBloc bloc;
  bool obscureText = true;
  late LoginState _state;
  String? _errorMessage;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LoginBloc>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoadingLoginState) {
          EasyLoading.show();
        } else if (state is SuccessfulLoginState) {
          EasyLoading.dismiss();
          (state.message != null)
              ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message!),
                  behavior: SnackBarBehavior.floating,
                ))
              : null;
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(context, HomeScreenRoute.screenName);
        } else if (state is FailedLoginState) {
          EasyLoading.dismiss();
          _errorMessage = state.message;
          showOkAlertDialog(context: context, message: state.message);
        } else if (state is FailedLoginState) {
          EasyLoading.dismiss();
          showOkAlertDialog(context: context, message: state.message);
        } else {
          EasyLoading.dismiss();
          showOkAlertDialog(
              context: context, message: 'Something went wrong 2');
        }
      },
      builder: (context, state) {
        _state = state;
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
                SvgPicture.asset(Assets.svg.icAppLogo),
                const SizedBox(height: 50.0),
                // Email TextField
                usernameInputField(context),
                const SizedBox(height: 20.0),
                // Password TextField
                passwordInputField(context),
                const SizedBox(height: 15),
                // Forgot Password Text
                forgetPaswordAndSignUpRow(context),
                const SizedBox(height: 15),
                // Login Button
                loginButton(),
                const SizedBox(height: 20.0),
                const SizedBox(height: 20.0),
                // Social Media Buttons
                thirdPartyLogin(),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded thirdPartyLogin() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    bloc.add(ThirdPartyLoginEvent(isGoogle: true));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkTheme.colorScheme.onPrimary),
                    child: SvgPicture.asset(
                      Assets.svg.icGoogleLogo,
                      height: 30,
                      width: 30,
                    ),
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
                GestureDetector(
                  onTap: () {
                    bloc.add(ThirdPartyLoginEvent(isGoogle: true));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: darkTheme.colorScheme.onPrimary),
                    child: SvgPicture.asset(
                      Assets.svg.icFacebookLogo,
                      height: 34,
                      width: 34,
                    ),
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
      onPressed: () {
        final event = UsernamePasswordLoginEvent(
            username: usernameController.text,
            password: passwordController.text);
        bloc.add(event);
      },
      child: Text(
        'Login',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: darkTheme.colorScheme.onPrimary),
      ),
    );
  }

  Row forgetPaswordAndSignUpRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RegisterScreenRoute.screenName);
          },
          child: Text(
            translates(context).signup,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            translates(context).forgotPassword,
          ),
        ),
      ],
    );
  }

  TextField usernameInputField(BuildContext context) {
    return TextField(
      controller: usernameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: (_state is FailedLoginState)
            ? ((_state as FailedLoginState).isFailedAtUsername == true
                ? (_state as FailedLoginState).message
                : null)
            : null,
        prefixIcon: Icon(
          Icons.email,
          color: darkTheme.colorScheme.primary,
        ),
        hintText: translates(context).username,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: darkTheme.colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget passwordInputField(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorText: (_state is FailedLoginState)
            ? ((_state as FailedLoginState).isFailedAtPassword == true
                ? (_state as FailedLoginState).message
                : null)
            : null,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            Icons.visibility_off,
            color: darkTheme.colorScheme.primaryContainer,
          ),
        ),
        prefixIcon: Icon(
          Icons.lock,
          color: darkTheme.colorScheme.primary,
        ),
        hintText: translates(context).password,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: darkTheme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
