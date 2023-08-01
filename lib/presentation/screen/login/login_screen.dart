import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:funds_management/presentation/router/router.gr.dart';

import '../../../firebase/FireStoreDataBase.dart';
import '../../../shared/share_preference_helper.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  static bool isLogin = false;
  static GlobalKey _formKey = GlobalKey<FormState>();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadEmail() async{
    final data = await SharePreferenceHelper.getEmail();
    FireStoreDataBase().getPermission(data);
  }

  Future loadData() async{
    final data = await SharePreferenceHelper.getIsLogin();
    setState(() {
      isLogin = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            if (isLogin){
              loadEmail();
              AutoRouter.of(context).push(MainHomePage());
            }
            return Scaffold(
              body: loginPage(context),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget loginPage(BuildContext context){
    final myControllerEmail = TextEditingController();
    final myControllerPassword = TextEditingController();

    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 25.0),),
              SizedBox(height: 15.0),
              TextFormField(
                autofocus: true,
                controller: myControllerEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                autocorrect: false,
                enableSuggestions: false,
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "Please enter Email";
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: myControllerPassword,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                      color: Colors.white
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey[800],
                  ),
                  labelText: 'Password',
                ),
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
                keyboardType: TextInputType.name,
                maxLines: 1,
                validator: (v) {
                  return v!.trim().isNotEmpty ? null : "Please Enter Password";
                },
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Login"),
                        ),
                        onPressed: () async{
                          if ((_formKey.currentState as FormState).validate()) {
                            User? user = await FireStoreDataBase.signInUsingEmailPassword(
                              email: myControllerEmail.text,
                              password: myControllerPassword.text,
                              context: context,
                            );
                            if (user != null) {
                              FireStoreDataBase().getPermission(myControllerEmail.text);
                              AutoRouter.of(context).push(MainHomePage());
                            } else {
                              showFlutterToast("Login Failed");
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showFlutterToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
    );
  }
}
