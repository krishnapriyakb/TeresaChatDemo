import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class APIs {
  //for firebase authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  //for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}
