import 'package:flutter/material.dart';

class SeparationLine extends StatelessWidget {
  const SeparationLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(color: const Color.fromARGB(255, 7, 6, 6)),
        ),
        Text('OR'),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(color: Colors.black),
        ),
      ],
    );
  }
}
