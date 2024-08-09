import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/common_widgets/body_text.dart';
import 'package:phtv_app/common_widgets/header_text.dart';
import 'package:phtv_app/features/job_card.dart';

class CompaniesDetailScreen extends StatefulWidget {
  const CompaniesDetailScreen({super.key, required this.companyId});
  final int companyId;

  @override
  State<CompaniesDetailScreen> createState() => _CompaniesDetailScreenState();
}

class _CompaniesDetailScreenState extends State<CompaniesDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var companyDetail = {};
  String companyLogo = '';
  String companyBg = '';
  String companyTitle = '';
  String about = '';
  String linkweb = '';
  String location = '';
  String companySize = '';
  Set skills = {};
  Set industries = {};
  int openningJob = 0;
  List lstOpenningJob = [];
  List lstCompanyImage = [];
  bool isLoading = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    getCompanyDetail(widget.companyId);
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  getCompanyDetail(int id) async {
    companyDetail = await CompanyApi.getCompanyDetail.sendRequest(urlParam: '/${id.toString()}');
    setState(() {
      companyLogo = companyDetail['logo_image'] ?? 'https://i.pravatar.cc/160';
      companyBg = companyDetail['background_image'] ?? 'https://i.pravatar.cc/200';
      companyTitle = companyDetail['name'] ?? '';
      about = companyDetail['introduction'] ?? '';
      linkweb = companyDetail['link_website'] ?? '';
      companySize = companyDetail['size'] ?? '';
      location = companyDetail['location'] ?? '';
      openningJob = companyDetail['opening_jobs'] ?? 0;
      lstOpenningJob = companyDetail['jobs'];
      lstCompanyImage = companyDetail['list_image_mobile'];
      isLoading = false;
    });
  }

  followCompany(int id) async {
    String? userToken = await storage.read(key: 'token');
    Map<String, String> jsonBody = {
      'company_id': id.toString()
    };
    var data = await CandidateCompanyApi.followCompany.sendRequest(token: userToken, body: jsonBody);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    if(companyDetail['skills'] != null){
      for (var i in companyDetail['skills']) {
        skills.add(i['name']);
        industries.add(i['industry']['name']);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Company Details',
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(EneftyIcons.send_2_outline), onPressed: () {}),
          ],
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0),
      backgroundColor: Colors.white,
      body: isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                  child: Column(
                    children: [
                      Image.network(companyBg,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 80, bottom: 10, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text(
                              companyTitle.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                for(int i = 0; i < skills.length; i++)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      skills.elementAtOrNull(i),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red.shade200),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      followCompany(companyDetail['id']);
                                    },
                                      child: Text('FOLLOW THIS COMPANY', style: TextStyle(color: Colors.red[300]),)),
                                  const SizedBox(width: 4),
                                  Icon(FluentIcons.mail_alert_24_regular, color: Colors.red[300],)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 90.0,
                        height: 90.0,
                        margin: const EdgeInsets.only(top: 160, bottom: 30),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
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
                          child: Image.network(companyLogo),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText('Information'),
                  Row(
                    children: [
                      companyDetailRow(EneftyIcons.link_outline, linkweb),
                      const SizedBox(width: 8),
                      const Icon(EneftyIcons.export_outline, size: 16),
                    ],
                  ),
                  companyDetailRow(EneftyIcons.location_outline, location),
                  companyDetailRow(EneftyIcons.profile_2user_outline, companySize),
                  companyDetailRow(EneftyIcons.tag_outline, industries.join(", ")),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              myTab('About', 0),
                              myTab('Opening', openningJob),
                            ],
                          ),
                        ),
                        Center(
                          child: [
                            aboutTab(about),
                            openingTab(lstOpenningJob)
                          ][_tabController.index],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              margin: const EdgeInsets.only(bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 20,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderText('Image'),
                  Wrap(
                    runSpacing: 8,
                    children: [
                      for (var item in lstCompanyImage)  Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

Container companyDetailRow(IconData icon, String detail) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Icon(icon, size: 18),
        const SizedBox(width: 6),
        Flexible(child: Text(detail, softWrap: true, style: TextStyle(
          color: Colors.black.withOpacity(0.6),
        ),)),
      ],
    ),
  );
}

Container aboutTab(String about) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: BodyText(about)
  );
}

Container openingTab(List openingJobs) {
  return Container(
      margin: const EdgeInsets.only(top: 12),
      child: openingJobs.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 28.0),
              child: Text('No opening job'),
            )
          :  Column(
              children: [
                for(int i = 0; i < openingJobs.length; i++) JobCard(jobId: openingJobs[i]['id'], notifyParent: (){}),
              ],
            )
  );
}
