import 'package:tcrwa_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection=Firestore.instance.collection('tcrwa_app');  // tcrwa_app connection as obj of firestore

  // create new record in brew collection for that user with prop of user as name,sugar,strength
  // for new user firestore create new unique id for all user based on that id we do all calculations



  // get user data snapshot
  UserData _userDataFormSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
    );
  }


  // get user doc stream

Stream <UserData>get userData{
    return userCollection.document(uid).snapshots()
    .map(_userDataFormSnapshot);

  }

}