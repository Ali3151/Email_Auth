import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
 
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   final uid = FirebaseAuth.instance.currentUser!.uid;
   final email = FirebaseAuth.instance.currentUser!.email;
   final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
   User? user = FirebaseAuth.instance.currentUser;
    verifyEmail()async{
      if(user !=null && !user!.emailVerified){
      await user!.sendEmailVerification();
      print('Verfication Eamil Has been Sent To You!');

      }
       ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text('Verfication Eamil Has been Sent To You!.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white
              ),
              )
            )
          );
    }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'User ID: $uid ',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                'Email: $email ',
                style: TextStyle(fontSize: 18.0),
              ),
              user!.emailVerified 
              ?Text('Verified', style: TextStyle(fontSize: 18.0,)) 
              :TextButton(onPressed: ()=>{
                verifyEmail()

              }, 
              child: Text(
                      'verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                    )
              // user!.emailVerified
                   
                  
            ],
          ),
          Text(
            '$creationTime: ',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}