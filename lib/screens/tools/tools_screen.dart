import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/modals/login_request.dart';
import 'package:phtv_app/screens/my_cv/my_cv_screen.dart';
import 'package:phtv_app/screens/tools/my_follow_company_screen.dart';
import 'package:phtv_app/screens/tools/salary_converter_screen.dart';

var storage = const FlutterSecureStorage();

class ToolsScreen extends StatelessWidget{
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ]
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () async {
                var userToken = await storage.read(key: "token");
                if (userToken == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return const LoginRequestModal();
                      });
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const MyCVScreen()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/mycvicon.png',
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'My CV',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(EneftyIcons.arrow_right_3_outline,size: 22,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ]
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () async {
                var userToken = await storage.read(key: "token");
                if (userToken == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return const LoginRequestModal();
                      });
                }else{
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const MyFollowCompanyScreen()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/mycompany.png',
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'My Following Companies',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(EneftyIcons.arrow_right_3_outline,size: 22,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 0,
                    blurRadius: 10,
                  ),
                ]
            ),
            margin: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const SalaryConverterScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/salaryconvert.png',
                            width: 60.0,
                            height: 60.0,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Salary Converter',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          const Icon(EneftyIcons.arrow_right_3_outline,size: 22,)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}