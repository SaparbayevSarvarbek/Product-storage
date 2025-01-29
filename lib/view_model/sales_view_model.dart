import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/sales_model.dart';
import 'package:flutter_app/service/api_service.dart';

class SalesViewModel extends ChangeNotifier {
  void addSales(SalesModel salesModel) {
    ApiService().addSales(salesModel);
    notifyListeners();
  }
}
