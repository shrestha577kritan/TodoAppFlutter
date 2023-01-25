import 'package:classapp/view/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';


// f62d3f8fae031db2e4806d472bba4157
// f62d3f8fae031db2e4806d472bba4157

Future<String> delaysome() async {
  return Future.delayed(Duration(seconds: 1), () {
    return 'hellow';
  });
}

 Future<String> dely() async{
  return Future.delayed(Duration(seconds: 1), () {
    return 'hello';
  });
}

void main() async {
  final m = await delaysome();
  print(m);

  

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 33, 56, 77),
      ),
      home: Home(),
    );
  }
}
