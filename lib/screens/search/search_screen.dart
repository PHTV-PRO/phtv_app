import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/features/ads_carousel.dart';
import 'package:phtv_app/features/hot_jobs/hot_jobs.dart';
import 'package:phtv_app/features/latest_jobs/latest_jobs.dart';
import 'package:phtv_app/features/saved_jobs/saved_jobs.dart';
import 'package:phtv_app/features/viewed_jobs/viewed_jobs.dart';
import 'package:phtv_app/screens/search/search_result_screen.dart';

var storage = const FlutterSecureStorage();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formSearch = GlobalKey<FormState>();
  var _keyword = '';
  var _result = {};

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    loginState();
  }

  search(String value) async {
    final isValid = _formSearch.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formSearch.currentState!.save();
    _result = await SearchApi.search.sendRequest(urlParam: '/$value');
  }

  loginState() async {
    String? userToken = await storage.read(key: 'token');
    if(userToken != null && userToken != '') {
      Map<String, String> jsonBody = {
        'token': userToken
      };
      var data = await AuthApi.checkToken.sendRequest(body: jsonBody);
      if (data != null) {
        setState(() {
          isLoggedIn = true;
        });
      }else{
        await storage.deleteAll();
      }
    }else{
      await storage.deleteAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: const BackButton(
            color: Colors.white
        ),
        title: Form(
          key: _formSearch,
          child: TextFormField(
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(color: Colors.white),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Type keyword to search",
              fillColor: Colors.white,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            autofocus: true,
            onFieldSubmitted: (value) async {
              _keyword = value;
              await search(value);
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => SearchResultScreen(keyword: _keyword, result: _result,)));
            },
            textInputAction: TextInputAction.search,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //Viewed jobs
            isLoggedIn == true ? const ViewedJobs() : const SizedBox.shrink(),

            //Saved jobs
            isLoggedIn == true ? const SavedJobs() : const SizedBox.shrink(),

            //Hot for you
            isLoggedIn == true ? const HotJobs() : const SizedBox.shrink(),

            //Latest jobs
            const LatestJobs(),

            //Advertisment
            const AdsCarousel(),
          ],
        ),
      ),
    );
  }
}
