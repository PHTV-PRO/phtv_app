import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
  static const _pageSize = 5;
  var _activeCallbackIdentity;
  final PagingController<int, dynamic> _pagingController = PagingController(firstPageKey: 0);
  var listData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {

      getData(page);
      // _fetchPage(pageKey, widget.notiType);
    });

  }

  // getData(int size, int page) async {
  //   dynamic data;
  //   switch (widget.dataType) {
  //
  //     case 'Lastest Jobs':
  //       data = await JobApi.getLatestJobs.sendRequest(urlParam: '?size=$size&page=$page');
  //       listData = data.map((e) => e).toList();
  //       break;
  //   }
  //   if(data != null){
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  getData(int page) async {
    final callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    dynamic data;
    try {
      data = await JobApi.getLatestJobs.sendRequest(urlParam: '?size=5&page=$page');
      listData = data.map((e) => e).toList();

      final isLastPage = listData.length < _pageSize;
      print(isLastPage);
      if (isLastPage) {
        _pagingController.appendLastPage(listData);
      } else {
        final nextPageKey = page + 1;
      //   print(nextPageKey);
      // print(listData.length);
      // if (listData.length - nextPageKey < _pageSize) {
      //   _pagingController.appendLastPage(listData);
      // } else {
        _pagingController.appendPage(listData, nextPageKey);
      }
      // listData = data.map((e) => e).toList();
      // print(listData);
      // if (callbackIdentity == _activeCallbackIdentity) {
      //   page++;
      //   _pagingController.appendPage(listData, page);
      // }
      // if(data != null){
      //   setState(() {
      //     isLoading = false;
      //   });
      // }
    } catch (error) {
      _pagingController.error = error;
    }
    // switch (widget.dataType) {
    //
    //   case 'Lastest Jobs':
    //     data = await JobApi.getLatestJobs.sendRequest(urlParam: '?size=$size&page=$page');
    //     listData = data.map((e) => e).toList();
    //     break;
    // }
    // if(data != null){
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
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
        body: Container(
          margin: const EdgeInsets.all(10.0),
            child: PagedListView<int, dynamic>(
                padding: EdgeInsets.zero,
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                itemBuilder: (context, item, index) {
                  return JobCard(jobId: listData[index]['id'], notifyParent: (){},);
                }
            )
            )
                // : ListView.builder(
                //       physics: const ClampingScrollPhysics(),
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   itemCount: listData.length,
                //   itemBuilder: (BuildContext context, int index) =>
                //   JobCard(jobId: listData[index]['id'], notifyParent: (){},)
                //   ),
        ));
  }


}
