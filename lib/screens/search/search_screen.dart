import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/widgets/ads_carousel.dart';
import 'package:phtv_app/widgets/hot_jobs/hot_jobs.dart';
import 'package:phtv_app/widgets/latest_jobs/latest_jobs.dart';
import 'package:phtv_app/widgets/partner_jobs/partners_carousel.dart';
import 'package:phtv_app/widgets/saved_jobs/saved_jobs.dart';
import 'package:phtv_app/widgets/top_keywords/top_keywords.dart';
import 'package:phtv_app/widgets/viewed_jobs/viewed_jobs.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: const BackButton(
            color: Colors.white
        ),
        title: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: Colors.white),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[800]),
            hintText: "Type keyword to search",
            fillColor: Colors.white,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          ),
          autofocus: true,
          onFieldSubmitted: (value) {
            print(value);
          },
          textInputAction: TextInputAction.search,
        ),
        actions: [Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(EneftyIcons.setting_3_outline, color: Colors.white,shadows: [
            Shadow(
              offset: const Offset(0.0, 1.0),
              blurRadius: 10.0,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //Top keyword
            const TopKeywords(),

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
      ),
    );
  }
}
