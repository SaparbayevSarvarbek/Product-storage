import 'package:flutter/material.dart';
import 'package:flutter_app/view_model/product_view_model.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../view_model/category_view_model.dart';

class ProductUpdatePage extends StatefulWidget {
  ProductModel product;

  ProductUpdatePage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductUpdatePage> createState() => _ProductUpdatePageState();
}

class _ProductUpdatePageState extends State<ProductUpdatePage> {
  List<String> list = ["blok", "litr", 'kg', 'tonna'];
  List<String> list1 = ['Kategoriya yo\'q'];
  final _fromKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _soniController = TextEditingController();
  final TextEditingController _buyController = TextEditingController();
  final TextEditingController _sellController = TextEditingController();
  String? optomProductSelected;
  String? categorySelected;
  int categoryId=0;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    context.read<CategoryViewModel>().getAllCategory();
    _nameController.text = widget.product.name;
    _soniController.text = widget.product.soni.toString();
    _buyController.text = widget.product.buy.toString();
    _sellController.text = widget.product.sell.toString();
    optomProductSelected = widget.product.optomProduct;
    imageUrl = widget.product.image;
    categoryId=widget.product.id;
    // categoryById(widget.product.category, context.read<CategoryViewModel>().category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mahsulotlar haqida'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
                key: _fromKey,
                child: Container(
                  margin: EdgeInsets.only(top: 15, right: 16, left: 16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            labelText: 'Mahsulot nomi',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mahsulot nomi kiriting';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: Colors.black54),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Consumer<CategoryViewModel>(
                          builder: (context, myProvider, child) {
                            categoryById(widget.product.category, myProvider.category);
                            final items = myProvider.category.isNotEmpty
                                ? myProvider.category
                                    .map((item) => item.name)
                                    .toSet()
                                    .toList()
                                : list1.toSet().toList();
                            if (!items.contains(categorySelected)) {
                              categorySelected = null;
                              // categoryById(widget.product.category, list);
                              print("Kategoriya $categorySelected");
                            }
                            if (myProvider.category.isNotEmpty) {
                              return DropdownButton<String>(
                                value: categorySelected,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                hint: Text(
                                  'Kategoriya tanlanmagan',
                                ),
                                items: myProvider.category.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.name,
                                    child: Text(item.name),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    categorySelected = newValue;
                                    selectedCategoryByName(newValue!, myProvider.category);
                                  });
                                },
                                isExpanded: true,
                              );
                            } else {
                              return DropdownButton<String>(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 10.0),
                                hint: const Text(
                                  'Kategoriyani tanlang',
                                ),
                                value: categorySelected,
                                items: list1.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    categorySelected = newValue;
                                  });
                                },
                                isExpanded: true,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.indigo, width: 1.5),
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _buyController,
                        decoration: InputDecoration(
                            labelText: 'Sotib olingan narx',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sotib olingan narxni kiriting';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _sellController,
                        decoration: InputDecoration(
                            labelText: 'Sotiladigan narx',
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sotiladigan narxni kiriting';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: _soniController,
                          decoration: InputDecoration(
                              labelText: 'Mahsulot soni',
                              border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mahsulotni sonini kiriting';
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid, color: Colors.black54),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                            hint: Text("Turini tanlang"),
                            value: list.contains(optomProductSelected)
                                ? optomProductSelected
                                : null,
                            isExpanded: true,
                            items: list.map((item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (newItem) {
                              setState(() {
                                optomProductSelected = newItem!;
                              });
                            }),
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo),
                            onPressed: () {
                              if(_fromKey.currentState!.validate()){
                                ProductModel product=ProductModel(id: widget.product.id, name: _nameController.text, soni: int.parse(_soniController.text), image: widget.product.image, optomProduct: optomProductSelected!, buy: int.parse(_buyController.text), sell:  int.parse(_sellController.text), category: categoryId);
                                 context.read<ProductViewModel>().updateProduct(product);
                              }
                            },
                            child: Text('Yangilash',style: TextStyle(color: Colors.white,fontSize: 18),)),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
  void categoryById(int id,List list){
    for(int i=0;i<list.length;i++){
      if(list[i].id==id){
        categorySelected=list[i].name;
      }
    }
  }
  void selectedCategoryByName(String name,List categoryList1){
    for(int i=0;i<categoryList1.length;i++){
      if(categoryList1[i].name==name){
        categoryId=categoryList1[i].id;
      }
    }
  }
}
