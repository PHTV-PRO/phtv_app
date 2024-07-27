import 'package:flutter/material.dart';
import 'package:phtv_app/features/login_form.dart';

class LoginRequestModal extends StatelessWidget {
  const LoginRequestModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.only(
        top: 10.0,
      ),
      title: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18),
            text: "Please login to continue"),
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
