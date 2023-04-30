import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth_bloc/auth_bloc.dart';
import '../Login_screen_content_widgets/forgot_password_button.dart';
import '../Login_screen_content_widgets/login_and_signup_button.dart';
import '../Login_screen_content_widgets/validation_custom_text_form_field.dart';

class LoginSignUpForm extends StatefulWidget {
  final bool isLogin;
  const LoginSignUpForm({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<LoginSignUpForm> createState() => _LoginSignUpFormState();
}

class _LoginSignUpFormState extends State<LoginSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  var _isloading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isloading = true;
      });
      BlocProvider.of<AuthBloc>(context)
          .add(LogInOrSignUpUserWithEmailAndPasswordEvent(
        isLogin: widget.isLogin,
        email: _emailController.text,
        password: _passwordController.text,
      ));
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ValidationCustomTextFormField(
            textFeildLabel: "Email",
            textFieldIcon: Icons.person,
            onSavedFunc: (value) {
              _emailController.text = value;
            },
            validatorFunc: (String? value) {
              if (value == null || value.isEmpty) {
                return "Email address is requierd";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ValidationCustomTextFormField(
            textFeildLabel: "Password",
            textFieldIcon: Icons.lock,
            onSavedFunc: (value) {
              _passwordController.text = value;
            },
            validatorFunc: (String? value) {
              if (value == null || value.isEmpty) {
                return "Password is requierd";
              } else if (value.length < 8) {
                return "Password should be more than 8 characters";
              }
              _passwordController.text = value;
              return null;
            },
          ),
          if (!widget.isLogin) ...[
            const SizedBox(
              height: 30,
            ),
            ValidationCustomTextFormField(
              textFeildLabel: "Confirm Password",
              textFieldIcon: Icons.lock,
              onSavedFunc: (value) {},
              validatorFunc: (value) {
                if (value != _passwordController.text) {
                  return "Password should be the same";
                }
                return null;
              },
            ),
          ],
          const SizedBox(
            height: 5,
          ),
          if (widget.isLogin) const ForgotPasswordbutton(),
          const SizedBox(
            height: 20,
          ),
          !_isloading
              ? LoginAndSignUpButton(
                  isLogin: widget.isLogin,
                  signUpAndLogin: _login,
                )
              : const CircularProgressIndicator(
                  color: Colors.teal,
                ),
        ],
      ),
    );
  }
}
