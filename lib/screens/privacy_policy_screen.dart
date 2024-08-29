import 'package:flutter/material.dart';
import '../common_widgets/bullet_list.dart';
import '../common_widgets/header_text.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy',
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
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderText('Which personal data is collected from you'),
              BulletList([
                'Last name, middle name, and first name (if applicable);',
                'Residence information (including permanent address, temporary address, current address, hometown, contact address);',
                'Nationality;',
                'Email address;',
                'Any other data or information that you voluntarily provide through our platform during your use of the services;'
              ]),
              HeaderText('Purpose of Collection, Use, and Disclosure'),
              BulletList([
                'To verify your identity and manage the online account that you may have set up with us;',
                'To provide services to you, specifically related to job search opportunities and recruitment activities. We may publicly display your personal data on the PHTV PRO platform based on your decision, as well as transfer your personal data to third parties, such as potential employers who may be employers or fellow job seekers in the future;',
                'To process the orders you submit through the PHTV PRO platform (including any payments you make through the PHTV PRO platform for products, whether sold by us or any of our branches);',
                'To verify and process online financial transactions related to payments, and to establish your identity for anti-money laundering, reporting suspicious transactions, and fraud detection purposes;',
              ]),
              HeaderText('How your data is processed'),
              BulletList([
                'Your data will be stored and processed either in its entirety or in parts in Vietnam. If you access the PHTV PRO platform from a location outside of Vietnam, your usage is understood as your consent to transfer your data outside of that country/territory and send it to Vietnam. Your information and/or personal data may be transferred, stored, or processed outside of your country for one or more purposes. PHTV PRO will only transfer your personal data overseas in compliance with applicable laws and regulations regarding personal data protection.',
                'By providing your information, you agree that PHTV PRO Website, affiliated companies, subsidiaries, and members of the Navigos Group may use your information in accordance with the purposes mentioned above and applicable legal regulations.',
              ]),
              HeaderText('Your Rights and Choices'),
              BulletList([
                'If you choose not to register or provide personal information, you may not be able to use a significant portion of the PHTV PRO Platform.',
                'You also have choices regarding cookies. By changing your browser preferences, you can choose to accept all cookies, be notified when a cookie is set, or reject all cookies. If you choose to reject all cookies, you may not be able to use PHTV PRO Platform services that require registration. These services include identifying newly posted jobs since your last visit, automatic login, and the saved jobs feature. However, you can still use most features of the PHTV PRO platform even if you do not accept cookies.',
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
