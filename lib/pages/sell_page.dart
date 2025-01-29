import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/product_model.dart';
import 'package:flutter_app/view_model/product_view_model.dart';
import 'package:flutter_app/view_model/sales_view_model.dart';
import 'package:provider/provider.dart';

import '../models/sales_model.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key});

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  List<ProductModel> filteredWords = [];
  List<String> optomProductList = ["blok", "litr", "kg", "tonna"];

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  String mahsulotNomi = '';
  double mahsulotHajmi = 0; // Standart qiymat 0
  String? optomProduct;
  double narxi = 0; // Standart qiymat 0
  double umumiyNarxi = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<ProductViewModel>();

    print("Malumot: ${myProvider.product}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Sotish"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset : false,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 80,
                  margin:
                      EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Mahsulotni kiriting",
                      border: OutlineInputBorder(),
                    ),
                    controller: _controller,
                    onSaved: (value){
                      mahsulotNomi=value!;
                    },
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return "Mahsulot nomini kirting";
                      }
                      return null;
                    },
                  ),

                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _controller1,
                    decoration: InputDecoration(
                      labelText: 'Mahsulot hajmi',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mahsulot hajmini kiriting';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        mahsulotHajmi = double.tryParse(value)??0.0;
                      });
                    },
                    onSaved: (value) {
                      if (value != null) {
                        mahsulotHajmi = double.tryParse(value) ?? 0.0;
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black38,
                      )),
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<String>(
                      value: optomProduct,
                      hint: Text("Mahsulot o'lcham turini tanlang"),
                      isExpanded: true,
                      items: optomProductList.map((item) {
                        return DropdownMenuItem<String>(
                            value: item, child: Text(item));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          optomProduct = value!;
                        });
                      }),
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  margin: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: _controller2,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    decoration: InputDecoration(
                        labelText: "Narxi", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Narxini kiriting';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      narxi = double.tryParse(value!) ?? 0.0;
                    },
                    onChanged: (value) {
                      setState(() {
                        narxi = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                Text(
                  "Umumiy narxi: ${(mahsulotHajmi * narxi).toString()}",
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 40.0),
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          onPressed: () {
            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              if(optomProduct!=null || optomProduct!.isNotEmpty){
                SalesModel salesModul=SalesModel(productName: mahsulotNomi, quantity: mahsulotHajmi.toInt(), optomProduct: optomProduct!, price: narxi.toString(), totalPrice: (narxi*mahsulotHajmi).toInt() );
                context.read<SalesViewModel>().addSales(salesModul);
                print("Malumotlar $mahsulotNomi $mahsulotHajmi $optomProduct $narxi ${mahsulotHajmi*narxi}");
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Mahsulot o'lcham turi tanlanmagan"),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Text("Sotish",style: TextStyle(color: Colors.white,fontSize: 17.0),),
        ),
      ),
    );
  }
}
