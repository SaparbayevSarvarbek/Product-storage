import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  List category = [];
  bool isLoading = false;

  void getAllCategory() async {
    isLoading = true;
    notifyListeners();
    try {
      category = await ApiService().getAllCategory();
    }finally {
      isLoading = false;
      notifyListeners();
    }

  }

  void addData(String name, File image) async {
    ApiService().addCategory(name, image);
  }
}
