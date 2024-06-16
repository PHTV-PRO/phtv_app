import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  onGoBack(dynamic value) {
    // loginState();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 242, 243),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('My Account'),
          surfaceTintColor: Colors.white,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  child: TextButton(
                      child: const Text('Sign up'), onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const LoginScreen(
                          tabIndex: 0,
                        )));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        foregroundColor: Colors.white
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                            builder: (ctx) => const LoginScreen(
                              tabIndex: 1,
                            )))
                            .then(onGoBack);
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                ),
              ],
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 60, left: 10, right: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 70),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'ANONYMOUS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15),
                  child: CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/100'),
                        radius: 44,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            myAction(),
          ],
        ),
      ),
    );
  }

  Widget myAction() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'INFORMATION',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.setting_2_outline),
                          label: const Text('Privacy Policy'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon:
                              const Icon(EneftyIcons.message_question_outline),
                          label: const Text('Terms and Conditions'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.tick_circle_outline),
                          label: const Text('Review app'),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.info_circle_outline),
                          label: const Text('About us'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONTACT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: Image.asset('assets/images/zalo.png',
                              height: 22, color: Colors.black54),
                          label: Text('Zalo'),
                          onPressed: () async {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: Image.asset('assets/images/facebook_icon.png',
                              height: 22, color: Colors.black54,),
                          label: const Text('PHTV Fanpage'),
                          onPressed: () async {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.call_outline),
                          label: Text('Hotline'),
                          onPressed: () async {},
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(Icons.mail_outline),
                          label: Text('Email'),
                          onPressed: () async {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          onPressed: () {},
          child: const Text('Sign out'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
