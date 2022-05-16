
import 'package:email_auth/pages/forget.dart';
import 'package:email_auth/pages/signup.dart';
import 'package:email_auth/pages/users/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();

  var email ="";
  var password ="";

  final emailController = TextEditingController();
   final passwordController = TextEditingController();
   userLogin()async{
     try{
     UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email, 
       password: password
       );
        print(userCredential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('U Welcome Our Main Dashboard',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              ),
              )
            )
          );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>userMain()));
     }on FirebaseAuthException catch (e){
       if(e.code ==  'user-not-found'){
         print('No user found for that email.');
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('No user found for that email.',
              style: TextStyle(
               fontSize: 18.0,
                color: Colors.white
              ),
              )
              ), 
          );
       }else if(e.code == 'wrong-password'){
         print('Wrong password provided for that user.');
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text('Wrong password provided for that user.',
              style: TextStyle(
               fontSize: 18.0,
                color: Colors.black
              ),
              )
              ), 
          );

       }
     }
   }
  @override
  void dispose(){
    //clean up the conroller when the widget disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Login',style: TextStyle(
          color: Colors.white,
          fontFamily:'PlayfairDisplay-Italic-VariableFont_wght',
          fontWeight:FontWeight.bold,
          letterSpacing: 2.0,
         
        ),),
      ),
      body: Form(
        key: _formkey,
        child: Padding(padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 20.0),
                border: OutlineInputBorder(),
                errorStyle: TextStyle(
                  color: Colors.redAccent,fontSize: 15,
                )
              ),
              controller: emailController,
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Please Enter Email';
                }
                else if(!value.contains('@gmail.com')){
                  return 'Please Valid Eamil';

                }
                return null;
              },

            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                errorStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.redAccent
                )
              ),
              controller: passwordController,
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Please Enter Password';
                }
                return null;
              },
            ),
           
          ),
          Container(
            margin: EdgeInsets.only(left: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  if(_formkey.currentState!.validate()){
                    setState(() {
                      email= emailController.text;
                      password = passwordController.text;
                    }
                    
                    );
                    userLogin();
                   
                  }
                },
                 child: Text('Login',style: TextStyle(
                   fontSize: 18.0 ,
                   color: Colors.white,
                 )
                 )
                 ),
                 TextButton(onPressed: ()=>{
                   Navigator.push(context, MaterialPageRoute(
                     builder: (context)=> Forget()
                     )
                     )

                 }, 
                 child: Text('Forget Password',style: TextStyle(
                   fontSize: 14.0,
                   color: Colors.cyan),
                 )
                 )

              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Text('Don\t have an Acount?',),
                TextButton(onPressed: ()=>{
                  Navigator.pushAndRemoveUntil(context, 
                  PageRouteBuilder(
                    pageBuilder: (context, a,b)=>SignUp(),
                    ),
                   (route) => false)
                }, 
                child: Text('SingUp',style: TextStyle(
                  color: Colors.cyan
                ),)
                )
              ],
            ),
          )
          
        ],
        ),
        ),

      ),
      
    );
  }
}