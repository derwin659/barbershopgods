import 'dart:developer';

import 'package:barberia/fcm/fcm_notification_handler.dart';
import 'package:barberia/main.dart';
import 'package:barberia/screens/home_screen.dart';
import 'package:barberia/screens/signup_screen.dart';
import 'package:barberia/services/Authent.dart';
import 'package:barberia/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../reusable_widgets/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      body:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        decoration:
          BoxDecoration(gradient: LinearGradient(colors: [
            hexStringToColor("0E6BAC"),
            hexStringToColor("0E6BAC"),
            hexStringToColor("0E6BAC")
          ],
          begin: Alignment.topCenter,end:Alignment.bottomCenter)),
        child:SingleChildScrollView(
            child:Padding(padding: const EdgeInsets.fromLTRB(
                20,120, 20, 0),
        child: Column(
          children: <Widget>[
           logoWidget('assets/images/logog.png'),
            const SizedBox(height: 30,),
            reusableTextField("Ingrese correo", Icons.person_outline, false, _emailTextController),
            const SizedBox(height: 20,),
            reusableTextField("Ingrese Contraseña", Icons.lock_outline, true,_passwordTextController),
            const SizedBox(height: 20,),
            signInSignUpButton(context,true,(){
              Authent auth =new Authent();
              print(_emailTextController.text);
              print(_passwordTextController.text);
              auth.loginWithEmailAndPassword(_emailTextController.text, _passwordTextController.text).then((value) {
                Navigator.push(context, MaterialPageRoute(builder:(context)=>  HomeScreen1()));
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });

            }),
            GoogleSignInButton(context,true,(){
              Authent auth =new Authent();
              auth.signInWithGoogle().then((user) {
                log(user.toString());

                if(user != null){

                  Navigator.push(context, MaterialPageRoute(builder:(context)=>  HomeScreen1()));
                }else{
                  log("loginScrees build ERROR user viene nulo");
                }

              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });

            })
          ,
            signUpOption()
          ],
        ),
            )

        )
      )
    );
  }

Row signUpOption(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿No tienes una cuenta?",style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
          },
          child: const Text(" Regístrate Aquí",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),)
        )
      ],
    );
}

  @override
  void initState(){
    //TODO: IMplementar initState
    super.initState();
    //get token,subscribe..etc here



  }





}

