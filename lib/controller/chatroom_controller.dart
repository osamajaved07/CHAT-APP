// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatroomService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMyChatrooms() async* {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      yield* Stream.empty(); // Handle case where user is not signed in
      return;
    }

    yield* FirebaseFirestore.instance
        .collection('chatrooms')
        .where('users', arrayContains: currentUser.uid)
        .snapshots();
  }
}
