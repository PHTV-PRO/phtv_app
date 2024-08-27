import 'dart:convert' show json, utf8;
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phtv_app/apis/apis_list.dart';
import 'package:phtv_app/screens/about_screen.dart';
import 'package:phtv_app/screens/auth/login_screen.dart';
import 'package:phtv_app/screens/privacy_policy_screen.dart';
import 'package:phtv_app/screens/term_condition_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const storage = FlutterSecureStorage();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  var userInfo = {};
  // bool isLoading = true;
  bool isLoggedIn = false;

  onGoBack(dynamic value) {
    loginState();
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
    loginState();
  }


  loginState() async {
    var userToken = await storage.read(key: 'token');
    print(userToken);
    if(userToken != null && userToken != '') {
      Map<String, String> jsonBody = {
        'token': userToken
      };
      var loggedUser = await AuthApi.checkToken.sendRequest(body: jsonBody);
      // var user = await storage.read(key: 'user');
      setState(() {
        userInfo = loggedUser;
        isLoggedIn = true;
      });
    }
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  Future deleteAuthAll() async {
    await storage.deleteAll();
    setState(() {
      isLoggedIn = false;
    });
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    String userName = userInfo['name'] ?? '';
    String userAva = userInfo['image'] ?? '';
    String userEmail = userInfo['email'] ?? '';

    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 241, 242, 243),
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('My Account'),
                surfaceTintColor: Colors.white,
                actions: isLoggedIn ? null : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                        child: TextButton(
                            child: const Text('Sign up'),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const LoginScreen(
                                        tabIndex: 0,
                                      )));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white),
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (ctx) => const LoginScreen(
                                            tabIndex: 1,
                                          )))
                                  .then(onGoBack);
                            },
                            child: const Text('Sign in'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: const EdgeInsets.only(top: 60, left: 10, right: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 70),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    isLoggedIn ? userName : 'ANONYMOUS',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    isLoggedIn ? userEmail : '',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15),
                        child: CircleAvatar(
                          radius: 52,
                          backgroundColor: Colors.grey.withOpacity(0.5),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundColor: Colors.white,
                            child:
                            isLoggedIn ? CircleAvatar(
                              backgroundImage: NetworkImage(userAva),
                              radius: 44,
                            ) : const Icon(EneftyIcons.user_outline, size: 48, color: Colors.grey,),
                          ),
                        ),
                      ),
                      isLoggedIn ? Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(top: 90, left: 70),
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[200]),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.image, size: 11, color: Colors.white),
                                onPressed: () async {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      builder: (BuildContext context) {
                                        uploadFile(File upfile, String fname) async {
                                          var userToken = await storage.read(key: 'token');
                                          Map<String, String> reqHeaders = {
                                            HttpHeaders.contentTypeHeader: 'multipart/form-data',
                                            'Authorization': 'Bearer $userToken',
                                            'Content-Type': 'application/json',
                                          };
                                          var request = http.MultipartRequest('PUT',
                                              Uri.parse('http://10.0.2.2:8080/api/general/account'));
                                          request.headers.addAll(reqHeaders);
                                          request.files.add(http.MultipartFile.fromBytes(
                                            'image',
                                            File(upfile.path).readAsBytesSync(),
                                            filename: fname,
                                          ));
                                          var response = await request.send();
                                          if (response.statusCode == 200) {
                                            Navigator.of(context).pop();
                                          } else {
                                            throw Exception('Failed to upload file');
                                          }
                                        }
                                        return Container(
                                            width: double.infinity,
                                            height: MediaQuery.of(context).size.height * 0.20,
                                            color: Colors.white,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    final picker = ImagePicker();
                                                    final pickedImage = await picker.pickImage(
                                                      source: ImageSource.gallery,
                                                    );
                                                    if (pickedImage == null) return;
                                                    uploadFile(File(pickedImage.path), File(pickedImage.name).toString());
                                                  },
                                                  icon: Icon(
                                                  EneftyIcons.gallery_outline,
                                                  size: 50,
                                                  color: Colors.grey.withOpacity(0.5)),
                                                ),
                                                const SizedBox(width: 80),
                                                IconButton(
                                                  onPressed: () async {
                                                    final picker = ImagePicker();
                                                    final pickedImage = await picker.pickImage(
                                                      source: ImageSource.camera,
                                                    );
                                                    if (pickedImage == null) return;
                                                    uploadFile(File(pickedImage.path), File(pickedImage.name).toString());
                                                  },
                                                  icon: Icon(
                                                      EneftyIcons.camera_outline,
                                                      size: 50,
                                                      color: Colors.grey.withOpacity(0.5)),
                                                ),
                                              ],
                                            ),
                                          );
                                      }).then(onGoBack);
                                },
                              ),
                            ),
                          ),
                        ),
                      ) : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  myAction(),
                ],
              ),
            ),
          );
  }

  Widget myAction() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'INFORMATION',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.setting_2_outline),
                          label: const Text('Privacy Policy'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const PrivacyPolicyScreen()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon:
                              const Icon(EneftyIcons.message_question_outline),
                          label: const Text('Terms and Conditions'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const TermConditionScreen()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.info_circle_outline),
                          label: const Text('About us'),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const AboutScreen()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONTACT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: Image.asset('assets/images/zalo.png',
                              height: 22, color: Colors.black54),
                          label: const Text('Zalo'),
                          onPressed: () async {
                            try {
                              await launchUrl(
                                Uri.parse('http://zalo.me/09012345678'),
                              );
                            } catch (e) {
                              throw 'Could not launch url';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: Image.asset(
                            'assets/images/facebook_icon.png',
                            height: 22,
                            color: Colors.black54,
                          ),
                          label: const Text('PHTV Fanpage'),
                          onPressed: () async {
                            try {
                              await launchUrl(
                                Uri.parse('https://www.facebook.com/phtvpro'),
                              );
                            } catch (e) {
                              throw 'Could not launch url';
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(EneftyIcons.call_outline),
                          label: const Text('Hotline'),
                          onPressed: () async {
                            final Uri launchUri = Uri(
                              scheme: 'tel',
                              path: '09012345678',
                            );
                            await launchUrl(launchUri);
                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.white,
                            backgroundColor: Colors.white,
                            alignment: Alignment.centerLeft,
                            foregroundColor: Colors.black54,
                          ),
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('Email'),
                          onPressed: () async {
                            String? encodeQueryParameters(
                                Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }
                            final Uri launchUri = Uri(
                              scheme: 'mailto',
                              path: 'phtvpro@gmail.com',
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Hello PHTV Pro, I have question',
                              }),
                            );
                            await launchUrl(launchUri);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('You are signing out?'),
                  content: const SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('You are about to sign out our app'),
                        Text('Would you please confirm?'),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: const Text('Signout'),
                      onPressed: () {
                        deleteAuthAll();
                        Navigator.of(context).pop();
                      },
                    ),

                  ],
                );
              },
            );
          },
          child: isLoggedIn ? const Text('Sign out') : const SizedBox.shrink(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
