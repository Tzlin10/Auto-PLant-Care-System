import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 176, 195, 156),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  color: const Color.fromARGB(255, 214, 226, 217),
                  height: 160,
                  width: 380,
                ),
                Center(
                  child: Container(
                    height: 140,
                    width: 330,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 3.50,
                        )),
                    child: Center(
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(children: [
                            TextSpan(
                                text: "Hello!\n",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                            TextSpan(
                                text: "Welcome to Plant Care System",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ])),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 214, 226, 217),
                      height: 250,
                      width: 190,
                    ),
                    Center(
                      child: Container(
                        height: 160,
                        width: 155,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 3.50,
                            )),
                        child: Stack(children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/rain');
                            },
                            child: Image.asset(
                              'assets/rainIcon.png',
                              height: 400,
                              scale: 0.5,
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 214, 226, 217),
                      height: 250,
                      width: 190,
                    ),
                    Center(
                      child: Container(
                          height: 160,
                          width: 155,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 3.50,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/soilIcon.png',
                                height: 100,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/soil');
                                  },
                                  child: const Text(
                                    'Soil Moisture',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 214, 226, 217),
                      height: 170,
                      width: 190,
                    ),
                    Center(
                      child: Container(
                        height: 160,
                        width: 155,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.black,
                              width: 3.50,
                            )),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/temperatureIcon.png',
                                height: 100,
                                scale: 1.0,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/temperature');
                                  },
                                  child: const Text(
                                    'Temperature',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))
                            ]),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 214, 226, 217),
                      height: 170,
                      width: 190,
                    ),
                    Center(
                      child: Container(
                          height: 160,
                          width: 155,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 3.50,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/lightIcon.png',
                                height: 100,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/light');
                                  },
                                  child: const Text(
                                    'Light',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
