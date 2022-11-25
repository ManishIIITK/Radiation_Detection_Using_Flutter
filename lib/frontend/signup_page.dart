import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_final/backend/user_model.dart';
import 'package:project_final/frontend/login_page.dart';
import 'package:project_final/utils/colors.dart';
import '../implementations/textStyle.dart';
import 'home_Page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  // progress indicator
  bool isLoading = false;
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // firstName field
    final firstNameField = TextFormField(
      style: TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.red,
      cursorWidth: 5,
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        hintText: 'First Name',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      // This validator will make sure that the first name is not empty
      validator: (value) {
        if (value!.isEmpty) {
          return ("FirstName cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    // lastName Field
    final lastNameField = TextFormField(
      style: TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.red,
      cursorWidth: 5,
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        hintText: 'Last Name',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("LastName cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    // email field
    final emailField = TextFormField(
      style: TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.red,
      cursorWidth: 5,
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.white,
        ),
        hintText: 'Email',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your email");
        }
        // regular expression for the email. If the user try to enter some illegal thing other than the email then it will throw an error
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Please enter a valid email ");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    // password field
    final passwordField = TextFormField(
      style: TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.red,
      cursorWidth: 5,
      obscureText: true, // THis will make password invisible
      autofocus: false,
      controller: passwordEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return ("Password field cannot be empty");
        }
        if (value.toString().length < 6) {
          return ("Password cannot be less than 6 digit");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    // confirm password field
    final confirmPasswordField = TextFormField(
      style: TextStyle(color: Colors.white),
      showCursor: true,
      cursorColor: Colors.red,
      cursorWidth: 5,
      obscureText: true,
      autofocus: false,
      controller: confirmPasswordEditingController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: 'Confirm Password',
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      // vlaidtor will make sure that the password and the confirm password field is having the same input
      validator: (value) {
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ("password doesn't match");
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
    );
    // login button
    final signUpButton = Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(30),
      color: AppColors.green,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            isLoading = true;
          });
          signUp(emailEditingController.text, passwordEditingController.text);
          setState(() {
            isLoading = false;
          });
        },
        child: isLoading
            ? Row(
                children: [
                  CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Loading.."),
                ],
              )
            : Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
        minWidth: double.infinity,
      ),
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.green,
          automaticallyImplyLeading: false,
          title: Container(
            child: textWidget("Sign-Up Page"),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 150,
                        child: Image.asset(
                          "assets/emf_1.png",
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 40),
                      firstNameField,
                      SizedBox(height: 10),
                      lastNameField,
                      SizedBox(height: 10),
                      emailField,
                      SizedBox(height: 10),
                      passwordField,
                      SizedBox(height: 10),
                      confirmPasswordField,
                      SizedBox(height: 20),
                      signUpButton,
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Already Signed In? ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                  (route) => false);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // sign up authentication
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        postDetailsToFirestore();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "An account already exists for that email");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // sending details to database
  Future<void> postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = lastNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
