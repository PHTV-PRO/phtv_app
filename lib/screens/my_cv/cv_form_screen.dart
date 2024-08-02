import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/screens/pdf_view_screen.dart';

var storage = const FlutterSecureStorage();

class CvFormScreen extends StatefulWidget {
  const CvFormScreen({super.key});

  @override
  State<CvFormScreen> createState() => _CVFromScreenState();
}

class _CVFromScreenState extends State<CvFormScreen> {
  final _formKeyCV = GlobalKey<FormState>();
  final _formKeyProject = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';

  List project = [];
  String _projectName = '';
  String _projectDescription = '';
  String _projectSkill = '';

  @override
  void initState() {
    super.initState();
  }

  _addProject() async {
    final isValid = _formKeyProject.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKeyProject.currentState!.save();
    Map<String, String> proj = {
      'name_project': _projectName,
      'content': _projectDescription,
      'skill_project': _projectSkill
    };
    project.add(proj);
    setState(() {});
    Navigator.of(context).pop();
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
                onPressed: (){},
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
                        height: 400,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(top: 16),
                        child: Form(
                          key: _formKeyProject,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: cvFormField('Project Name'),
                                autocorrect: true,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in project name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _projectName = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: cvFormField('Project Description'),
                                keyboardType: TextInputType.multiline,
                                minLines: 5,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in project description';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _projectDescription = value!;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                decoration: cvFormField('Project Skills'),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please fill in project description';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _projectSkill = value!;
                                },
                              ),
                              const SizedBox(height: 32),
                              ElevatedButton(
                                onPressed: _addProject,
                                child: const Text('Add Project'),
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
              label: const Text('Add Project'),
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
                    decoration: cvFormField('Name'),
                    autocorrect: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please fill in name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredEmail = value!;
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
                      _enteredPassword = value!;
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
                    onSaved: (value) {
                      _enteredPassword = value!;
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
                      _enteredPassword = value!;
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
                    onSaved: (value) {
                      _enteredPassword = value!;
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
                      _enteredPassword = value!;
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
                      _enteredPassword = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: cvFormField('Graduation year'),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill in graduation year';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
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
                            _enteredPassword = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      for(int i = 0; i < project.length; i++) projectItem(i+1, project[i]['name_project'], project[i]['content'], project[i]['skill_project'])
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

  Container projectItem(int pId, String pName, String pDes, String pSkills){
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Project $pId', style: const TextStyle(color: Colors.black54, fontSize: 12),),
              const Spacer(),
              InkWell(
                child: const Icon(EneftyIcons.close_outline, size: 22, color: Colors.red,),
                  onTap: (){
                    project.removeAt(pId-1);
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
                Text(pName, style: const TextStyle(fontWeight: FontWeight.bold),),
                Text(pDes),
                Text(pSkills),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
