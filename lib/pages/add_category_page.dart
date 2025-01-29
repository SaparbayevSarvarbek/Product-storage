import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/view_model/category_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatefulWidget {
  final List categoryList;

  AddCategoryPage({super.key, required this.categoryList});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _newCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategoriya qo\'shish'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 30, right: 16.0, left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _newCategory,
                    decoration: InputDecoration(
                      labelText: 'Kategori nomi',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: _pickImage,
                      child: _image == null
                          ? Card(
                              elevation: 5,
                              child: Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.indigo,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.indigo,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Rasmni tanlang"),
                                    ]),
                              ),
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
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: ElevatedButton(
              onPressed: () {
                if (_newCategory.text.isNotEmpty && _image != null) {
                  if (categoryCheck(_newCategory.text)) {
                    context
                        .read<CategoryViewModel>()
                        .addData(_newCategory.text, _image!);
                    Navigator.pop(context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Rasm yoki kategoriyani kiritmadingiz'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Qo\'shish',
                style: TextStyle(fontSize: 17.0),
              ),
            ),
          ),
        ],
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

  bool categoryCheck(String text) {
    for (int i = 0; i < widget.categoryList.length; i++) {
      if (widget.categoryList[i].name.toLowerCase().contains(text.toLowerCase())) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Bunday kategoriya bor'),));
        return false;
      }
    }
    return true;
  }
}
