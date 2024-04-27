import 'package:cinema/core/common/constants/assets.dart';
import 'package:cinema/core/themes/theme_data.dart';
import 'package:cinema/core/utils/localizations.dart';
import 'package:flutter/material.dart';

class UserDetailsForm extends StatefulWidget {
  final Function(String email, String phoneNumber, String password) onSubmitted;

  const UserDetailsForm({Key? key, required this.onSubmitted})
      : super(key: key);

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(24)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(
                Assets.images.icCinema,
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: darkTheme.colorScheme.primary,
                ),
                hintText: translates(context).email,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: darkTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: darkTheme.colorScheme.primary,
                ),
                hintText: translates(context).phonenumber,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: darkTheme.colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                return null;
              },
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
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
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                if (value.length < 8) {
                  return translates(context).passwordlength;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _rePasswordController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_reset_rounded,
                  color: darkTheme.colorScheme.primary,
                ),
                hintText: translates(context).reenterpassword,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: darkTheme.colorScheme.primary,
                  ),
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translates(context).required;
                }
                if (value != _passwordController.text) {
                  return translates(context).passwordnotmatch;
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('Form is valid!');
                  widget.onSubmitted(_emailController.text,
                      _phoneNumberController.text, _passwordController.text);
                }
              },
              child: Text(translates(context).continueword),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }
}
