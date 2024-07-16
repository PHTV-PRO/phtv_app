import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:enefty_icons/enefty_icons.dart';
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
  var cvList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllCV();
  }

  getAllCV() async {
    String? userToken = await storage.read(key: 'token');
    if (userToken != null && userToken != '') {
      var data = await CandidateCVApi.getAllCVs.sendRequest(token: userToken);
      if (data != null) {
        cvList = data.map((e) => e).toList();
        setState(() {
          isLoading = false;
        });
      }
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
              onPressed: () {
                final _formCVName = GlobalKey<FormState>();
                File? cvFile;
                String cvName = '';
                String filename = '';
                String status = 'Upload';
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
                      uploadFile(File upfile) async {
                        var userToken = await storage.read(key: 'token');
                        Map<String, String> reqHeaders = {
                          HttpHeaders.contentTypeHeader: 'multipart/form-data',
                          'Authorization': 'Bearer $userToken',
                          'Content-Type': 'application/json',
                        };
                        var request = http.MultipartRequest(
                            'POST', Uri.parse('http://10.0.2.2:8080/api/candidate/cv'));
                        request.headers.addAll(reqHeaders);
                        // Map<String, String> data = {
                        //   'name': cvName
                        // };
                        // var data = {
                        //   'name': cvName,
                        // };
                        // request.fields.addAll(jsonEncode(data) as Map<String, String>);
                        request.fields.addAll(
                          {'name': cvName,}
                        );
                        request.files.add(http.MultipartFile.fromBytes(
                          'file',
                          File(upfile.path).readAsBytesSync(),
                          filename: filename,
                        ));
                        var response = await request.send();
                        final respStr = await response.stream.bytesToString();

                        print(request.toString());
                        print(cvName);

                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();
                        } else {
                          throw Exception('Failed to upload Photo');
                        }
                      }

                      return StatefulBuilder(
                        builder: (BuildContext context, setState) => Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.85,
                          color: Colors.white,
                          child: Column(
                            children: [
                              FormField(builder: (formFieldState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      color: Colors.grey.withOpacity(0.1),
                                      margin: const EdgeInsets.all(20),
                                      child: InkWell(
                                        child: DottedBorder(
                                          dashPattern: const [10, 4],
                                          strokeWidth: 2,
                                          color: Colors.grey,
                                          strokeCap: StrokeCap.round,
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(15),
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            height: 150,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(EneftyIcons.document_upload_outline, size: 60, color: Colors.grey.withOpacity(0.5),),
                                                Text(filename),
                                              ],
                                            )
                                          ),
                                        ),
                                        onTap: () async {
                                          var file = await FilePicker.platform.pickFiles();
                                          if (file != null) {
                                            formFieldState.save();
                                            setState(() {
                                              cvFile = File(file.files.first.path!);
                                              filename = File(file.files.first.name).toString();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                    if (formFieldState.hasError)
                                      Text(
                                        formFieldState.errorText!,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13,
                                            color: Colors.red[700],
                                            height: 0.5),
                                      ),

                                  ],
                                );
                              }),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                                child: Form(
                                  key: _formCVName,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey[800]),
                                      hintText: "Please enter CV name",
                                      fillColor: Colors.white,
                                      errorStyle: const TextStyle(color: Colors.red),
                                      contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    ),
                                    validator: (value) {
                                      if(cvFile == null){
                                        return 'Please select CV to upload';
                                      }
                                      if (value == null || value.trim().isEmpty) {
                                        return 'You must enter CV name';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      cvName = value!;
                                    },
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    print(cvName);
                                    final isValid = _formCVName.currentState?.validate();
                                    if (!isValid!) {
                                      return;
                                    }
                                    _formCVName.currentState!.save();
                                    setState(() {
                                      status = 'Uploading';
                                    });

                                    await Future.delayed(const Duration(seconds: 1));
                                    uploadFile(cvFile!);

                                  },
                                  child: Text(status)),
                            ],
                          ),
                        ),
                      );
                    }).then((value) => getAllCV());
              },
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
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
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
                              child: Text(cvList[index]['file_name']),
                            ),
                          ))),
          ],
        ));
  }
}
