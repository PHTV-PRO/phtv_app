import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AdvCard extends ConsumerWidget{
  const AdvCard({
    super.key,
    required this.article,
  });

  final dynamic article;

  @override
  Widget build(BuildContext context,ref) {
    var storage = const FlutterSecureStorage();
    return Container(
      margin: const EdgeInsets.only(right: 18,bottom: 8),
      child: InkWell(
        onTap: ()  {},
        child: SizedBox(
          width: 320.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18), // Image border
            child: SizedBox.fromSize(
              size: const Size(160, 110),
              child: Image.network(
                'https://i.pravatar.cc/160',
                width: double.infinity,
                // height: 120,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}