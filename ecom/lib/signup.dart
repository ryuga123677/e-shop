import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/homescreen.dart';
import 'package:ecom/text_button.dart';
import 'package:ecom/utils.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login.dart';
class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  @override
  bool loading =false;
  final formkey=GlobalKey<FormState>();
  final auth=FirebaseAuth.instance;
  var email =TextEditingController();
  var password =TextEditingController();
  final ref=FirebaseFirestore.instance.collection('users');
  var name=TextEditingController();
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xffF5F9FD),
      appBar: AppBar(title: Text('e-Shop',style: TextStyle(color: Color(0xff0C54BE),fontFamily: 'Bold'),),backgroundColor: Color(0xffF5F9FD),),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: name,

                  decoration: InputDecoration(
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                      hintText: 'Name',hintStyle: TextStyle(fontFamily: 'Medium'),
                    fillColor: Colors.white
                  ),
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Enter name';
                    }
                    return null;
                  },

                ),
              ),
              Form(key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    decoration: InputDecoration(border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),

                        hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Medium'),
                        fillColor: Colors.white
                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Enter email';
                      }
                      return null;
                    },

                  ),
                ),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller:password,
                    obscureText:true ,
                    decoration: InputDecoration(border:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                      hintText: 'Password',hintStyle: TextStyle(fontFamily: 'Medium'), fillColor: Colors.white



                    ),
                    validator: (value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Enter password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 250,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:   roundbutton(title:'Sign up',
                  loading: loading,

                  ontap: (){
                    if(formkey.currentState!.validate())
                    {
                      setState(() {
                        loading =true;
                      });
                      auth.createUserWithEmailAndPassword(email: email.text.toString(), password: password.text.toString()).then((value)
                      {String time=DateTime.now().millisecondsSinceEpoch.toString();
                      ref.doc(time).set(
                          {
                            'name':name.text.toString(),
                            'email':email.text.toString(),


                          });

                      }).onError((error, stackTrace){
                        utils().toastmessage(error.toString());
                        setState(() {
                          loading =false;
                        });

                      });
                      Get.to(homescreen());
                   }
                  },

                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(fontFamily: 'Medium'),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                  }, child: Text('Login',style: TextStyle(fontFamily: 'Bold',color: Color(0xff0C54BE))))
                ],
              )



            ],
          ),
        ),
      ),
    );
  }
}
