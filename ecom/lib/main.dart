import 'package:ecom/homescreen.dart';
import 'package:ecom/login.dart';
import 'package:ecom/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',


      home: islogin()?homescreen():login(),
    );
  }
  bool islogin()
  {final auth=FirebaseAuth.instance;
  final user=auth.currentUser;
  if(user==null)
  {
    return true;

  }
  else
  {
    return false;
  }
  }
}



