import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/common_widgets/body_text.dart';
import 'package:phtv_app/common_widgets/bullet_list.dart';
import 'package:phtv_app/common_widgets/header_text.dart';
import 'package:phtv_app/features/recommend_jobs/recommend_jobs.dart';

class JobsDetailScreen extends StatelessWidget {
  const JobsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Job Details',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(EneftyIcons.send_2_outline), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomAppBar(
              color: Colors.white,
              elevation: 0,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: (){},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      side: MaterialStateProperty.all(const BorderSide(color: Colors.red))
                    ), child: const Row(
                      children: [
                        Text('SAVE'),
                        SizedBox(width: 12),
                        Icon(FluentIcons.bookmark_16_regular, size: 18,)
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ), child: const Text('EASY APPLY'),
                    ),
                  )
                ],
              ),
            )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network('https://i.pravatar.cc/200',
                    height: 200, width: double.infinity, fit: BoxFit.cover),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 110, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'lập trình viên'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Mỹ Đức Hospital'.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 8, right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: const Text(
                                      'Hello World!',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8, right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: const Text(
                                      'Hello World!',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(EneftyIcons.clock_2_outline, size: 18),
                                  SizedBox(width: 4),
                                  Text('1 week ago'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black87.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://i.pravatar.cc/160',
                          height: 70.0,
                          width: 70.0,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderText('Information'),
                  BodyText('Program Development, unit test, bug fix based on the design documents from Korea Headquarter '
                      '(Korea H.Q: System design and Operation, Vietnam Development Center: Development & bug fix, '
                      'Design implementation step by step).'),

                  HeaderText('Job Description'),
                  BulletList(const [
                    'Team Leader as Project Management, Issue control, team members supporting with more than 5 projects experience communicating with Korea Project Manager.'
                    'Comply with standard coding policy of the company',
                    'Work closely with Team Leader to ensure the project quality',
                    'Assist Team Leader in reviewing work result of low-level members',
                    'Participate in training and knowledge sharing activities',
                    'Follow the project and organization processes, policies and regulations',
                    'Ensure the assigned tasks to be performed on-time and with high quality',
                    'Training New members for the Development Architecture, Standard Rules, Policy, etc.'
                  ]),

                  HeaderText('Your Role & Responsibilities'),
                  BulletList(const [
                    "At least Bachelor's or Engineer's Degree in Information Technology, Computer Science, or related fields",
                    "Experience in Java and related technologies (JavaScript, Spring5, Spring Boot, J2EE, JSP, MSA, React, etc.)",
                    "At least 4+ years working experience as a Full-stack developer",
                    "English speaking priority"
                  ]),

                  HeaderText('Your Skills & Qualifications'),
                  BulletList(const [
                    "Experience working with Cloud based technologies such as AWS, Azure, Google Cloud Platform is highly preferred.",
                    "Additional Experience in Python, Angular, MSA, C#, .net, etc.",
                    "Experience working with the following DB : Oracle, MySQL, PostgreSQL, MongoDB, MariaDB, MS SQL Server",
                    "Experience working with ERP(HR, Procurement, Finance), MES(Manufacturing Execution System for Smart Factory), SCM(Marketing)",
                    "Intention to improve the ability & try hard with positive thinking",
                    "Having good communication and problem-solving skill.",
                    "Good skill in Korean",
                  ]),

                  HeaderText('Benefits For You'),
                  BulletList(const [
                    "Salary range: 1.000 USD – 2.000 USD (depending on ability and experience)",
                    "Professional, dynamic, friendly, and English working environment.",
                    "Compulsory Insurance according to labor law",
                    "Accident Insurance",
                    "13th salary.",
                  ]),

                  HeaderText('Recommend For You'),
                  const RecommendJobs()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
