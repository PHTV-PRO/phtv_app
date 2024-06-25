import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/apis/job_apis.dart';
import 'package:phtv_app/features/ads_carousel.dart';
import 'package:phtv_app/features/hot_jobs/hot_jobs.dart';
import 'package:phtv_app/features/latest_jobs/latest_jobs.dart';
import 'package:phtv_app/features/partner_jobs/partners_carousel.dart';
import 'package:phtv_app/features/saved_jobs/saved_jobs.dart';
import 'package:phtv_app/features/viewed_jobs/viewed_jobs.dart';
import 'package:phtv_app/screens/search/search_screen.dart';

class JobsScreen extends StatefulWidget{
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {

  @override
  void initState() {
    super.initState();
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