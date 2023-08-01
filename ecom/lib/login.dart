

import 'package:ecom/homescreen.dart';
import 'package:ecom/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'utils.dart';
import 'text_button.dart';
import 'package:firebase_core/firebase_core.dart';
import '';
class login extends StatefulWidget {
  const login({super.key});



  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  bool loading=false;
  final auth=FirebaseAuth.instance;
  final formkey=GlobalKey<FormState>();
  final email=TextEditingController();
  final password=TextEditingController();
  void login()
  {setState(() {
    loading =true;
  });
  auth.signInWithEmailAndPassword(email: email.text.toString(), password: password.text.toString()).then((value){
    utils().toastmessage(value.user!.email.toString());
    Navigator.push(context, MaterialPageRoute(builder:(context) => homescreen()));
    setState(() {
      loading =false;
    });
  }).onError((error, stackTrace){
    utils().toastmessage(error.toString());
    setState(() {
      loading =false;
    });
  }
  );
  }
  Widget build(BuildContext context) {


    return WillPopScope(           //to exit app
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,

        appBar: AppBar(backgroundColor: Color(0xffF5F9FD),
        title: Text('e-Shop',style: TextStyle(fontFamily: 'Bold',color: Color(0xff0C54BE)),),
      ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                      decoration: InputDecoration(border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),

                          hintText: 'Email',hintStyle: TextStyle(fontFamily: 'Medium')
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
                        hintText: 'Password',hintStyle: TextStyle(fontFamily: 'Medium')



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
                ), SizedBox(height: 340,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:   roundbutton(title:'Login',
                      loading: loading,

                      ontap: () {
                        if (formkey.currentState!.validate()) {
                          login();
                        }

                      }

                  ),
                ),


                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New here?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                    }, child: Text('Signup',style: TextStyle(color: Color(0xff0C54BE),fontFamily: 'Bold'),))
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
