import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';

var storage = const FlutterSecureStorage();

class MyCVScreen extends StatefulWidget {
  const MyCVScreen({super.key});

  @override
  State<MyCVScreen> createState() => _MyCVScreenState();
}

class _MyCVScreenState extends State<MyCVScreen> {
  File? cvFile;
  String filename = '';
  var cvList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllCV();
  }

  getAllCV() async {
    var userToken = await storage.read(key: 'token');
    var data = await CandidateCVApi.getAllCVs.sendRequest(token: userToken);
    if (data != null) {
      cvList = data.map((e) => e).toList();
    }
    if (userToken != null && cvList != null) {
      setState(() {
        isLoading = false;
      });
    }
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('My CV'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: BottomAppBar(
            elevation: 0,
            height: 60,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              child: const Text('UPLOAD CV'),
            ),
          ),
        ),
        body: Column(
          children: [
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
            Container(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : (cvList.isEmpty
                        ? Container(
                            height: 110,
                            alignment: Alignment.center,
                            child: const Text('You still not create any CV'))
                        : ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: cvList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            width: 340,
                            margin: const EdgeInsets.only(right: 14),
                            child: Text(cvList[index]),
                          ),
                        ))),
          ],
        ));
  }
}
