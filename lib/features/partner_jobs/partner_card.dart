import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnerCard extends ConsumerWidget {
  const PartnerCard({
    super.key,
    required this.item,
  });

  final dynamic item;

  @override
  Widget build(BuildContext context, ref) {
    String companyName = item['name'] ?? '';
    String comanyImage = item['background_image'] ?? 'https://i.pravatar.cc/160';
    String companyIntro = item['introduction'] ?? '';

    Set skills = {};
    if(item['skills'] != null){
      for (var i in item['skills']) {
        skills.add(i['name']);
      }
    }

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Center(
                  child: Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  Image.network(comanyImage, width: double.infinity, height: 205, fit: BoxFit.cover),
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network('https://i.pravatar.cc/160',
                            height: 60, width: 120, fit: BoxFit.cover,)),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: Text(
                      companyName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    companyIntro,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  const Row(
                    children: [
                      Icon(EneftyIcons.briefcase_outline, size: 18),
                      SizedBox(width: 4),
                      Text('2 jobs'),
                    ],
                  ),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for(int i = 0; i < skills.length; i++)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Text(
                            skills.elementAtOrNull(i),
                            style: const TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
