import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';

var storage = const FlutterSecureStorage();

class CvFormScreen extends StatefulWidget {
  const CvFormScreen({super.key});

  @override
  State<CvFormScreen> createState() => _CVFromScreenState();
}

class _CVFromScreenState extends State<CvFormScreen> {
  final _formKeyCV = GlobalKey<FormState>();
  final _formKeyProject = GlobalKey<FormState>();

  String _cvname = '';
  String _yourname = '';
  String _decription = '';
  String _email = '';
  String _address = '';
  String _phone = '';
  String _skill = '';
  String _name_school = '';
  String _year = '';
  String _major= '';

  List work_experience = [];
  String _compamyName = '';
  String _workDescription = '';
  String _workSkill = '';
  String _workTime = '';

  @override
  void initState() {
    super.initState();
  }

  _addWorkExp() async {
    final isValid = _formKeyProject.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeyProject.currentState!.save();
    Map<String, String> exp = {
      'name_work_experience': _compamyName,
      'content': _workDescription,
      'skill_work_experience': _workSkill,
      'working_time': _workTime
    };
    work_experience.add(exp);
    setState(() {});
    Navigator.of(context).pop();
  }

  _createCv() async {
    final isValid = _formKeyCV.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeyCV.currentState!.save();
    Map<String, dynamic> jsonBody = {
      'name_cv': _cvname,
      'name': _yourname,
      'decription': _decription,
      'email': _email,
      'address': _address,
      'phone': _phone,
      'skill': _skill,
      'name_school': _name_school,
      'year': _year,
      'major': _major,
      'work_experiences': work_experience
    };
    String? userToken = await storage.read(key: 'token');
    var result = await CandidateCVApi.createCV.sendRequest(token: userToken, body: jsonBody);
    print(result);
    if(result == 'Success'){
      Navigator.pop(context, () {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // title: const Text('Create CV', style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: _createCv,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Create CV'),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.transparent,
          width: double.infinity,
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            height: 60,
            child: TextButton.icon(
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  builder: (BuildContext context){
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 16),
                        child: Form(
                          key: _formKeyProject,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: cvFormField('Company Name'),
                                autocorrect: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in company name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _compamyName = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: cvFormField('Working Time'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in work time';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _workTime = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: cvFormField('Work Description'),
                                keyboardType: TextInputType.multiline,
                                minLines: 5,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in work description';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _workDescription = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: cvFormField('Work Skills'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in work skills';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _workSkill = value!;
                                },
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: _addWorkExp,
                                child: const Text('Add Experience'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
              },
              icon: const Icon(EneftyIcons.add_circle_outline),
              label: const Text('Add Work Experience'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKeyCV,
              child: Column(
                children: [
                  TextFormField(
                    decoration: cvFormField('CV name'),
                    autocorrect: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in CV name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _cvname = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Your name'),
                    autocorrect: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _yourname = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Description'),
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _decription = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Email'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty || !value.contains('@') || !value.contains('.')) {
                        return 'Please fill in correct email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Address'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _address = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Phone number'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      _phone = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('Skills'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in skills';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _skill = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: cvFormField('School name'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in school name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name_school = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: cvFormField('Graduation year'),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill in graduation year';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _year = value!;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: cvFormField('Major'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill in major';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _major = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      for(int i = 0; i < work_experience.length; i++)
                        workExpItem(
                          i+1,
                          work_experience[i]['name_work_experience'],
                            work_experience[i]['working_time'],
                            work_experience[i]['content'],
                            work_experience[i]['skill_work_experience'])
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  InputDecoration cvFormField (String text){
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          const Text('*', style: TextStyle(color: Colors.red)),
        ],
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      filled: true,
      fillColor: Colors.white,
      errorStyle: const TextStyle(color: Colors.red),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }

  Container workExpItem(int pId, String wName, String wTime, String wDes, String wSkills){
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Work Exprience $pId', style: const TextStyle(color: Colors.black54, fontSize: 12),),
              const Spacer(),
              InkWell(
                child: const Icon(EneftyIcons.close_outline, size: 22, color: Colors.red,),
                  onTap: (){
                    work_experience.removeAt(pId-1);
                    setState(() {});
                  },
              )
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(8.0)),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(wName, style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 6),
                Text('Working time: $wTime'),
                const SizedBox(height: 6),
                Text(wDes),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  child: Text(wSkills, style: const TextStyle(fontStyle: FontStyle.italic,)),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }

}
