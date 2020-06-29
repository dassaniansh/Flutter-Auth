import 'package:Auth/views/Signup.dart';
import 'package:Auth/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GoogleSignIn googleAuth = GoogleSignIn(scopes: ['email']);
  FacebookLogin facebookLogin = FacebookLogin();

  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextEditingController.text,
          password: passwordTextEditingController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      print(e);
    }
  }

  signInwithGoogle() async {
    try {
      await googleAuth.signIn();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInwithFacebook() async {
    var result = await facebookLogin.logIn(['email']);
    if (result.status == FacebookLoginStatus.loggedIn) {
      final AuthCredential credential = FacebookAuthProvider.getCredential(
        accessToken: result.accessToken.token,
      );
      final FirebaseUser user =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('Login',
                    style:
                        TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
                Text('Welcome back',
                    style: TextStyle(
                      fontSize: 30.0,
                      // fontWeight: FontWeight.bold
                    )),
                // SizedBox(height: 20.0),
                Text('please login',
                    style: TextStyle(
                      fontSize: 30.0,
                      // fontWeight: FontWeight.bold
                    )),
                // SizedBox(height: 20.0),
                Text('to your account',
                    style: TextStyle(
                      fontSize: 30.0,
                      // fontWeight: FontWeight.bold
                    )),
                SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      TextFormField(
                          obscureText: true,
                          validator: (val) {
                            return val.length < 4
                                ? "This will never work"
                                : null;
                          },
                          controller: passwordTextEditingController,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(),
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          signIn();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 50,
                          height: 50,
                          // padding: EdgeInsets.symmetric(vertical: 20,),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      Divider(
                        height: 50.0,
                        indent: 50.0,
                        endIndent: 50.0,
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              signInwithGoogle();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "images/google.png",
                                    height: 30.0,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Google",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              signInwithFacebook();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset(
                                    "images/facebook.png",
                                    height: 25.0,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Facebook",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 80.0,
                          ),
                          Text(
                            'Dont have account ',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
