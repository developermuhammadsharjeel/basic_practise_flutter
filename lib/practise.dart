import 'package:flutter/material.dart';

void main()=> runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApps(),
  ),
);

class MyApps extends StatefulWidget {
  const MyApps({super.key});

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
       leading: Icon(Icons.add_business),
       title: Center(
         child: Text('Layout Practise', style: TextStyle(
           fontWeight: FontWeight.bold,
           color: Colors.black,
           fontSize: 27,
         ),),
       ),
      ),

      body:
    );
  }
}


// Center(
//
// child: SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.black),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.grey),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.purple),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.green),
// height: 200,
// width: 200,
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.black),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.grey),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.purple),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.green),
// height: 200,
// width: 200,
// ),
// ),
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// decoration: BoxDecoration( color: Colors.lightBlue),
// height: 200,
// width: 200,
// ),
// ),
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// InkWell(
// onDoubleTap: (){
// print("Double Tap");
// },
// onTap: (){
// print("Tap");
// },
// onLongPress: (){
// print("Long Press");
// },
// child: Text("Sample")),
// Text("Sample"),
// ],
// ),
//
// ],
// ),
// ),
// ),
//.......................................................
//..... Button Comments
// child: TextButton(
//   child: Text("Click ME"),
//   onPressed: (){
//     print("Text Button Pressed");
//   },
//   onLongPress: (){
//     print("Text Button Long Pressed");
//   },
// ),
//
// this is an elevated button below is text button
// child: ElevatedButton(
//   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
//   onPressed:(){print("Elevated Button Pressed");},
//   child: Text('This is an elevated button', style: TextStyle(color: Colors.black),),),
//

//....... this is an outline button
// child: OutlinedButton(onPressed: (){print("Button Pressed");},
//     child: Text("Click ME!")),



//................ Add images
// Container(
//   decoration:  BoxDecoration(
//     image: DecorationImage(
//       image: AssetImage("assets/images/two.jpeg"),
//       fit: BoxFit.cover,
//     ),
//   ),
// )
//................................................................ Center(
//   child: Container(
//     width: 300,
//     height: 700,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: Colors.lightBlue,
//       border: Border.all(
//         color: Colors.black,
//         width: 4,
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               hintText: "Enter Your Name",
//               labelText: "Name",),
//           ),
//         ),
//
//       ],
//     ),
//   ),
// )

// body:
// Padding(
// padding: const EdgeInsets.all(23.0),
// child: Center(
// child: ListView.builder(itemBuilder: (context, index){
//
// return Text(arrNames[index],style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black, fontSize: 27,));
// },
// itemCount: arrNames.length,
// scrollDirection: Axis.vertical,
// itemExtent: 50,
//
// ),
// ),
// )

// var arrNames = ["Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad","Ali","Hammad"];
// ListView.separated(itemBuilder: (context, index) {
// return Text(arrNames[index], style: TextStyle(
// fontWeight: FontWeight.bold, color: Colors.black, fontSize: 27),);
// },
// separatorBuilder: (context, index) {
// return Divider(height: 20, thickness: 5,);
// },
// itemCount: arrNames.length)



//Expnaded concept.....
// Expanded(
// flex: 3,
// child: Container(
// width: 300,
// height: 100,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// border: Border.all(
// color: Colors.black,
// width: 4,
// ),
// color: Colors.green,
// boxShadow: [BoxShadow(blurRadius: 30)],
// ),
// ),
// ),

// Padding
// Center(

// child: Container(
// margin: EdgeInsets.all(10),
// width: 200,
// height: 150,
// decoration: BoxDecoration(
// color: Colors.purple,
// ),
// child: Center(
//
// child: Padding(
// padding: const EdgeInsets.only(top: 100, left: 20),
// child: Text("Just Sample", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize: 27),),
// )
// ),
// ),
// )
