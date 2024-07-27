import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/body_text.dart';
import 'package:phtv_app/common_widgets/bullet_list.dart';
import 'package:phtv_app/common_widgets/header_text.dart';
import 'package:phtv_app/utils/date_utils.dart';

import '../pdf_view_screen.dart';

var storage = const FlutterSecureStorage();

class JobsDetailScreen extends StatefulWidget {
  const JobsDetailScreen({super.key, required this.jobId});

  final int jobId;

  @override
  State<JobsDetailScreen> createState() => _JobsDetailScreenState();
}

class _JobsDetailScreenState extends State<JobsDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var jobDetail = {};
  var cvList = [];
  bool isLoading = true;
  int jobId = 0;
  String jobTitle = '';
  String companyName = '';
  String jobDescription = '';
  String jobResponsibility = '';
  String jobRequired = '';
  String jobBenefit = '';
  String createdDate = '';

  int selectCvId = 0;
  bool isApplied = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    getJobDetail(widget.jobId);
    getAllCV(10,1);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  getJobDetail(int id) async {
    String? userToken = await storage.read(key: 'token');
    if(userToken == null || userToken == ''){
      jobDetail = await JobApi.getJobDetail.sendRequest(urlParam: '/${id.toString()}');
    }else{
      jobDetail = await JobApi.getJobDetailAuth.sendRequest(token: userToken, urlParam: '/${id.toString()}');
    }

    setState(() {
      jobId = jobDetail['id'] ?? 0;
      jobTitle = jobDetail['title'] ?? '';
      companyName = jobDetail['company']['name'] ?? '';
      jobDescription = jobDetail['description'] ?? '';
      jobResponsibility = jobDetail['reponsibility'] ?? '';
      jobRequired = jobDetail['skill_required'] ?? '';
      jobBenefit = jobDetail['benefit'] ?? '';
      createdDate = AppDateUtils.daysBetween(jobDetail['start_date']) ?? '';
      isApplied = jobDetail['job_is_apply'] ?? false;
      isLoading = false;
    });
  }

  getAllCV(int size, int page) async {
    String? userToken = await storage.read(key: 'token');
    if (userToken != null && userToken != '') {
      var data = await CandidateCVApi.getAllCVs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
      if (data != null) {
        cvList = data.map((e) => e).toList();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  applyJob() async {
    var userToken = await storage.read(key: 'token');
    Map<String, String> jsonBody = {
      'job_id': jobId.toString(),
      'cv_id' : selectCvId.toString(),
      'note' : ''
    };

    var data = await CandidateJobApi.applyJob.sendRequest(body: jsonBody, token: userToken);
    if (data != null){
      setState(() {
        isApplied = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Job Details', style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
              ),
              backgroundColor: Colors.red,
              leading: const BackButton(
                  color: Colors.white
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: const Icon(EneftyIcons.send_2_outline, color: Colors.white,),
                    onPressed: () {}),
              ],
            ),
            backgroundColor: Colors.white,
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
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              side: WidgetStateProperty.all(
                                  const BorderSide(color: Colors.red))),
                          child: const Row(
                            children: [
                              Text('SAVE'),
                              SizedBox(width: 12),
                              Icon(
                                FluentIcons.bookmark_16_regular,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, setState) => Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height * 0.85,
                                        color: Colors.white,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              top: 0,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                child: const Text('Please choose one CV to apply',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                                                                              ),),)
                                            ),
                                            Positioned(
                                                child: cvList.isEmpty
                                                ? Container(
                                                height: 110,
                                                alignment: Alignment.center,
                                                child: const Text('You still not create any CV'))
                                                : Container(
                                                  margin: const EdgeInsets.only(top: 50),
                                                // padding: const EdgeInsets.all(8),
                                                height: 550,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                  children: [
                                                    ListView.builder(
                                                      physics: const ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: cvList.length,
                                                      itemBuilder: (BuildContext context, int index) =>
                                                        RadioListTile(
                                                          title: Container(
                                                            padding: const EdgeInsets.all(15),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: cvList[index]['id'] == selectCvId ? const Color.fromARGB(255, 252, 203, 203): Colors.white,
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors.grey.withOpacity(0.4),
                                                                    spreadRadius: 0,
                                                                    blurRadius: 6,
                                                                  ),
                                                                ]
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                const Icon(EneftyIcons.document_favorite_outline, color: Colors.red, size: 35),
                                                                const SizedBox(width: 20),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(cvList[index]['name'].toString().toUpperCase(), style: const TextStyle(
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.red
                                                                      ),),
                                                                      Text('Upload date: ${cvList[index]['create_at'].toString().substring(0,10)}', style: const TextStyle(fontSize: 12),),
                                                                      const SizedBox(height: 8),
                                                                      SizedBox(
                                                                          height:25,
                                                                          child: ElevatedButton.icon(onPressed: (){
                                                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PDFViewScreen(path: cvList[index]['file_name'])));
                                                                          }, icon: const Icon(EneftyIcons.eye_outline, size: 18), label: const Text('Preview')))
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          value: cvList[index]['id'],
                                                          groupValue: selectCvId,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectCvId = value;
                                                            });
                                                          },
                                                        ),
                                                    ),
                                                  ],),
                                                ),
                                            )),
                                            Positioned.fill(
                                              bottom: 10,
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          child: ElevatedButton(
                                                            onPressed: (){},
                                                            style: ButtonStyle(
                                                              backgroundColor: WidgetStateProperty.all(Colors.white),
                                                              shape: WidgetStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(6),
                                                                ),
                                                              ),
                                                                side: WidgetStateProperty.all(
                                                                    const BorderSide(color: Colors.red))
                                                            ),
                                                            child: const Text('Upload CV'),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                          child: SizedBox(
                                                            child: ElevatedButton(
                                                            onPressed: applyJob,
                                                              style: ButtonStyle(
                                                                backgroundColor: WidgetStateProperty.all(Colors.red),
                                                                foregroundColor: WidgetStateProperty.all(Colors.white),
                                                                shape: WidgetStateProperty.all(
                                                                  RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(6),
                                                                  ),
                                                                ),
                                                              ),
                                                            child: const Text('Apply This Job'),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ))
                                          ],
                                        )
                                      ),
                                    );
                                  });
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.red),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            child: Text(isApplied == true ? 'You already applied' : 'EASY APPLY'),
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network('https://i.pravatar.cc/200',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 110, left: 10, right: 10),
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
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      jobTitle.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      companyName.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 8, right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                          margin: const EdgeInsets.only(
                                              top: 8, right: 8),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(EneftyIcons.clock_2_outline,
                                            size: 18),
                                        const SizedBox(width: 4),
                                        Text(createdDate),
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
                  const SizedBox(height: 20),
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          height: 38,
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              // Creates border
                              color: Colors.red,
                            ),
                            overlayColor: WidgetStateProperty.all(Colors.transparent),
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            labelColor: Colors.white,
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            unselectedLabelStyle:
                                const TextStyle(fontWeight: FontWeight.normal),
                            tabAlignment: TabAlignment.center,
                            dividerColor: Colors.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            controller: _tabController,
                            tabs: [
                              myTab('Job Details', 0),
                              myTab('Company', 0),
                            ],
                          ),
                        ),
                        Center(
                          child: [
                            jobDetailsTab(jobDescription, jobResponsibility, jobRequired, jobBenefit),
                            companyTab()
                          ][_tabController.index],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }



  Container companyTab() {
    return Container(
        margin: const EdgeInsets.only(top: 12),
        child: Column(
          children: [Text('ahuhu')],
        ));
  }
}

