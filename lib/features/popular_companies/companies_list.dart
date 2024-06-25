import 'package:flutter/material.dart';
import 'package:phtv_app/apis/company_apis.dart';
import 'package:phtv_app/screens/companies/company_card.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  var _dropDownValue = '';
  var companyList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCompanies();
  }

  getCompanies() async {
    companyList = await CompanyApi.getAllCompanies.sendRequest();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Column(
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
                            style: TextStyle(
                                fontSize: 14, color: Colors.blueAccent),
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 14),
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
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 14),
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
                          itemCount: companyList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CompanyCard(
                                company: companyList[index],
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
