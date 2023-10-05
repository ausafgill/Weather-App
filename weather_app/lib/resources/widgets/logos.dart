import 'package:flutter/material.dart';
import 'package:weather_app/resources/firebaseresources/google_auth.dart';

class Logos extends StatelessWidget {
  const Logos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: () {
              GoogleAuth().signInwithGoogle(context);
            },
            child: Image.asset('assets/images/GoogleIcon.png')),
        // SizedBox(
        //   width: 20,
        // ),
        Image.asset('assets/images/FacebookIcon.png'),

        Image.asset('assets/images/Group.png'),
      ],
    );
  }
}
