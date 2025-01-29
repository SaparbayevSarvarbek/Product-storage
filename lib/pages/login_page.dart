import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dasturga xush kelibsiz",style: TextStyle(fontSize: 26),),
                  SizedBox(height: 50,),
                  Form(
                    key: _formKey1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _controller1,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username kiriting";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _controller2,
                          decoration: InputDecoration(
                              labelText: 'Parol', border: OutlineInputBorder()),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Parolni kiriting';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style:
                            ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                            onPressed: () {
                              if (_formKey1.currentState!.validate()) {
                                if (_controller1.text == 'admin' &&
                                    _controller2.text == '1234') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()));
                                }
                              }
                            },
                            child: Text(
                              'Kirish',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}
