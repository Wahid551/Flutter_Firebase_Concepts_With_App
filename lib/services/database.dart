import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_coffe/models/Brew.dart';
import 'package:flutter_firebase_coffe/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference coffeeCollection =
      Firestore.instance.collection('Coffee');

  Future updateUserData(String sugars, String name, String strength) async {
    return await coffeeCollection.doc(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'].toString(),
        sugars: snapshot.data()['sugars'].toString(),
        strength: snapshot.data()['strength'].toString());
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      //print(doc.data);
      return Brew(
        name: doc.data()['name'].toString() ?? '',
        strength: doc.data()['strength'].toString() ?? 0,
        sugars: doc.data()['sugars'].toString() ?? '0',
      );
    }).toList();
  }

  // get coffee collection snapshot
  Stream<List<Brew>> get coffee {
    return coffeeCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return coffeeCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
