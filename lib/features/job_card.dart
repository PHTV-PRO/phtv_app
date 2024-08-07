
import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/modals/login_request.dart';
import 'package:phtv_app/screens/jobs/jobs_detail_screen.dart';
import 'package:phtv_app/utils/date_utils.dart';

var storage = const FlutterSecureStorage();

class JobCard extends StatefulWidget{

  const JobCard({
    super.key,
    this.jobId,
    required this.notifyParent
  });
  final Function notifyParent;
  final dynamic jobId;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  var jobInfo = {};
  int jobId = 0;
  String companyName = '';
  String jobTitle = '';
  bool isSaved = false;
  String logoImage = 'https://i.pravatar.cc/40';
  String province = '';
  String salary = '';
  String createdDate = '';
  List jobSkills = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getJobs(widget.jobId);
  }

  getJobs(int id) async {
    String? userToken = await storage.read(key: 'token');
    if(userToken != null && userToken != '') {
      jobInfo = await JobApi.getJobDetailAuth.sendRequest(token: userToken, urlParam: '/${id.toString()}');
    }else{
      jobInfo = await JobApi.getJobDetail.sendRequest(urlParam: '/${id.toString()}');

    }
    if(jobInfo.isNotEmpty){
      setState(() {
        jobId = jobInfo['id'] ?? 0;
        companyName = jobInfo['company']['name'] ?? 'company name';
        jobTitle = jobInfo['title'] ?? 'job title';
        isSaved = jobInfo['job_is_save'] ?? false;
        logoImage = jobInfo['logo_image'] ?? 'https://i.pravatar.cc/40';
        province = jobInfo['company']['city_provence']['name'] ?? 'Ho Chi Minh';
        salary = (jobInfo['salary_min'] ?? 'Negotiable') + (jobInfo['salary_max'] != null ? ' - ' + jobInfo['salary_max']  : '');
        createdDate = AppDateUtils.daysBetween(jobInfo['start_date'] ?? DateFormat("dd-MM-yy").format(DateTime.now()));
        jobSkills = jobInfo['skills'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Set skills = {};
    if(jobSkills.isNotEmpty){
      for (var i in jobSkills) {
        if(skills.length > 3) break;
        skills.add(i['name']);
      }
    }

    return isLoading ? const CircularProgressIndicator() :  Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide( //                   <--- left side
            color: Colors.redAccent,
            width: 6.0,
          ),
          top: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
          right: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
          bottom: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ]
      ),
      child: InkWell(
        onTap: () async {
          var userToken = await storage.read(key: 'token');
          if(userToken != null && userToken != ''){
            Map<String, String> jsonBody = {
              'job_id': jobId.toString(),
            };
            await CandidateJobApi.viewJob.sendRequest(body: jsonBody, token: userToken);
            widget.notifyParent();
          }
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => JobsDetailScreen(jobId: jobId)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipOval(// Image border
                      child: SizedBox.fromSize(
                        size: const Size(40, 40),
                        child: Image.network(
                          logoImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        companyName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var userToken = await storage.read(key: "token");
                        if (userToken == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return const LoginRequestModal();
                              });
                        }else{
                          Map<String, String> jsonBody2 = {
                            'job_id': jobId.toString(),
                          };
                          await CandidateJobApi.saveJob.sendRequest(body: jsonBody2, token: userToken);
                          getJobs(jobId);
                        }
                      },
                      icon: Icon(isSaved == true ?
                      FluentIcons.bookmark_20_filled : FluentIcons.bookmark_20_regular,
                        color: isSaved == true ? Colors.red : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  jobTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                    color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(EneftyIcons.location_outline, size: 18),
                    const SizedBox(width: 4),
                    Text(province),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(EneftyIcons.dollar_circle_outline, size: 18),
                    const SizedBox(width: 4),
                    Text(salary),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(EneftyIcons.clock_2_outline, size: 18),
                    const SizedBox(width: 4),
                    Text(createdDate),
                  ],
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for(int i = 0; i < skills.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: Text(
                          skills.elementAtOrNull(i),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 12
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}