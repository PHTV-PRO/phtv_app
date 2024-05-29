
import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JobCard extends ConsumerWidget{
  const JobCard({
    super.key,
    required this.article,
  });

  final dynamic article;

  @override
  Widget build(BuildContext context,ref) {
    var storage = const FlutterSecureStorage();
    return Container(
      margin: const EdgeInsets.only(right: 18,bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: const Border(
          left: BorderSide( //                   <--- left side
            color: Colors.redAccent,
            width: 6.0,
          ),
          top: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
          right: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
          bottom: BorderSide( //                    <--- top side
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ]
      ),
      child: InkWell(
        onTap: () async {
          showDialog(context: context, builder: (BuildContext dialogContext){
            return const Text('job card');
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 280.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ClipOval(// Image border
                      child: SizedBox.fromSize(
                        size: const Size(40, 40),
                        child: Image.network(
                          'https://i.pravatar.cc/40',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Cong ty TNHH Yura Corporation Bac Ninh - chi nhanh Ha Noi',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FluentIcons.bookmark_20_regular,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '[Senior/Lead] Mobile Security Researcher',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(EneftyIcons.location_outline, size: 18),
                    SizedBox(width: 4),
                    Text('Quận Tân Bình'),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(EneftyIcons.dollar_circle_outline, size: 18),
                    SizedBox(width: 4),
                    Text('Negotiable'),
                  ],
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(EneftyIcons.clock_2_outline, size: 18),
                    SizedBox(width: 4),
                    Text('6 hours ago'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      child: const Text(
                        'Hello World!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      child: const Text(
                        'Hello World!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}