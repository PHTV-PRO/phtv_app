import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  elevation: 0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
                  child: SizedBox(
                    width: double.infinity,
                    // height: 240,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          SizedBox(
                            width: double.infinity,
                            child: const Text(
                              'CHƯA ĐĂNG NHẬP',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 35,
                                child: TextButton(
                                    child: const Text('Đăng ký'),
                                    onPressed: () {}),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: SizedBox(
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                                    onPressed: () {},
                                    child: const Text('Đăng nhập'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
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
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage:
                            const NetworkImage('https://i.pravatar.cc/100'),
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
                'CÀI ĐẶT',
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
                          ),
                          icon: const Icon(EneftyIcons.setting_2_outline),
                          label: const Text('Cài đặt ứng dụng'),
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
                          ),
                          icon:
                              const Icon(EneftyIcons.message_question_outline),
                          label: const Text('Hướng dẫn sử dụng'),
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
                          ),
                          icon: const Icon(EneftyIcons.tick_circle_outline),
                          label: const Text('Bình chọn'),
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
                          ),
                          icon: const Icon(EneftyIcons.info_circle_outline),
                          label: const Text('Về chúng tôi'),
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
                'LIÊN HỆ',
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
                          ),
                          icon: Image.asset('assets/images/zalo.png',
                              height: 22,
                              color: Colors.red),
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
                          ),
                          icon: Image.asset('assets/images/facebook_icon.png',
                              height: 22,
                              color: Colors.red),
                          label: const Text('FB Điểm Đảo Chiều'),
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
          child: const Text('Đăng xuất'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
