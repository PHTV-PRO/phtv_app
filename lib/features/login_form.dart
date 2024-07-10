import 'dart:convert' show json, utf8;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
const storage = FlutterSecureStorage();

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKeyLogin = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';
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

  _submitLogin() async {
    final isValid = _formKeyLogin.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeyLogin.currentState!.save();
    Map<String, String> jsonBody = {
      'email': _enteredEmail,
      'password': _enteredPassword
    };
    var result = await AuthApi.login.sendRequest(body: jsonBody);
    String accessToken = result['token'];
    await storage.write(key: 'token', value: accessToken);
    await storage.write(key: 'user', value: json.encode(result['account']));
    print(accessToken);
    Navigator.pop(context, () {});
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
                  onPressed: () {}),
              const SizedBox(width: 12),
              IconButton(
                  icon: Image.asset('assets/images/google.png'),
                  onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
