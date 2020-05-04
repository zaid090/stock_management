

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stock_management/models/sellers.dart';
import 'package:stock_management/models/supplement.dart';
import 'package:stock_management/models/user.dart';
import 'package:stock_management/services/firebase_auth.dart';
import 'package:stock_management/services/supplementNotifier.dart';

login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.mail, password: user.password)
      .catchError((error) => print(error));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}

signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: user.mail, password: user.password)
      .catchError((error) => print(error));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.name;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance.signOut().catchError((error) => print(error));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getSupplements(SupplementNotifier supplementNotifier)async{
  QuerySnapshot  snapshot = await Firestore.instance.collection('supplements').getDocuments();

  List<Supplement> _supplementList = [];

  snapshot.documents.forEach((element) {
    Supplement supplement = Supplement.fromMap(element.data);
     _supplementList.add(supplement);

  });

  supplementNotifier.supplementList = _supplementList;

}

uploadSupplements(Supplement supplement,Function supplementUploaded) async {
  CollectionReference SupplementRef = await Firestore.instance.collection('supplements');
  
  supplement.createdAt = Timestamp.now();
  
  DocumentReference documentRef = await SupplementRef.add(supplement.toMap());
  supplement.id = documentRef.documentID;
  print('Uploaded food successfully');
  await documentRef.setData(supplement.toMap(),merge: true);
  supplementUploaded(supplement);
  
}

sellSupplement(Supplement supplement,Function supplementDeleted,Function supplementSold) async {
  int val = supplement.Quantity - 1;
  supplement.Quantity = val;



  supplement.Quantity == 0 ? await Firestore.instance.collection('supplements').document(supplement.id).delete() : await Firestore.instance.collection('supplements').document(supplement.id).updateData(supplement.toMap());
  supplement.Quantity == 0 ? supplementDeleted(supplement) : supplementSold(supplement,val);




}


uploadSeller(Seller seller) async {
  CollectionReference SellerRef = await Firestore.instance.collection('Seller');



  DocumentReference documentRef = await SellerRef.add(seller.toMap());
  seller.id = documentRef.documentID;
  print('Uploaded food successfully');
  await documentRef.setData(seller.toMap(),merge: true);


}
