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
  String companyTitle = '';
  String about = '';
  String linkweb = '';
  String location = '';
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    companyTitle = companyDetail['name'] ?? '';
    about = companyDetail['introduction'] ?? '';
    linkweb = companyDetail['link_website'] ?? '';
    location = companyDetail['locations'][0]['name'] ?? '';
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
      body: SingleChildScrollView(
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
                      Image.network('https://i.pravatar.cc/200',
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
                            const Text(
                              'Feeling Good with Home Credit',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
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
                                  margin:
                                      const EdgeInsets.only(top: 8, right: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
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
                                  Text('GET NOTIFICATION', style: TextStyle(color: Colors.red[300]),),
                                  const SizedBox(width: 4),
                                  Icon(FluentIcons.alert_20_regular, color: Colors.red[300],)
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
                          ),
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
                  Row(children: [
                    const Icon(EneftyIcons.link_outline, size: 18),
                    const SizedBox(width: 4),
                    Text(linkweb),
                    const SizedBox(width: 4),
                    const Icon(EneftyIcons.export_outline, size: 16),
                  ],),
                  Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    const Icon(EneftyIcons.location_outline, size: 18),
                    const SizedBox(width: 4),
                    Flexible(child: Text(location, softWrap: true,)),
                  ],)
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
                              myTab('About', 0),
                              myTab('Opening', 2),
                            ],
                          ),
                        ),
                        Center(
                          child: [
                            aboutTab(about),
                            openingTab()
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
                  HeaderText('Image'),
                  Wrap(
                    runSpacing: 8,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://i.pravatar.cc/160',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://i.pravatar.cc/160',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://i.pravatar.cc/160',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://i.pravatar.cc/160',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://i.pravatar.cc/160',
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

Container aboutTab(String about) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    child: BodyText(about)
  );
}

Container openingTab() {
  return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Column(
        children: [
          JobCard(jobInfo: 1),
          JobCard(jobInfo: 1)
        ],
      )
  );
}
