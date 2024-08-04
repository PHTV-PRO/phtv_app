import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/screens/my_jobs/my_jobs_pane.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final _formSearchMain = GlobalKey<FormState>();
  int indexTab = 0;
  List jobsData = [];
  List companyData = [];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      indexTab = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  search(String value) async {
    final isValid = _formSearchMain.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formSearchMain.currentState!.save();
    var data = await SearchApi.search.sendRequest(urlParam: '/$value');
    setState(() {
      jobsData = data['jobs'];
      companyData = data['companies'];
    });
  }

  Container myTab(String text) {
    return
        Container(
          height: 30,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: Tab(child: Row(
            children: [
              Text(text),
            ],
          )),
        );
  }

  Container noResult() {
    return Container(
      alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: const Text('Sorry we did not found any result,\n please try other keyword', style: TextStyle(
          color: Colors.black45
        ), textAlign: TextAlign.center,)
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 241, 242, 243),
          appBar: AppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(40), // Creates border
                          color: Colors.white),
                      isScrollable: true,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      dividerColor: Colors.red,
                      dividerHeight: 8,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
                      tabAlignment: TabAlignment.start,
                      tabs: [
                        myTab('Applied'),
                        myTab('Saved'),
                        myTab('Viewed'),
                      ],
                    ),
                    const SizedBox(height: 5)
                  ],
                ),
              ),
            ),
            title: const Text('My Jobs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              MyJobsPane(jobType: 0),
              MyJobsPane(jobType: 1),
              MyJobsPane(jobType: 2),
            ],
          )),
    );
  }
}
