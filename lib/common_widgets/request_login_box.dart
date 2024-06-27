import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/modals/login_request.dart';

class RequestLoginBox extends StatelessWidget {
  const RequestLoginBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: 'Please ', style: TextStyle(color: Colors.black54)),
          TextSpan(
            text: 'login',
            style: const TextStyle(color: Colors.red),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return const LoginRequestModal();
                    });
              },
          ),
          const TextSpan(
              text: ' to views your dream jobs',
              style: TextStyle(color: Colors.black54)),
        ],
      ),
    ));
  }
}
