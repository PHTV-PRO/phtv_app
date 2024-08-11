import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/features/partner_jobs/partner_card.dart';

class PartnersCarousel extends StatefulWidget {
  const PartnersCarousel({super.key});

  @override
  State<PartnersCarousel> createState() => _PartnersCarouselState();
}

class _PartnersCarouselState extends State<PartnersCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  var companyList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSpotlightCompanies(5,1);
  }

  getSpotlightCompanies(int size, int page) async {
    companyList = await CompanyApi.getContractCompany.sendRequest(urlParam: '?size=$size&page=$page');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(children: [
            const SizedBox(height: 12),
            CarouselSlider(
              items: companyList.map((item) => PartnerCard(item: item)).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  height: 360,
                  viewportFraction: 0.9,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  aspectRatio: 1.1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: companyList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 14.0,
                      height: 4.0,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15)
                          ),
                          color: Colors.red.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
