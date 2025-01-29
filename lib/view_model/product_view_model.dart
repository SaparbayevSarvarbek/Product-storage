import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/product_model.dart';
import 'package:flutter_app/service/api_service.dart';

class ProductViewModel extends ChangeNotifier{
   List product=[];
   bool isLoading=false;

   void getAllProduct() async{
     isLoading=true;
     notifyListeners();
     try{
       product=await ApiService().getAllProduct();
     }finally{
      isLoading=false;
      notifyListeners();
     }
   }
   void addProduct(ProductModel product,File image) async {
     ApiService().addProduct(product,image);
     notifyListeners();
   }
   void changeLoadingState(){
     isLoading=!isLoading;
     notifyListeners();
   }
   void updateProduct(ProductModel product)async{
     ApiService().updateProduct(product);
     notifyListeners();
   }
}