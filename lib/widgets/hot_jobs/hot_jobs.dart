import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/widgets/job_card.dart';

class HotJobs extends ConsumerWidget {
  const HotJobs({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hot for you',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'View more',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                    height: 220,
                    child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        width: 340,
                        margin: const EdgeInsets.only(right: 14),
                        child: JobCard(article: 1),
                      ),
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}