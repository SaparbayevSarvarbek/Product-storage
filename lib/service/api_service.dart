import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/models/category_model.dart';
import 'package:flutter_app/models/product_model.dart';
import 'package:flutter_app/models/sales_model.dart';

class ApiService {
  Future getAllProduct() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('https://gedion.uz/api/product-list/');
      if (response.statusCode == 200) {
        List product = response.data
            .map((e) => ProductModel.fromJson(e))
            .toList()
            .cast<ProductModel>();
        return product;
      }
    } on SocketException {
      print("Internet bilan muommo");
    } catch (e) {
      print("getAllProduct xato ${e}");
    }
  }

  void addProduct(ProductModel product, File image) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'name': product.name,
        'soni': product.soni,
        'image': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
        'optom_product': product.optomProduct,
        'buy': product.buy,
        'sell': product.sell,
        'category': product.category
      });
      Response response =
          await dio.post('https://gedion.uz/api/product-create/',
              data: formData,
              options: Options(
                headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"},
              ));
    } catch (e) {
      print('add productda xatolik $e');
    }
  }

  Future getAllCategory() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('https://gedion.uz/api/category-list/');
      if (response.statusCode == 200) {
        List category =
            response.data.map((e) => CategoryModel.fromJson(e)).toList();
        return category;
      }
    } catch (e) {
      print('getAllCategory xatolik $e');
    }
  }

  void addCategory(String name, File image) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'name': name,
        'image': await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last),
      });
      Response response =
          await dio.post('https://gedion.uz/api/category-create/',
              data: formData,
              options: Options(
                headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"},
              ));
    } catch (e) {
      print("add categoryda xatolik $e");
    }
  }

  void addSales(SalesModel salesModel) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post('https://gedion.uz/api/sales-create/',
          data: salesModel.toJson(),
          options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
          ));
    } catch (e) {
      print('Add Salesda xatolik $e');
    }
  }

  void updateProduct(ProductModel product) async {
    String url = 'https://gedion.uz/api/product-update/${product.id}';
    print('json format ${product.id} \n ${product.toJson()}');
    try {
      FormData formData = FormData.fromMap({
        'name': product.name,
        'soni': product.soni,
        // 'image': await MultipartFile.fromFile(image.path,
        //     filename: image.path.split('/').last),
        'optom_product': product.optomProduct,
        'buy': product.buy,
        'sell': product.sell,
        'category': product.category
      });
      Dio dio = Dio();
      Response response =
          await dio.patch('https://gedion.uz/api/product-update/${product.id}',
              data: formData,
              options: Options(
                headers: {HttpHeaders.contentTypeHeader: "multipart/form-data"},
              ));
    } catch (e) {
      print('update productda xatolik ${e}');
    }
  }
}
