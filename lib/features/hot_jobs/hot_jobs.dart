import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/request_login_box.dart';
import 'package:phtv_app/features/job_card.dart';
import '../../screens/viewmore_screen.dart';

var storage = const FlutterSecureStorage();

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
        var data = await CandidateJobApi.getRecommendJobs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
        if(data != null){
          jobList = data.map((e) => e).toList();
          setState(() {
            isLoading = false;
            isLoggedIn = true;
          });
        }
      }else{
        await storage.deleteAll();
      }
    }else{
      await storage.deleteAll();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    const Text('Jobs fit you',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),
                    const Spacer(),
                    isLoggedIn == true ? SizedBox(
                      height: 35,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ViewmoreScreen(dataType: 'Jobs fit you',)));
                        },
                        child: const Text('View more',style: TextStyle(
                            fontSize: 14, color: Colors.blueAccent)),
                      ),
                    ) : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 10),
                isLoggedIn ? isLoading ? const Center(child: CircularProgressIndicator()) : (
                    jobList.isEmpty ? Container(height: 110, alignment: Alignment.center, child: const Text('Please travel around our app first')) : SizedBox(
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
                              child: JobCard(jobId: jobList[index]['id'], notifyParent: (){}),
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
