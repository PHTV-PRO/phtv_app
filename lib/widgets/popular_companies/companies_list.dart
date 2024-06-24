import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phtv_app/screens/companies/company_card.dart';
import 'package:phtv_app/screens/jobs/job_card.dart';
import 'package:phtv_app/widgets/popular_companies/popular_com_card.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  var _dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Popular Companies',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'View more',
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: DropdownButtonFormField(
                          hint: Text('Location'),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          // isExpanded: true,
                          borderRadius: BorderRadius.circular(20.0),
                          items: ['One', 'Two', 'Three'].map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val!;
                              },
                            );
                          }),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 140,
                      height: 40,
                      child: DropdownButtonFormField(
                          hint: Text('Location'),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          // isExpanded: true,
                          borderRadius: BorderRadius.circular(20.0),
                          items: ['One', 'Two', 'Three'].map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                _dropDownValue = val!;
                              },
                            );
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) =>
                        CompanyCard(
                          company: 1,
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
