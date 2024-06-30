import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/body_text.dart';
import 'package:phtv_app/common_widgets/bullet_list.dart';
import 'package:phtv_app/common_widgets/header_text.dart';
import 'package:phtv_app/utils/date_utils.dart';

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
  bool isLoading = true;
  String jobTitle = '';
  String companyName = '';
  String jobDescription = '';
  String jobReponsibility = '';
  String jobRequired = '';
  String jobBenefit = '';
  String createdDate = '';


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    getJobDetail(widget.jobId);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  getJobDetail(int id) async {
    jobDetail = await JobApi.getJobDetail.sendRequest(urlParam: '/${id.toString()}');
    setState(() {
      jobTitle = jobDetail['title'] ?? '';
      companyName = jobDetail['company']['name'] ?? '';
      jobDescription = jobDetail['description'] ?? '';
      jobReponsibility = jobDetail['reponsibility'] ?? '';
      jobRequired = jobDetail['skill_required'] ?? '';
      jobBenefit = jobDetail['benefit'] ?? '';
      createdDate = AppDateUtils.daysBetween(jobDetail['start_date']) ?? '';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Job Details',
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    icon: const Icon(EneftyIcons.send_2_outline),
                    onPressed: () {}),
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
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              side: MaterialStateProperty.all(
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
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                            child: const Text('EASY APPLY'),
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
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
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
                            jobDetailsTab(jobDescription, jobReponsibility, jobRequired, jobBenefit),
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
          BodyText(
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

          HeaderText('Recommend For You'),
          // const RecommendJobs()
        ],
      ));
}
