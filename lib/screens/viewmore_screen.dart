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

import '../features/job_card.dart';

var storage = const FlutterSecureStorage();

class ViewmoreScreen extends StatefulWidget {
  const ViewmoreScreen({super.key, required this.dataType});
  final String dataType;
  @override
  State<ViewmoreScreen> createState() => _ViewmoreScreenState();
}

class _ViewmoreScreenState extends State<ViewmoreScreen> {
  var listData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    dynamic data;
    switch (widget.dataType) {

      case 'Lastest Jobs':
        data = await JobApi.getLatestJobs.sendRequest();
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
          title: Text(widget.dataType, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: Colors.red,
          surfaceTintColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listData.length,
                        itemBuilder: (BuildContext context, int index) =>
                        JobCard(jobId: listData[index]['id'], notifyParent: (){},)
                        )),
            ],
          ),
        ));
  }


}
