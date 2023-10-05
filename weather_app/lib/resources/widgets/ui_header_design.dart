import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIHeaderDesign extends StatelessWidget {
  const UIHeaderDesign({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('assets/images/UIHeaderDesign.png'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'signup_screen');
                },
                child: Text('SIGN UP',
                    style: GoogleFonts.ubuntu(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
