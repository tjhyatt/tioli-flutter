import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> createUserWithEmailAndPassword(String name, String email, String password);
  Future<FirebaseUser> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  @override
  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    FirebaseUser user = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  @override
  Future<FirebaseUser> createUserWithEmailAndPassword(String name, String email, String password) async {
    FirebaseUser newUser;
    firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((user) {
      UserUpdateInfo updateUser = UserUpdateInfo();
      updateUser.displayName = name;
      user.updateProfile(updateUser).then((updatedUser) {
        newUser = user;
        return newUser;
      }).catchError((onError) {
        print('Error: ' + onError);
      });
    });

    return newUser;
    
  }

  @override
  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await firebaseAuth.currentUser();
    return user;
  }

  @override
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }
}