import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_coffe/models/Brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection Reference
  final CollectionReference coffeeCollection =
      Firestore.instance.collection('Coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection.doc(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
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
}
