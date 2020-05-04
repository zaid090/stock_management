
import 'package:cloud_firestore/cloud_firestore.dart';

class Supplement{
  String id;
  String BrandName;
  String Amount;
  String category;
  String ExpDate;
  Timestamp createdAt;
  int Quantity;

  Supplement();


  Supplement.fromMap(Map<String,dynamic> data){
    id = data['id'];
    BrandName = data['BrandName'];
    Amount = data['Amount'];
    category = data['category'];
    ExpDate = data['ExpDate'];
    createdAt = data['createdAt'];
    Quantity = data['Quantity'];
  }
  Map<String,dynamic> toMap(){
    return {
      'BrandName' : BrandName,
      'id' : id,
      'Amount' : Amount,
      'category' : category,
      'ExpDate' : ExpDate,
      'createdAt' : createdAt,
      'Quantity' : Quantity,

    };
  }
}