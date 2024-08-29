import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/request_login_box.dart';
import 'package:phtv_app/features/job_card.dart';

import '../../screens/viewmore_screen.dart';

var storage = const FlutterSecureStorage();

class ViewedJobs extends StatefulWidget {
  const ViewedJobs({super.key});

  @override
  State<ViewedJobs> createState() => _ViewedJobsState();
}

class _ViewedJobsState extends State<ViewedJobs> {
  var jobList = [];
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getJobs(10,1);
  }

  getJobs(int size, int page) async {
    String? userToken = await storage.read(key: 'token');
    if(userToken != null && userToken != '') {
      Map<String, String> jsonBody = {
        'token': userToken
      };
      var logUser = await AuthApi.checkToken.sendRequest(body: jsonBody);
      if (logUser != null) {
        var data = await CandidateJobApi.getViewedJobs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
        if(data != null){
          jobList = data.map((e) => e).toList();
          setState(() {
            isLoggedIn = true;
            isLoading = false;
          });
        }
      }else{
        await storage.deleteAll();
      }
    }else{
      await storage.deleteAll();
    }
  }

  refresh() {
    getJobs(10,1);
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
                    isLoggedIn == true ? SizedBox(
                      height: 35,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ViewmoreScreen(dataType: 'Your viewed jobs',)));
                        },
                        child: const Text('View more',style: TextStyle(
                            fontSize: 14, color: Colors.blueAccent)),
                      ),
                    ) : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 10),
                isLoggedIn ? isLoading ? const Center(child: CircularProgressIndicator()) : (
                    jobList.isEmpty ? Container(height: 110, alignment: Alignment.center, child: const Text('You still not view any jobs')) : SizedBox(
                      height: 260,
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: jobList.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Container(
                              width: 340,
                              margin: const EdgeInsets.only(right: 14),
                              child: JobCard(jobId: jobList[index]['id'], notifyParent: refresh),
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