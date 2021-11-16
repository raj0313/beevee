import 'package:flutter/cupertino.dart';

class CounterModel extends ChangeNotifier{


  int _qty = 1;

  int get getQty => _qty;

  void incrementQty(){
  _qty++;

  notifyListeners();
  }


  void decreaseQty(){
    if(_qty == 0 )
      {
        return null;
      }
    else {
      _qty--;
    }
    notifyListeners();
  }
}