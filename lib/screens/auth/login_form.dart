import 'dart:io';
import 'dart:convert' show json, utf8;
import 'package:http/http.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKeyLogin = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLogin,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Email",
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !value.contains('@') ||
                  !value.contains('.')) {
                return 'Invalid email';
              }
              return null;
            },
            onSaved: (value) {
              _enteredEmail = value!;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Password (*)",
              fillColor: Colors.white,
              suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    size: 18,
                    color: Colors.grey[800],
                  ),
                  onPressed: _toggle),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password cannot be empty';
              }
              return null;
            },
            onSaved: (value) {
              _enteredPassword = value!;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('Forgot password'),
                onPressed: () {},
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _submitLogin,
            child: const Text(
              'Sign in',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'or',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Image.asset('assets/images/facebook.png'),
                  onPressed: (){}
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Image.asset('assets/images/google.png'),
                onPressed: (){}
              ),
            ],
          ),
        ],
      ),
    );
  }

  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submitLogin() async {
    final isValid = _formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeyLogin.currentState!.save();
    const baseUrl = 'https://api-prod.diemdaochieu.com/auth/signin';
    const storage = FlutterSecureStorage();
    Map<String, String> jsonBody = {
      'username': _enteredEmail,
      'password': _enteredPassword
    };

    try {
      Map<String, String> requestHeaders = {
        'platform': Platform.operatingSystem.toUpperCase(),
        'Content-Type': 'application/json',
      };

      Response response = await post(Uri.parse(baseUrl),
          headers: requestHeaders, body: json.encode(jsonBody));
      final message = json.decode(utf8.decode(response.bodyBytes))['message'];

      if (response.statusCode == 200) {
        final result = json.decode(utf8.decode(response.bodyBytes))['data'];
        String accessToken = result['accessToken'];
        await storage.write(key: 'jwt', value: accessToken);
        await storage.write(key: 'user', value: json.encode(result['user']));
      } else {
        showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                elevation: 0,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      EneftyIcons.info_circle_bold,
                      size: 50,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 10),
                    Text(message),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Thử lại'),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      throw e.toString();
    }
  }

  void _subscribeFirebase(String userToken, String fcmToken) async {
    const baseUrl = 'https://api-prod.diemdaochieu.com/user/settings/update';
    const storage = FlutterSecureStorage();
    Map<String, dynamic> jsonBody = {
      'fcmToken': fcmToken,
      'receiveNotification': true
    };
    try {
      Map<String, String> requestHeaders = {
        'x-ddc-token': userToken,
        'platform': Platform.operatingSystem.toUpperCase(),
        'Content-Type': 'application/json',
      };
      Response response = await post(Uri.parse(baseUrl),
          headers: requestHeaders, body: json.encode(jsonBody));
      if (response.statusCode == 200) {
        await storage.write(
            key: "TOKEN_NOTIFICATION", value: fcmToken.toString());
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
