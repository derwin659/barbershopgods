import 'package:barberia/reusable_widgets/reusable_widget.dart';
import 'package:barberia/screens/home.dart';
import 'package:barberia/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/Authent.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController= TextEditingController();
  TextEditingController _NameTextController= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          "Iniciar Session",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),

        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            hexStringToColor("130F0F"),
            hexStringToColor("0E6BAC"),
            hexStringToColor("130F0F")
          ],begin: Alignment.topCenter,end:Alignment.bottomCenter)
        ),
         child: SingleChildScrollView(child:Padding(
           padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
           child: Column(
             children:<Widget> [
               const SizedBox(
                 height: 20,
               ),
               reusableTextField("Ingrese Nombre y Apellido", Icons.person_outline, false, _NameTextController),
               const SizedBox(
                 height: 20,
               ),
               reusableTextField("Ingrese Correo", Icons.email, false, _emailTextController),
               const SizedBox(
                 height: 20,
               ),
               reusableTextField("Ingrese Clave", Icons.lock_outlined, true, _passwordTextController), const SizedBox(
                 height: 20,
               ),
               signInSignUpButton(context, false, (){
              Authent auth=new Authent();
              print(_emailTextController.text);
              print(_passwordTextController.text);
              print(_NameTextController.text);
              auth.createUserWithEmaillAndPassword( _emailTextController.text,  _passwordTextController.text,"https://www.coordinadora.com/wp-content/uploads/sidebar_usuario-corporativo.png",_NameTextController.text,false).then((value){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen1()));
                 } ).onError((error, stackTrace) {
                   print("ERROR  ${error.toString()}");
                 });

               })
               
             ],
           ),
         )),
      ),
    );
  }
}

