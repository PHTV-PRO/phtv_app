import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/request_login_box.dart';
import 'package:phtv_app/features/job_card.dart';

class HotJobs extends StatefulWidget {
  const HotJobs({super.key});

  @override
  State<HotJobs> createState() => _HotJobsState();
}

class _HotJobsState extends State<HotJobs> {
  var jobList = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  getJobs() async {
    var userToken = await storage.read(key: 'token');
    var data = await CandidateJobApi.getSavedJobs.sendRequest(token: userToken);
    jobList = data.map((e) => e).toList();
    if (userToken != null && data != null) {
      setState(() {
        isLoggedIn = true;
        isLoading = false;
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
                    const Text('Hot jobs',
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
                isLoggedIn ? isLoading ? const CircularProgressIndicator() : (
                    jobList.isEmpty ? Container(height: 110, alignment: Alignment.center, child: const Text('You still not save any jobs')) : SizedBox(
                      height: 240,
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: jobList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                              width: 340,
                              margin: const EdgeInsets.only(right: 14),
                              child: JobCard(jobInfo: jobList[index]),
                            ),
                      ),
                    )
                ) : const RequestLoginBox(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
