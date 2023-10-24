import 'package:flutter/cupertino.dart';

class CartQuantity extends ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;

  void setQuantity(int quantity) {
    
    _quantity = quantity;
    notifyListeners();
  }
}