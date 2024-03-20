import 'package:chat/models/user_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  //for firebase authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static User get user => auth.currentUser!;

  //for checking if user exists or not?
  static Future<bool> userExists() async {
    return (await firestore
            .collection("Users")
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  //for creating new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatuser = UserModal(
      id: user.uid,
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: "hey there",
      image: user.photoURL.toString(),
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
    );
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(chatuser.toJson());
  }
}
