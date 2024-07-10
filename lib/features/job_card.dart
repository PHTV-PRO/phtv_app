
import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/screens/jobs/jobs_detail_screen.dart';
import 'package:phtv_app/utils/date_utils.dart';

var storage = const FlutterSecureStorage();

class JobCard extends StatelessWidget{
  const JobCard({
    super.key,
    this.jobInfo,
  });

  final dynamic jobInfo;

  @override
  Widget build(BuildContext context) {
    int jobId = jobInfo['id'] ?? 0;
    String companyName = jobInfo['company']['name'] ?? 'company name';
    String jobTitle = jobInfo['title'] ?? 'job title';
    String logoImage = jobInfo['logo_image'] ?? 'https://i.pravatar.cc/40';
    String province = jobInfo['location']['cityProvince']['name'] ?? 'Ho Chi Minh';;
    String salary = (jobInfo['salary_min'] ?? 'Negotiable') + (jobInfo['salary_max'] != null ? ' - ' + jobInfo['salary_max']  : '');
    String createdDate = AppDateUtils.daysBetween(jobInfo['start_date'] ?? DateFormat("dd-MM-yy").format(DateTime.now()));

    return Container(
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
          Map<String, String> jsonBody = {
            'job_id': jobId.toString(),
          };
          await CandidateJobApi.viewJob.sendRequest(body: jsonBody, token: userToken);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => JobsDetailScreen(jobId: jobId)));
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
                        var userToken = await storage.read(key: 'token');
                        Map<String, String> jsonBody2 = {
                          'job_id': jobId.toString(),
                        };
                        await CandidateJobApi.saveJob.sendRequest(body: jsonBody2, token: userToken);
                      },
                      icon: const Icon(
                        FluentIcons.bookmark_20_regular,
                        color: Colors.grey,
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
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}