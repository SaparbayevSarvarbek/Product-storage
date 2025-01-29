import 'package:flutter/material.dart';
import 'package:flutter_app/pages/category_page.dart';
import 'package:flutter_app/pages/product_page.dart';
import 'package:flutter_app/pages/sell_page.dart';
import 'package:flutter_app/pages/statistics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Asosiy sahifa"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.0,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Kategoriya",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      )),
                ),
              ),
            ),
            Container(
              height: 60.0,
              width: double.infinity,
              margin: EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage()));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Mahsulot",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      )),
                ),
              ),
            ),Container(
              height: 60.0,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SellPage()));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Sotish",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      )),
                ),
              ),
            ),
            Container(
              height: 60.0,
              width: double.infinity,
              margin: EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StatisticsPage()));
                },
                child: Card(
                  elevation: 10,
                  color: Colors.indigo,
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Statistika",
                        style: TextStyle(color: Colors.white, fontSize: 17.0),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
