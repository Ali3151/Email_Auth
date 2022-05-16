import 'package:email_auth/pages/login.dart';
import 'package:email_auth/pages/users/user_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var email ="";
  var password = "";
  var confirmPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final confirmContoller = TextEditingController();
  registration()async{
    if(password ==confirmPassword){
      try {
        
       UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, 
          password: password
          );
          print(userCredential);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Registerario Successfully. Logged In..',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
              )
              ), 
          );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
      }on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('password provided is too weak.',
              style: TextStyle(
               fontSize: 18.0,
                color: Colors.black
              ),
              )
              ), 
          );
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
    ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('The account already exists for that email.',
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
    else{
      print('password and confrim doesn\'t match');
      ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text('password and confrim doesn\'t match',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),
              )
              ), 
          );
    }

  }

  @override
  void dispose(){
    emailContoller.dispose();
    passwordContoller.dispose();
    confirmContoller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User SingUp',style: TextStyle(
        color: Colors.white,
         letterSpacing: 2.0,
       fontFamily:'PlayfairDisplay-Italic-VariableFont_wght',
        fontWeight: FontWeight.bold
      ),),
     // backgroundColor: Colors.deepPurple,
      centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autocorrect:false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent,fontSize: 15,
                    )
                  ),
                  controller: emailContoller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter Email';
                    }
                    else if(!value.contains('@gmail.com')){
                      return 'please Eneter Valid Email';

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
                    labelText: 'Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: passwordContoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
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
                    labelText: 'Confirm Password: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: confirmContoller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            email = emailContoller.text;
                            password = passwordContoller.text;
                            confirmPassword = confirmContoller.text;
                          });
                          registration();
                         
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18.0,color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
               Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account? ",style: TextStyle(
                     
                      fontSize: 15
                    ),),
                    TextButton(
                        onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          Login(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                              )
                            },
                        child: Text('Login',style: TextStyle(
                     
                      fontSize: 15)
                      )
                      )
                  ],
                ),
              )
            ],
          ),
        )
        ),
      
    );
  }
}