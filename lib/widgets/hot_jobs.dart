import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/widgets/job_card.dart';

class HotJobs extends ConsumerWidget {
  const HotJobs({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text('Hot for you',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                ),),

              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: 220,
              child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) => JobCard(article: 1)
                  )
              ),
          ],
        ),
      ),
    );
  }
}