import 'package:enefty_icons/enefty_icons.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:phtv_app/screens/companies/companies_screen.dart';
import 'package:phtv_app/screens/jobs/jobs_screen.dart';
import 'package:phtv_app/screens/profile/profile_screen.dart';
import 'package:phtv_app/screens/search/search_screen.dart';
import 'package:phtv_app/screens/tools_screen.dart';

var storage = const FlutterSecureStorage();

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;
  bool isLoggedIn = false;

  void _selectPage(int index) async {
    var loggedUser = await storage.read(key: "user");
    setState(() {
      _selectPageIndex = index;
    });
  }

  loginState() async {
    // isLoggedIn = await AppUtils.checkLoginState();
  }

  @override
  void initState() {
    super.initState();
    loginState();
  }

  @override
  Widget build(BuildContext context) {
    loginState();
    Widget activePage = const JobsScreen();

    switch (_selectPageIndex) {
      case 0:
        activePage = const JobsScreen();
        break;
      case 1:
        activePage = const CompaniesScreen();
        break;
      case 2:
        activePage = const ToolsScreen();
        break;
      case 3:
        activePage = const ProfileScreen();
    }

    return Scaffold(
      appBar: _selectPageIndex != 3 ? AppBar(
        backgroundColor: Colors.red,
        title: _selectPageIndex != 1 ? const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(EneftyIcons.briefcase_bold, color: Colors.white,),
            SizedBox(width: 6),
            Text('PHTV PRO', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          ],
        ) : InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => const SearchScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              children: [
                const Text("Type keyword to search", style: TextStyle(fontSize: 14),),
                const Spacer(),
                Icon(
                  EneftyIcons.search_normal_2_outline,
                  size: 18,
                  color: Colors.grey[800],
                )
              ],
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
                showDialog(context: context, builder: (BuildContext dialogContext){
                  return const Text('notifcation');
                });
            },
            icon: Icon(
              FluentIcons.alert_20_regular,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: const Offset(0.0, 1.0),
                  blurRadius: 10.0,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ],
      ) : null,
      backgroundColor: const Color.fromARGB(255, 241, 242, 243),
      body: activePage,
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 20,
            ),
          ],
        ),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            currentIndex: _selectPageIndex,
            fixedColor: Colors.redAccent,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.briefcase_outline),
                  label: 'Jobs',
                  activeIcon: Icon(EneftyIcons.briefcase_bold)),
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.home_2_outline),
                  label: 'Companies',
                  activeIcon: Icon(EneftyIcons.home_2_bold)),
              BottomNavigationBarItem(
                  icon: Icon(EneftyIcons.element_3_outline),
                  label: 'Tools',
                  activeIcon: Icon(EneftyIcons.element_3_bold)),
              BottomNavigationBarItem(
                icon: Icon(EneftyIcons.user_outline),
                activeIcon: Icon(EneftyIcons.user_bold),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
