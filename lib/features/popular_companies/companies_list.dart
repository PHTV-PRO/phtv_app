import 'package:flutter/material.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/features/company_card.dart';

class CompaniesList extends StatefulWidget {
  const CompaniesList({super.key});

  @override
  State<CompaniesList> createState() => _CompaniesListState();
}

class _CompaniesListState extends State<CompaniesList> {
  var _dropDownValue = '';
  late List location = [{'id': 0, 'name': ''}];
  late List industry = [{'id': 0, 'name': ''}];
  var companyList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCompanies();
  }

  getLocationList() async {
    var data = await LocationApi.getLocationList.sendRequest();
    for (var dt in data){
      location.add(dt);
    }
  }

  getIndustryList() async {
    var data = await IndustryApi.getIndustryList.sendRequest();
    for (var dt in data){
      industry.add(dt);
    }
  }

  getCompanies() async {
    getLocationList();
    getIndustryList();
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
                            width: 160,
                            height: 40,
                            child: DropdownButtonFormField(
                              isDense: true,
                                hint: const Text('Location'),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(20.0),
                                items: location.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val['name'] == '' ? 'All' : val['name'],
                                      child: Text(val['name'] == '' ? 'All' : val['name']),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(() {
                                      _dropDownValue = val!;
                                    },
                                  );
                                }),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 160,
                            height: 40,
                            child: DropdownButtonFormField(
                                hint: const Text('Industry'),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(20.0),
                                items: industry.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val['name'] == '' ? 'All' : val['name'],
                                      child: Text(val['name'] == '' ? 'All' : val['name']),
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
