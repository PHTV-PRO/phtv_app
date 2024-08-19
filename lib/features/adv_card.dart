import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvCard extends StatefulWidget{
  const AdvCard({
    super.key,
    required this.adv,
  });

  final dynamic adv;

  @override
  State<AdvCard> createState() => _AdvCardState();
}

class _AdvCardState extends State<AdvCard> {
  String advImg = '';
  String path = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      advImg = widget.adv['image'];
      path = widget.adv['path'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18,bottom: 8),
      child: InkWell(
        onTap: () async {
          try {
            await launchUrl(
              Uri.parse(path),
            );
          } catch (e) {
            throw 'Could not launch url';
          }
        },
        child: SizedBox(
          width: 320.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18), // Image border
            child: SizedBox.fromSize(
              size: const Size(160, 110),
              child: Image.network(advImg,
                width: double.infinity,
                // height: 140,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}