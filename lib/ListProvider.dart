import 'package:flutter/cupertino.dart';
import 'package:sql_lite/listView.dart';
import 'package:sql_lite/main.dart';

class ListProvider extends ChangeNotifier{

  List<String> text = [''];
  int length=0;

  void adding(String t){
    if(t!=null) text.insert(length, t);
    notifyListeners();
  }

  void remove(int index){
    text.removeAt(index);
    length--;
    notifyListeners();
  }
}