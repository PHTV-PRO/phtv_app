import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import '../common_widgets/bullet_list.dart';
import '../common_widgets/header_text.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.red,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 40),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(EneftyIcons.briefcase_bold, size: 32, color: Colors.red,),
                    SizedBox(width: 6),
                    Text('PHTV PRO', style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24
                    ),),
                  ],
                ),
              ),
              bodyText('Established in 2006, PHTV PRO is one of Vietnam’s most successful recruitment agencies, supplying high quality personnel to hundreds of companies. Currently more than 300 companies use the Executive Search service and over 5000 companies are always committed to use our web recruiting services.'),
              bodyText('To fully ascertain and understand client’s requirements and match them up with the most suitable candidate. PHTV PRO Vietnam is always committed to finding the best candidate – of benefit both to the company and the employee making the career choice.'),
              const HeaderText('Our Mission'),
              const BulletList([
                'Connect Developers with best vacancies from verified companies in all industries',
                'Supply companies with best sources of developers & build long-term employer branding',
                'Accelerate Vietnamese human resources in both quality & quantity via communities, events/ activities & education',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Text bodyText(String text){
    return Text(
      text,
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        height: 1.55,
      ),
    );
  }
}
