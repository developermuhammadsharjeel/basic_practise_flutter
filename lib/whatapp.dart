import 'package:flutter/material.dart';

void main()=>runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("just practise")),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:
            BoxDecoration(
              color: Colors.grey,
            ),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
