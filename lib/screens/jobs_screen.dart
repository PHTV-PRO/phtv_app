import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:phtv_app/widgets/ads_carousel.dart';
import 'package:phtv_app/widgets/hot_jobs.dart';
import 'package:phtv_app/widgets/partners_carousel.dart';

class JobsScreen extends StatelessWidget{
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Type keyword to search",
                fillColor: Colors.white70,
                suffixIcon: IconButton(
                    icon: Icon(
                      EneftyIcons.search_normal_2_outline,
                      size: 18,
                      color: Colors.grey[800],
                    ),
                    onPressed: (){}),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter keyword';
                }
                return null;
              },
              onSaved: (value) {
                print('ahihi');
              },
            ),
          ),

          const PartnersCarousel(),
      
          //Advertisment
          const AdsCarousel(),
      
          //Hot for you
          const HotJobs(),
        ],
      ),
    );
  }
}