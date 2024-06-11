import 'package:flutter/material.dart';

class NumberCardWidget extends StatelessWidget {
  final String title;
  final String number;
  const NumberCardWidget(
      {required this.title, required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        height: size.height * 0.13,
        width: size.width / 2.5,
        decoration: BoxDecoration(
            // color: Colors.grey,
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF34425D), Color.fromARGB(126, 41, 55, 80)],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              width: size.width / 2.5,
              height: size.height * 0.05,
              decoration: const BoxDecoration(
                  color: Color(0xFF34425D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.height * 0.03),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
