import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:voice_to_text/speech.dart';

class splach extends StatefulWidget {
  const splach({Key? key}) : super(key: key);

  @override
  State<splach> createState() => _splachState();
}

class _splachState extends State<splach> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'lib/images/top.svg',
              width: 500,
              height: screenHeight *3,
            ),
          ),
          Positioned(
            top:240,
            left: 15,
            child: Image.asset(
              'lib/images/195-removebg-preview.png',
              width: screenWidth * 1.2,
            ),
          ),
          Positioned(
        bottom: 100,
        left: 15,
        right: 15,
        child: ElevatedButton(
          onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SpeechScreen()),
    );
          },
          child: Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
  primary: Color(0xFF00cba9), // set the primary color of the button
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30.0),
  ),
  padding: EdgeInsets.symmetric(
    horizontal: 50.0,
    vertical: 20.0,
  ),
),
        ),
      ),

          
         
        ],
      ),
    );
  }
}
