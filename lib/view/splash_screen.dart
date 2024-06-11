import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:kjbn_test/controller/controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFF293750),
      body: FutureBuilder(
          future: controller.gotoNext(context),
          builder: (context, snapshot) {
            return Center(
              child: AnimatedTextKit(repeatForever: true, animatedTexts: [
                // FadeAnimatedText('SECOND',
                //     textStyle: const TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 30)),
                FlickerAnimatedText('SECOND LUCK',
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ]),
            );
          }),
    );
  }
}
