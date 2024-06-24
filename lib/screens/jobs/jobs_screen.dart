import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/screens/search/search_screen.dart';
import 'package:phtv_app/screens/tools_screen.dart';
import 'package:phtv_app/widgets/ads_carousel.dart';
import 'package:phtv_app/widgets/hot_jobs/hot_jobs.dart';
import 'package:phtv_app/widgets/latest_jobs/latest_jobs.dart';
import 'package:phtv_app/widgets/partner_jobs/partners_carousel.dart';
import 'package:phtv_app/widgets/saved_jobs/saved_jobs.dart';
import 'package:phtv_app/widgets/viewed_jobs/viewed_jobs.dart';

class JobsScreen extends StatelessWidget{
  const JobsScreen({super.key});

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