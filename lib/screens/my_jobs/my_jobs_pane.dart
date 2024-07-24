import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/features/job_card.dart';

class MyJobsPane extends StatefulWidget {
  const MyJobsPane({super.key, required this.jobType});
  final int jobType;

  @override
  State<MyJobsPane> createState() => _MyJobsPaneState();
}

class _MyJobsPaneState extends State<MyJobsPane>{
  bool isLoading = true;
  List jobList = [];


  @override
  void initState() {
    super.initState();
    getJobs();
  }

  getJobs() async {
    String? userToken = await storage.read(key: 'token');
    if(userToken != null && userToken != '') {
      List data = [];
      if(widget.jobType == 0){
        data = await CandidateJobApi.getSavedJobs.sendRequest(token: userToken);
      }else if(widget.jobType == 1){
        data = await CandidateJobApi.getSavedJobs.sendRequest(token: userToken);
      }else if(widget.jobType == 2){
        data = await CandidateJobApi.getViewedJobs.sendRequest(token: userToken);
      }
      if(data.isNotEmpty){
        jobList = data.map((e) => e).toList();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }


  Container noResult() {
    return Container(
      alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: const Text('Sorry there is no job, please add some', style: TextStyle(
          color: Colors.black45
        ), textAlign: TextAlign.center,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: jobList.isEmpty ? noResult() : SingleChildScrollView(
        child: Column(
          children: [
            for(var item in jobList) JobCard(jobInfo: item),
          ],
        ),
      )
    );
  }
}
