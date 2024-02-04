// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:iot_app_using_firebase/ui/auth_screen/login_screen.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<WelcomeScreen> {
//   final auth=FirebaseAuth.instance;
//   final user= auth.currentUser;
//   if(user !=null)
//
//   @override
//   void initState() {
//     super.initState();
//     _navigateToNextScreen(); // Initiate navigation after a delay
//   }
//
//   void _navigateToNextScreen() async {
//     await Future.delayed(const Duration(seconds: 3)); // Adjust duration as needed
//     //Navigator.pushReplacementNamed(context, '/home'); // Replace with your next screen route
//     Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, // Adjust background color
//       body: Center(
//         child: Image.asset('assets/images/master_bedroom.jpg'), // Replace with your logo or image
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';


import '../../firebase_services/firebase_services.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(
         child: Image.asset('assets/images/master_bedroom.jpg')
      ),
    );
  }
}