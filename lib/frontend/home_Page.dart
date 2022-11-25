import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_final/backend/user_model.dart';
import 'package:project_final/frontend/login_page.dart';
import 'package:project_final/frontend/graph_page.dart';
import 'package:project_final/implementations/textStyle.dart';
import 'package:provider/provider.dart';
import '../backend/calculation.dart';
import '../utils/colors.dart';
import '../implementations/fpsReading.dart';
import '../implementations/gauge_reading.dart';
import '../implementations/MainReading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  /*This will take the user details from the firebase and will provide wherever it will be called */
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Container(
          child: textWidget("EMF DETECTION"),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    child: DrawerHeader(
                      child: UserAccountsDrawerHeader(
                        currentAccountPicture: new CircleAvatar(),
                        accountName: Text(
                            "${loggedInUser.firstName} ${loggedInUser.lastName}"),
                        accountEmail: Text("${loggedInUser.email}"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                "Logout",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                logout(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.close,
                color: Colors.white,
              ),
              title: Text(
                'Close Drawer',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context); // close the drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const fpsReading(),
              SizedBox(height: 20),
              const Gauge(),
              const MainReading(),
              const SizedBox(
                height: 15,
              ),
              Consumer<calculate>(
                builder: (context, models, child) => Container(
                  width: 200,
                  height: 50,
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: BorderSide(color: Colors.white))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.green),
                          ),
                          onPressed: () {
                            bool isListening = false;
                            models.start_listening(isListening);
                          },
                          child: Text('Start')),
                      SizedBox(
                        width: 70,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                    side: BorderSide(color: Colors.white))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.red),
                          ),
                          onPressed: () {
                            bool isListening = true;
                            models.start_listening(isListening);
                          },
                          child: Text('Stop')),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(color: Colors.white))),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => graph()),
                    );
                  },
                  child: const Text('Live Graph'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // this is the function for logout button
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
