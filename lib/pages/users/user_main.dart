
import 'package:email_auth/pages/login.dart';
import 'package:email_auth/pages/users/change_password.dart';
import 'package:email_auth/pages/users/dashboard.dart';
import 'package:email_auth/pages/users/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class userMain extends StatefulWidget {

  @override
  State<userMain> createState() => _userMainState();
}

class _userMainState extends State<userMain> {
  int _selectIndex = 0;
  static List<Widget> _widgetOption = <Widget>[
     Dashboard(),
    Profile(),
    changePassword(),
  ];
  void _onItemTapped(int index){
    setState(() {
      _selectIndex =index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome User',style: TextStyle(
               fontFamily:'PlayfairDisplay-Italic-VariableFont_wght',
               fontWeight: FontWeight.bold,
               letterSpacing: 2.0,
              color:Colors.white),
            ),
            ElevatedButton(onPressed: () async =>{
              await FirebaseAuth.instance.signOut(),
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context)=>Login()
                ),
               (route) => false)

            }
            , child: Text('Logout',style: TextStyle(
              color:Colors.white
            ),),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            )
          ],
        
        ),
        centerTitle: true,
      ),
      body: _widgetOption.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(     
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(
          backgroundColor: Colors.cyan,
            icon:Icon(Icons.home),
            label: 'Dashboard'
             ),
              BottomNavigationBarItem(
              backgroundColor: Colors.green,
            icon:Icon(Icons.person),
            label: 'Profile'
             ),
              BottomNavigationBarItem(
                backgroundColor: Colors.blue,
            icon:Icon(Icons.settings),
            label: 'Change Password'
             ),
        ],
       
        type: BottomNavigationBarType.shifting,
        iconSize: 30,
        elevation: 5,     
        currentIndex: _selectIndex,
        selectedItemColor: Color.fromARGB(255, 247, 6, 18),
      
        onTap: _onItemTapped,
        ),
    
        
      

    );
  }
}