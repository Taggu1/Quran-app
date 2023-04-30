import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAndSignUpButton extends StatelessWidget {
  final bool isLogin;
  final VoidCallback signUpAndLogin;
  const LoginAndSignUpButton(
      {Key? key, required this.isLogin, required this.signUpAndLogin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: signUpAndLogin,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Text(isLogin ? "Login" : "SignUp"),
      ),
    );
  }
}
