import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/product_model.dart';
import 'package:flutter_app/view_model/category_view_model.dart';
import 'package:flutter_app/view_model/product_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final List productList;

  AddProductPage({super.key, required this.productList});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<String> list = ["blok", "litr", 'kg', 'tonna'];
  List<String> list1 = ["Kategory yo'q"];
  String? selectedItem;
  String? categorySelected;
  int categoryId = 0;

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  String _mahsulotNomi = '';
  String _olinganNarx = '';
  String _sotiladiganNarx = '';
  String _miqdori = '';

  @override
  void initState() {
    super.initState();
    context.read<CategoryViewModel>().getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text("Mahsulot qo'shish"),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Consumer<CategoryViewModel>(
                  builder: (context, myProvider, child) {
                    if (myProvider.category.isNotEmpty) {
                      return DropdownButton<String>(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 10.0),
                        hint: Text(
                          'Kategoriyani tanlang',
                        ),
                        value: categorySelected,
                        items: myProvider.category.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            categorySelected = newValue;
                            categoryFindId(myProvider.category,categorySelected!);
                            print("Kategoriya IDsi $categoryId");
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
                height: 20,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 80,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Mahsulot nomi',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mahsulot nomi kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _mahsulotNomi = value!;
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Olingan narx',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Olingan narxni kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _olinganNarx = value!;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 80,
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Sotiladigan narx',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sotiladigan narxni kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _sotiladiganNarx = value!;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      )
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Form(
                        key: _formKey2,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Soni',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 10.0)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sonini kiriting';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _miqdori = value!;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    flex: 3,
                    child: DropdownButton<String>(
                        hint: Text("Turini tanlang"),
                        value: selectedItem,
                        isExpanded: true,
                        items: list.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (newItem) {
                          setState(() {
                            selectedItem = newItem!;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Card(
                          elevation: 5,
                          child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.indigo, width: 1.5),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      size: 30,
                                      color: Colors.indigo,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Rasmni tanlash"),
                                  ])),
                        )
                      : Column(
                          children: [
                            Card(
                              elevation: 5,
                              child: Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.indigo, width: 1.5),
                                ),
                                child: Image.file(
                                  File(_image!.path),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rasm o\'zgartirish uchun yena bir marta bosing',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 20),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  _formKey2.currentState!.validate()) {
                _formKey.currentState!.save();
                _formKey2.currentState!.save();
                if (selectedItem != null &&
                    categorySelected != null &&
                    _image != null) {
                  if(checkProduct(_mahsulotNomi)){
                    ProductModel productModel = ProductModel(
                        id: 1,
                        name: _mahsulotNomi,
                        soni: int.parse(_miqdori),
                        image: _image.toString(),
                        optomProduct: selectedItem!,
                        buy: int.parse(_olinganNarx),
                        sell: int.parse(_sotiladiganNarx),
                        category: categoryId);
                    context
                        .read<ProductViewModel>()
                        .addProduct(productModel, _image!);
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Malumotlarni to\'liq kiriting'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              } else {}
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(
              "Saqlash",
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print("Hech qanday rasm tanlanmadi.");
    }
  }

  bool checkProduct(String text) {
    for (int i = 0; i < widget.productList.length; i++) {
      if (widget.productList[i].name.toLowerCase().contains(text.toLowerCase())) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bunday mahsulot nomi mavjud')));
        return false;
      }
    }
    return true;
  }
  Future<void> categoryFindId(List list,String category) async {
    for(int i=0;i<list.length;i++){
      if(list[i].name==category){
        categoryId=list[i].id;
      }
    }
  }
}
