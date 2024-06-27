import 'package:flutter/material.dart';
import 'package:phtv_app/features/login_form.dart';

class LoginRequestModal extends StatelessWidget {
  const LoginRequestModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
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
                fontWeight: FontWeight.bold,
                fontSize: 16),
            text: "Welcome to PHTV PRO"),
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
