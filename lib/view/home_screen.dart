import 'package:flutter/material.dart';
import 'package:kjbn_test/controller/controller.dart';
import 'package:kjbn_test/widgets/number_card_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countController = Provider.of<Controller>(context, listen: false);
    final isRunning =
        countController.timer == null ? false : countController.timer!.isActive;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF293750),
      appBar: AppBar(
        backgroundColor: const Color(0xFF293750),
        title: const Text(
          'SECOND LUCK',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: countController.getData(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6C63FE),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<Controller>(
                          builder: (context, controller, _) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                NumberCardWidget(
                                  title: 'Current Second',
                                  number: controller.totalSeconds.toString(),
                                ),
                                NumberCardWidget(
                                  title: 'Random Number',
                                  number: controller.randomNumber.toString(),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Consumer<Controller>(
                          builder: (context, controller, child) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height * 0.2,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: controller.isStarted == false
                                          ? const Color(0xFF34425D)
                                          : controller.isTimeRunning
                                              ? const Color(0xFF34425D)
                                              : controller.totalSeconds ==
                                                      controller.randomNumber
                                                  ? const Color.fromARGB(
                                                      147, 76, 175, 79)
                                                  : const Color.fromARGB(
                                                      139, 255, 193, 7),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: controller.isStarted == false
                                          ? const Text(
                                              'Click the Button',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25),
                                            )
                                          : controller.isTimeRunning
                                              ? const Text(
                                                  'Checking...',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                )
                                              : controller.totalSeconds ==
                                                      controller.randomNumber
                                                  ? Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Success',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25),
                                                        ),
                                                        Text(
                                                          'Score : ${controller.success}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 25),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        const Text(
                                                          'Sorry try Again!',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25),
                                                        ),
                                                        Text(
                                                          'Attempts : ${controller.totalAttempts}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 25),
                                                        ),
                                                      ],
                                                    ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        // Spacer(),
                        const SizedBox(
                          height: 30,
                        ),
                        Consumer<Controller>(builder: (context, controller, _) {
                          return CircularPercentIndicator(
                            reverse: true,
                            percent: controller.seconds.toDouble() / 5,
                            progressColor: const Color(0xFF6C63FE),
                            radius: 70,
                            center: Text(
                              "0:0${controller.seconds.toString()}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onLongPress: () {
                            countController.resetAll(context);
                          },
                          onPressed: () {
                            countController.stopCount();
                            countController.startCount();
                            countController.generateRandomNumber();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: !isRunning
                                ? const Text(
                                    'Click',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  )
                                : const Text('Pause'),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
