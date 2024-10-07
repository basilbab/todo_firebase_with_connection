import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_firebase_with_connection/domain/user_model.dart';

Future<void> registerUser(UserModel user) async {
  try {
    final userAuth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.userEmail, password: user.userPassword);
    if (userAuth != null) {
      addUser(userAuth.user!.uid, user);
    }
  } catch (_) {}
}

Future<void> addUser(String userId, UserModel user) async {
  try {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(userId).set({
      'name': user.userName,
      'email': user.userEmail,
      'mobile': user.userMobile,
      'address': user.userAddress
    });
  } catch (_) {}
}
