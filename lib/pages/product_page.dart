import 'package:flutter/material.dart';
import 'package:flutter_app/pages/add_product_page.dart';
import 'package:flutter_app/pages/product_update_page.dart';
import 'package:flutter_app/view_model/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Mahsulotlar"),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Consumer<ProductViewModel>(
              builder: (context, myProvider, child) {
                if (myProvider.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (myProvider.product.isNotEmpty) {
                  return ListView.builder(
                      itemCount: myProvider.product.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductUpdatePage(
                                          product: myProvider.product[index]
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 5,
                            color: myProvider.product[index].soni <= 50
                                ? Colors.red
                                : Colors.green,
                            child: ListTile(
                              title: myProvider.product[index].name == null
                                  ? Text(
                                      "Mahsulot nomi yo'q",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  : Text(
                                      myProvider.product[index].name,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                              subtitle: Text(
                                (myProvider.product[index].soni).toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(child: const Text("Mahsulotlar yo'q"));
                }
              },
            ),
            Positioned(
              bottom: 50.0,
              right: 20.0,
              child: FloatingActionButton(
                backgroundColor: Colors.indigo,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProductPage(productList: context.read<ProductViewModel>().product,)));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ));
  }
}
