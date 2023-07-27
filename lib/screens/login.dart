
import 'package:barberia/screens/home.dart';
import 'package:barberia/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/my_bg.png'),
                  fit: BoxFit.cover)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              SizedBox(height: 40),
              TextButton(
                onPressed: () => loguear(),
                child: const Text("Throw Test Exception"),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton.icon(
                  icon: const FaIcon(FontAwesomeIcons.google,color:Colors.red),
                  label: const Text('Logín con Gmail'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50)

                  ),

                  onPressed: () async {
                  await FirebaseServices().signnInWithGoogle();
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => const HomeScreen()));

                    //final provider= Provider.of<GoogleSignInProvider>(context,listen: false);
                    //provider.googleLogin();
                  },

                ),




              ),
              RichText(text: TextSpan(
                  text: 'Ya tienes una cuenta?',
                  children: [
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(decoration: TextDecoration.underline),
                    )
                  ]
              ))
            ],
          ),
        ));
  }

  loguear() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: 'derwinnieves659@gmail.com',
          password: 'derwin'
    );} on FirebaseAuthException catch (e) {  if (e.code == 'user-not-found') {    print('No user found for that email.');  } else if (e.code == 'wrong-password') {    print('Wrong password provided for that user.');  }}


  }

}
