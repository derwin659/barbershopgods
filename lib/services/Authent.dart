import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/database.dart';

class Authent {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static const String TAG = "LoginGoogle";
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User> getCurrentUser() async {
    return await auth.currentUser!;
  }

  Future<void> createUserWithEmaillAndPassword(String email,String password,String imgUrl,String name,bool isStaff) async {
    UserCredential userCredential= await auth.createUserWithEmailAndPassword(email: email, password: password);
    Map<String,dynamic> userInfoMap = {
      "email":email,
      "password":password,
      "name":name,
      "imgUrl":imgUrl,
      "isStaff":isStaff
    };

    if(userCredential != null){
      DatabaseMethods().addUserInfoToDB(auth.currentUser!.uid,userInfoMap);
    }

  }
  
  Future<void> loginWithEmailAndPassword(String email,String password) async {
    UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await auth.signOut();
  }

   Future<Future<User?>> signInWithGoogle() async {

      log(TAG + ", signInWithGoogle() init...");

 final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      log(TAG + ", signInWithGoogle() GOOGLEUSER EMAIL  -> ${googleSignInAccount?.email}.");

      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication!.accessToken,idToken: googleSignInAuthentication.idToken);

      UserCredential userCredential=await auth.signInWithCredential(credential);

      User? user = userCredential.user;

      return isCurrentSignIn(user!);

  }

  Future<User?> isCurrentSignIn(User user) async{
    if(user != null){
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = auth.currentUser;
      assert(user.uid == currentUser?.uid);

      log(TAG + ' signInWithGoogle() succeeded: $user');
      return user;

    }

    return null;

  }


}
