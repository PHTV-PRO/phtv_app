import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/screens/companies/company_detail_screen.dart';

var storage = const FlutterSecureStorage();

class CompanyCard extends StatefulWidget{
  const CompanyCard({
    super.key,
    required this.company,
  });

  final dynamic company;

  @override
  State<CompanyCard> createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  Set industries = {};
  Set skills = {};
  
  @override
  Widget build(BuildContext context) {
    int companyId = widget.company['id'] ?? 0;
    String companyName = widget.company['name'] ?? '';
    String address = widget.company['locations'][0]['cityProvince']['name'] ?? '';
    String companySize = widget.company['size'] ?? '';
    int openingJobs = widget.company['opening_jobs'] ?? 0;

    if(widget.company['skills'] != null){
      for (var i in widget.company['skills']) {
        industries.add(i['industry']['name']);
        skills.add(i['name']);
      }
    }


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
          if (companyId <= 0) return;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => CompaniesDetailScreen(companyId: companyId)));
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87
                        ),
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
                const SizedBox(height: 6),
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
                const SizedBox(height: 6),
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
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(EneftyIcons.profile_2user_outline, size: 18),
                    const SizedBox(width: 4),
                    Text(companySize),
                    const SizedBox(width: 26),
                    const Icon(EneftyIcons.briefcase_outline, size: 18),
                    const SizedBox(width: 4),
                    Text("$openingJobs job"),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(EneftyIcons.tag_outline, size: 18),
                    const SizedBox(width: 4),
                    Expanded(child: Text(industries.join(", "), maxLines: 2, softWrap: true,overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}