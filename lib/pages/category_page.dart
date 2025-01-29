
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/add_category_page.dart';
import 'package:flutter_app/view_model/category_view_model.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryViewModel>().getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kategoriya",
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Consumer<CategoryViewModel>(
            builder: (context, myProvider, child) {
              if (myProvider.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
               }
              if (myProvider.category.isNotEmpty) {
                return ListView.builder(
                  itemCount: myProvider.category.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 3),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        child: Row(children: [
                          Container(
                              width: 60,
                              height: 60,
                              margin: EdgeInsets.all(10.0),
                              child: myProvider.category[index].image == null
                                  ? Image.asset('assets/image/img.png',fit: BoxFit.fill,)
                                  : Image.network(
                                      myProvider.category[index].image,
                                      fit: BoxFit.fill,
                                    )),
                          Text(
                            myProvider.category[index].name,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ]),
                      ),
                    );
                  },
                );
              }
              else {
                return Center(
                  child: Text("Hech qanday kateogriya yo'q"),
                );
              }
            },
          ),
          Positioned(
            bottom: 50.0,
            right: 20.0,
            child: FloatingActionButton(
              backgroundColor: Colors.indigo,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddCategoryPage(categoryList: context.read<CategoryViewModel>().category,))).then((value){
                  setState(() {
                    context.read<CategoryViewModel>().getAllCategory();
                  });
                });
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
