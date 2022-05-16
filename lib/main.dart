import 'package:email_auth/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp()
   
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp>  _initialization =Firebase.initializeApp();
    return FutureBuilder(future: _initialization, 
    builder:(context,snapchot){
      //check for errors
      if(snapchot.hasError){
        print('something Went Wrong');
      }
      if(snapchot.connectionState ==ConnectionState.waiting){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eamil Authentication',
      theme: ThemeData(
        
        
        
        primarySwatch: Colors.cyan,
      ),
      home: Login(),
    );

    }
    );
    
    
  }
}

