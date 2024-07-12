import 'dart:convert';
import 'dart:io';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/features/ads_carousel.dart';
import 'package:phtv_app/features/hot_jobs/hot_jobs.dart';
import 'package:phtv_app/features/latest_jobs/latest_jobs.dart';
import 'package:phtv_app/features/partner_jobs/partners_carousel.dart';
import 'package:phtv_app/features/saved_jobs/saved_jobs.dart';
import 'package:phtv_app/features/viewed_jobs/viewed_jobs.dart';
import 'package:phtv_app/screens/search/search_screen.dart';
import 'package:http/http.dart' as http;

var storage = const FlutterSecureStorage();

class JobsScreen extends StatefulWidget{
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  File? cvFile;
  String filename = '';

  @override
  void initState() {
    super.initState();
  }


  uploadFile(File upfile)async {
    var userToken = await storage.read(key: 'token');
    Map<String, String> reqHeaders = {
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
      'Authorization' : 'Bearer $userToken',
      'Content-Type' : 'application/json',
    };
    var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:8080/api/candidate/cv'));
    request.headers.addAll(reqHeaders);
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      File(upfile.path).readAsBytesSync(),
      filename: 'test.jpg',
    ));
    var response = await request.send();
    final respStr = await response.stream.bytesToString();

    print(
      jsonDecode(respStr),
    );

    if (response.statusCode == 200) {
      // return jsonDecode(response.body)['data'];
    } else {
      throw Exception('Failed to upload Photo');
    }
  }




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const SearchScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
                ),
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Text("Type keyword to search"),
                  const Spacer(),
                  Icon(
                            EneftyIcons.search_normal_2_outline,
                            size: 18,
                            color: Colors.grey[800],
                          )
                  ],
                ),
              ),
            )
          ),



          const PartnersCarousel(),

          //Hot for you
          const HotJobs(),

          Container(
              height: 200,
              child: FormField(
                  builder: (formFieldState) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            var file = await FilePicker.platform.pickFiles();
                            if (file != null) {
                                setState(() {
                                  cvFile = File(file.files.first.path!);
                                  filename = File(file.files.first.name).toString();
                                });
                            }

                          },
                        ),



                        if (formFieldState.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 10),
                            child: Text(
                              formFieldState.errorText!,
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 13,
                                  color: Colors.red[700],
                                  height: 0.5),
                            ),
                          )
                      ],
                    );
                  })
          ),

          Text(filename),
          ElevatedButton(onPressed: (){uploadFile(cvFile!);}, child: Text('upload')),

          //Latest jobs
          const LatestJobs(),

          //Advertisment
          const AdsCarousel(),

          //Viewed jobs
          const ViewedJobs(),

          //Saved jobs
          const SavedJobs(),
        ],
      ),
    );
  }
}