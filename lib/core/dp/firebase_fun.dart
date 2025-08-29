import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/features/auth/models/user_model.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up
  Future<AppUser> signUp(String name, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = result.user!;

    AppUser appUser = AppUser(id: user.uid, name: name, email: email);

    try {
      await _firestore.collection('users').doc(user.uid).set(appUser.toJson());
      print("Data saved to Firestore for user ${user.uid}");
    } catch (e) {
      print(" Firestore error: $e");
    }

    return appUser;
  }

  //  Login
  Future<AppUser> login(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = result.user!;

    DocumentSnapshot doc = await _firestore
        .collection('users')
        .doc(user.uid)
        .get();

    return AppUser.fromJson(doc.data() as Map<String, dynamic>);
  }

  //  Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
