import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/screens/my_cv/cv_form_screen.dart';
import 'package:phtv_app/screens/pdf_view_screen.dart';

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
    getAllCV(10,1);
  }

  getAllCV(int size, int page) async {
    String? userToken = await storage.read(key: 'token');
    print(userToken);
    if (userToken != null && userToken != '') {
      var data = await CandidateCVApi.getAllCVs.sendRequest(token: userToken, urlParam: '?size=$size&page=$page');
      if (data != null) {
        cvList = data.map((e) => e).toList();
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  deleteCV(int id) async {
    String? userToken = await storage.read(key: 'token');
    await CandidateCVApi.deleteCV.sendRequest(token: userToken, urlParam: '?id=$id');
    getAllCV(10,1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 242, 243),
        appBar: AppBar(
          title: const Text('My CV', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            height: 120,
            child: Column(
              children: [
                ElevatedButton(
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
                            var request = http.MultipartRequest('POST',
                                Uri.parse('http://10.0.2.2:8080/api/candidate/cv'));
                            request.headers.addAll(reqHeaders);
                            request.fields.addAll({
                              'name': cvName,
                            });
                            request.files.add(http.MultipartFile.fromBytes(
                              'file',
                              File(upfile.path).readAsBytesSync(),
                              filename: filename,
                            ));
                            var response = await request.send();
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
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        EneftyIcons.document_upload_outline,
                                                        size: 60,
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                      ),
                                                      Text(filename),
                                                    ],
                                                  )),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 6),
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
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                        ),
                                        validator: (value) {
                                          if (cvFile == null) {
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
                        }).then((value) => getAllCV(10,1));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Upload CV From File'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const CvFormScreen())).then((value) => getAllCV(10,1));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Create CV'),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 0,
                                        blurRadius: 6,
                                      ),
                                    ]
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(EneftyIcons.document_favorite_outline, color: Colors.red, size: 35),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cvList[index]['name'] != '' ? cvList[index]['name'].toString().toUpperCase() : 'NO-NAME', style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red
                                          ),),
                                          Text('Created date: ${cvList[index]['create_at'].toString().substring(0,10)}', style: const TextStyle(fontSize: 12),),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height:25,
                                              child: ElevatedButton.icon(onPressed: (){
                                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => PDFViewScreen(path: cvList[index]['file_name'])));
                                              }, icon: const Icon(EneftyIcons.eye_outline, size: 18), label: const Text('Preview')))
                                        ],
                                      ),
                                    ),
                                    IconButton(onPressed: (){
                                      showDialog(
                                          context: context,
                                          useRootNavigator: false,
                                          builder: (BuildContext dialogContext) => AlertDialog(
                                            elevation: 0,
                                            backgroundColor: Colors.white,
                                            title: const Text('Confirm Delete', textAlign: TextAlign.center),
                                            content: Text('Are you sure to delete CV ${cvList[index]['name'].toString().toUpperCase()}', textAlign: TextAlign.center),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              }, child: const Text('Cancel')),
                                              ElevatedButton(
                                                  onPressed: (){
                                                    deleteCV(cvList[index]['id']);
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                                                  child: const Text('Confirm'))
                                            ],
                                          ));
                                      }, icon: const Icon(EneftyIcons.trash_outline, size: 18, color: Colors.red))
                                  ],
                                ),
                              ),
                            ))),
            ],
          ),
        ));
  }


}
