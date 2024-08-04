import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/features/job_card.dart';

class LatestJobs extends StatefulWidget {
  const LatestJobs({super.key});

  @override
  State<LatestJobs> createState() => _LatestJobsState();
}

class _LatestJobsState extends State<LatestJobs> {
  var jobList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getJobs();
  }

  getJobs() async {
    var data = await JobApi.getLatestJobs.sendRequest();
    jobList = data.map((e) => e).toList();
    if(data != null){
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Latest jobs',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'View more',
                            style: TextStyle(
                                fontSize: 14, color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: jobList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              JobCard(jobId: jobList[index]['id'], notifyParent: (){},)
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
