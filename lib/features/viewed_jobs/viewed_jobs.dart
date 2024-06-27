import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/common_widgets/request_login_box.dart';
import 'package:phtv_app/features/job_card.dart';

class ViewedJobs extends StatefulWidget {
  const ViewedJobs({super.key});

  @override
  State<ViewedJobs> createState() => _ViewedJobsState();
}

class _ViewedJobsState extends State<ViewedJobs> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loginState();
  }

  loginState() async {
    if (await storage.read(key: "user") != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Your viewed jobs',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                    ),),
                    const Spacer(),
                    Text(
                      isLoggedIn == true ? 'View more' : '',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: isLoggedIn == true ? 220 : 110,
                  child: isLoggedIn == true ? ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                                width: 340,
                                margin: const EdgeInsets.only(right: 14),
                                child: const JobCard(jobInfo: 1),
                              ),
                      ) : const RequestLoginBox()
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}