Container myTab(String text, int count) {
  return Container(
    height: 28,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Tab(
        child: Row(
      children: [
        Text(
          text,
        ),
        if (count > 0) const SizedBox(width: 4),
        if (count > 0)
          Badge(
            label: Text(count > 0 ? count.toString() : ''),
            backgroundColor: Colors.red.shade300,
          )
      ],
    )),
  );
}

Container jobDetailsTab(String jobDes, String jobRes, String jobReq, String jobBen) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const HeaderText('Information'),
          const BodyText(
              'Program Development, unit test, bug fix based on the design documents from Korea Headquarter '
                  '(Korea H.Q: System design and Operation, Vietnam Development Center: Development & bug fix, '
                  'Design implementation step by step).'),

          if(jobDes != '') const HeaderText('Job Description'),
          if(jobDes != '') BulletList(jobDes.split('\n')),

          if(jobRes != '') const HeaderText('Your Role & Responsibilities'),
          if(jobRes != '') BulletList(jobRes.split('\n')),

          if(jobReq != '') const HeaderText('Your Skills & Qualifications'),
          if(jobReq != '') BulletList(jobReq.split('\n')),

          if(jobBen != '') const HeaderText('Benefits For You'),
          if(jobBen != '') BulletList(jobBen.split('\n')),

          const HeaderText('Recommend For You'),
          // const RecommendJobs()
        ],
      ));
}
