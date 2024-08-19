import 'package:flutter/material.dart';
import 'package:phtv_app/features/adv_card.dart';

import '../apis/apis_list.dart';

class AdsCarousel extends StatefulWidget {
  const AdsCarousel({super.key});

  @override
  State<AdsCarousel> createState() => _AdsCarouselState();
}

class _AdsCarouselState extends State<AdsCarousel> {
  var listAdv = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAdv();
  }

  getAdv() async {
    var data = await AdvApi.getAllAdv.sendRequest();
    listAdv = data.map((e) => e).toList();
    if(data != null){
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
          height: 160,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: listAdv.length,
              itemBuilder: (BuildContext context, int index) => AdvCard(adv: listAdv[index])
          )
      ),
    );
  }
}