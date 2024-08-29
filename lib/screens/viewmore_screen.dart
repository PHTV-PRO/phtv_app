import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:phtv_app/apis/apis_list.dart';

import '../features/company_card.dart';
import '../features/job_card.dart';
import 'companies/company_detail_screen.dart';

var storage = const FlutterSecureStorage();

class ViewmoreScreen extends StatefulWidget {
  const ViewmoreScreen({super.key, required this.dataType});
  final String dataType;
  @override
  State<ViewmoreScreen> createState() => _ViewmoreScreenState();
}

class _ViewmoreScreenState extends State<ViewmoreScreen> {
  static const _pageSize = 1;
  var _activeCallbackIdentity;
  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 0);
  var listData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData(0,0);
  }

  getData(int size, int page) async {
    dynamic data;
    String? userToken = await storage.read(key: 'token');
    switch (widget.dataType) {

      case 'Jobs fit you':
        data = await CandidateJobApi.getRecommendJobs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
        listData = data.map((e) => e).toList();
        break;
      case 'Latest Jobs':
        data = await JobApi.getLatestJobs.sendRequest(urlParam: '?size=$size&page=$page');
        listData = data.map((e) => e).toList();
        break;
      case 'Your viewed jobs':
        data = await CandidateJobApi.getViewedJobs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
        listData = data.map((e) => e).toList();
        break;
      case 'Your saved jobs':
        data = await CandidateJobApi.getSavedJobs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
        listData = data.map((e) => e).toList();
        break;
      case 'Popular Companies':
        Map<String, String> jsonBody = {
          'province_city_id': '',
          'industry_id': ''
        };
        data = await CompanyApi.filterCompany.sendRequest(body: jsonBody, urlParam: '?size=$size&page=$page');
        listData = data.map((e) => e).toList();
        break;
    }
    if(data != null){
      setState(() {
        isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 242, 243),
        appBar: AppBar(
          title: Text(widget.dataType, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.red,
          surfaceTintColor: Colors.white,
        ),
        body: isLoading ? const Center(child: CircularProgressIndicator()) : Container(
          margin: const EdgeInsets.all(10.0),
            child: listData.isEmpty
                ? const Center(child: Text('Data is not available yet'))
                : ListView.builder(
                      physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) =>
                      widget.dataType != 'Popular Companies' ? JobCard(jobId: listData[index]['id'], notifyParent: (){},) : InkWell(
                        onTap: () async{
                          if (listData[index]['id'] <= 0) return;
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => CompaniesDetailScreen(companyId: listData[index]['id'])));
                        },
                        child: CompanyCard(
                          company: listData[index],
                        ),
                      ),
                  ),
        ));
  }


}
