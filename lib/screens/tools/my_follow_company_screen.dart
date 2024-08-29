import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/features/company_card.dart';
import '../../apis/apis_list.dart';
import '../companies/company_detail_screen.dart';

var storage = const FlutterSecureStorage();

class MyFollowCompanyScreen extends StatefulWidget{
  const MyFollowCompanyScreen({super.key});

  @override
  State<MyFollowCompanyScreen> createState() => _MyFollowCompanyScreenState();
}

class _MyFollowCompanyScreenState extends State<MyFollowCompanyScreen> {
  var followingCompany = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFollowingData(0,0);
  }

  getFollowingData(int size, int page) async {
    String? userToken = await storage.read(key: 'token');
    if (userToken != null && userToken != '') {
      var data = await CompanyApi.getFollowingCompany.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
      if (data != null) {
        followingCompany = data.map((e) => e).toList();
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  onGoBack(dynamic value) {
    getFollowingData(0,0);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 242, 243),
      appBar: AppBar(
        title: const Text('My Following Companies', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : (followingCompany.isEmpty
                      ? Container(
                      height: 110,
                      alignment: Alignment.center,
                      child: const Text('You still not follow any company'))
                      : ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: followingCompany.length,
                    itemBuilder: (BuildContext context, int index) =>
                        InkWell(
                          onTap: () async{
                            if (followingCompany[index]['id'] <= 0) return;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CompaniesDetailScreen(companyId: followingCompany[index]['id']))).then(onGoBack);
                          },
                          child: CompanyCard(
                            company: followingCompany[index],
                          ),
                        ),
                  ))),
            ],
          ),
        ),
      ),
    );
  }
}