

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:stock_management/models/supplement.dart';

class SupplementNotifier with ChangeNotifier{
  List<Supplement> _supplementList = [];
  Supplement _currentSupplement;

  UnmodifiableListView<Supplement> get supplementList => UnmodifiableListView(_supplementList);

  Supplement get currentSupplement => _currentSupplement;

  set supplementList(List<Supplement> supplementList){
    _supplementList = supplementList;
    notifyListeners();
  }

  set currentSupplement(Supplement supplement){
    _currentSupplement = supplement;
  }

  addSupplement(Supplement supplement){
    _supplementList.insert(0, supplement);
    notifyListeners();
  }

  deleteSupplement(Supplement supplement){
    _supplementList.removeWhere((_supplement) => _supplement.id == supplement.id);
    notifyListeners();
  }

  supplementSold(Supplement supplement,int val){
    _currentSupplement.Quantity = val;
    notifyListeners();
  }



}