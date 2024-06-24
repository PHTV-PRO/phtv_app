import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/widgets/adv_card.dart';
import 'package:phtv_app/screens/jobs/job_card.dart';

class AdsCarousel extends ConsumerWidget {
  const AdsCarousel({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
          height: 150,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) => AdvCard(article: 1)
          )
      ),
    );
  }
}