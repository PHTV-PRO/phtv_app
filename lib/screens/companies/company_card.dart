import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/screens/companies/company_detail_screen.dart';

var storage = const FlutterSecureStorage();

class CompanyCard extends ConsumerWidget{
  const CompanyCard({
    super.key,
    required this.company,
  });

  final dynamic company;

  @override
  Widget build(BuildContext context,ref) {
    String companyName = company['name'] ?? 'company name';
    String address = company['name'] ?? 'address';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(style: BorderStyle.solid, color: Colors.grey),
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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const CompaniesDetailScreen()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
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
                    Expanded(
                      child: Text(
                        companyName,
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
                Row(
                  children: [
                    const Icon(EneftyIcons.location_outline, size: 18),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(address,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
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
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: const Text(
                        'Hello World!',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.withOpacity(0.5),
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