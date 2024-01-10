import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mru_algorithm/slides_functions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int maxFrameLimit = 9;
  int minFrameLimit = 1;
  var frameController = TextEditingController(text: "3");
  int maxPageLimit = 20;
  int minPageLimit = 1;
  var pageController = TextEditingController(text: "10");

  int pageval = 10;
  int fraval = 3;

  List<int> pagesIds = [];
  List<String> stringResult = List<String>.filled(20, "-");
  bool isHit = false;
  bool isStarted = false;
  int hitIndex = -1;
  int recentInt = -1;
  Timer mytimer = Timer.periodic(Duration.zero, (timer) {});
  Timer mytimer1 = Timer.periodic(Duration.zero, (timer) {});
  int referenceStringPointer = 0;

  List<int> stackValues = List<int>.filled(7, -2);
  List<int> memoryStack = [];
  Widget Frame0 = Container();
  Widget Frame1 = Container();
  Widget Frame2 = Container();
  Widget Frame3 = Container();
  Widget Frame4 = Container();
  Widget Frame5 = Container();
  Widget Frame6 = Container();
  Widget HitFrame = Container();

  void initState() {
    for (int i = 0; i < fraval; i++) {
      stackValues[i] = -1;
    }
    super.initState();
    recentInt = 0;
    mytimer.cancel();
    mytimer1.cancel();
  }

  List<int> generateRandomIntegers(int count, int min, int max) {
    Random random = Random();
    List<int> result = [];

    for (int i = 0; i < count; i++) {
      int randomNumber = random.nextInt(max - min + 1) + min;
      result.add(randomNumber);
    }
    return result;
  }

  String countPageFault() {
    int temp = 0;
    for (int i = 0; i < stringResult.length; i++) {
      if (stringResult[i] == 'M') {
        temp++;
      }
    }
    return temp.toString();
  }

  void MemoryStack(int pageID) {
    for (int i = 0; i < memoryStack.length; i++) {
      if (memoryStack[i] == pageID) {
        memoryStack.removeAt(i);
      }
    }
    memoryStack.add(pageID);
  }

  int TotalMiss() {
    int a = 0;
    for (int i = 0; i < stringResult.length; i++) {
      if (stringResult[i] == 'M') {
        a++;
      }
    }
    return a;
  }

  int TotalHit() {
    int a = 0;
    for (int i = 0; i < stringResult.length; i++) {
      if (stringResult[i] == 'H') {
        a++;
      }
    }
    return a;
  }

  int LeastRecentValue() {
    for (int i = memoryStack.length - 1; i >= 0; i++) {
      for (int j = 0; j < stackValues.length; j++) {
        if (memoryStack[i] == stackValues[j]) {
          return j;
        }
      }
    }
    return -2;
  }

  void LRUFunction() async {
    if (referenceStringPointer < pageval) {
      if (recentInt >= fraval) {
        recentInt = 0;
      }
      for (int i = 0; i < fraval; i++) {
        if (pagesIds[referenceStringPointer] != -1 &&
            pagesIds[referenceStringPointer] == stackValues[i]) {
          isHit = true;
          hitIndex = i;
          // bottomText = "Hit";
          // bottomTextColor = Theme.of(context).scaffoldBackgroundColor;
        }
      }
      if (isHit == false) {
        // bottomText = "Miss";
        // bottomTextColor = Colors.redAccent;
        if (stackValues[0] == -1) {
          Frame0 = newPage(pagesIds[referenceStringPointer], 0, true);
          stackValues[0] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[1] == -1) {
          Frame1 = newPage(pagesIds[referenceStringPointer], 1, true);
          stackValues[1] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[2] == -1) {
          Frame2 = newPage(pagesIds[referenceStringPointer], 2, true);
          stackValues[2] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[3] == -1) {
          Frame3 = newPage(pagesIds[referenceStringPointer], 3, true);
          stackValues[3] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[4] == -1) {
          Frame4 = newPage(pagesIds[referenceStringPointer], 4, true);
          stackValues[4] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[5] == -1) {
          Frame5 = newPage(pagesIds[referenceStringPointer], 5, true);
          stackValues[5] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else if (stackValues[6] == -1) {
          Frame6 = newPage(pagesIds[referenceStringPointer], 6, true);
          stackValues[6] = pagesIds[referenceStringPointer];
          stringResult[referenceStringPointer] = "M";
          MemoryStack(pagesIds[referenceStringPointer]);
          referenceStringPointer++;
        } else {
          recentInt = LeastRecentValue();
          for (int i = 0; i < stackValues.length; i++) {
            if (recentInt == 0) {
              Frame0 = newPage(stackValues[0], 0, false);
              stackValues[0] = -1;
              break;
            } else if (recentInt == 1) {
              Frame1 = newPage(stackValues[1], 1, false);
              stackValues[1] = -1;
              break;
            } else if (recentInt == 2) {
              Frame2 = newPage(stackValues[2], 2, false);
              stackValues[2] = -1;
              break;
            } else if (recentInt == 3) {
              Frame3 = newPage(stackValues[3], 3, false);
              stackValues[3] = -1;
              break;
            } else if (recentInt == 4) {
              Frame4 = newPage(stackValues[4], 4, false);
              stackValues[4] = -1;
              break;
            } else if (recentInt == 5) {
              Frame5 = newPage(stackValues[5], 5, false);
              stackValues[5] = -1;
              break;
            } else if (recentInt == 6) {
              Frame6 = newPage(stackValues[6], 6, false);
              stackValues[6] = -1;
              break;
            }
          }
        }
      } else {
        MemoryStack(pagesIds[referenceStringPointer]);
        for (int i = 0; i < stackValues.length; i++) {
          if (hitIndex == i) {
            HitFrame = hitPage(stackValues[i], i, true);
            stringResult[referenceStringPointer] = "H";
            referenceStringPointer++;
            setState(() {});
            await Future.delayed(const Duration(seconds: 1));
            HitFrame = hitPage(stackValues[i], i, false);
            setState(() {});
          }
        }
        isHit = false;
        hitIndex = -1;
      }
    } else {
      referenceStringPointer++;
      // bottomText = "Total Page Fault: ${countPageFault()}";
      // bottomTextColor = const Color.fromARGB(255, 131, 131, 131);
      isStarted = false;
      mytimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pagesIds.isEmpty) {
      // pagesIds = [4, 5, 6, 7, 8, 9, 4, 5, 6, 7, 8, 9, 4, 5, 6, 7, 8, 9];
      pagesIds = generateRandomIntegers(20, 1, 9);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56,
              color: Theme.of(context).primaryColor,
              child: const Center(
                child: Text(
                  "MRU Page Replacement",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: frameController,
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            int.parse(value) > maxFrameLimit) {
                          frameController = TextEditingController(
                              text: maxFrameLimit.toString());
                        } else if (value.isNotEmpty &&
                            int.parse(value) < minFrameLimit) {
                          frameController = TextEditingController(
                              text: minFrameLimit.toString());
                        }

                        setState(() {});
                      },
                      onEditingComplete: () {
                        print("object");
                        if (frameController.text.isEmpty) {
                          fraval = 1;
                        } else {
                          fraval = int.parse(frameController.text);
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor)),
                        labelText: "Enter Number of Frames   (1-5)",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: pageController,
                      onChanged: (value) {
                        if (value.isNotEmpty &&
                            int.parse(value) > maxPageLimit) {
                          pageController = TextEditingController(
                              text: maxPageLimit.toString());
                        } else if (value.isNotEmpty &&
                            int.parse(value) < minPageLimit) {
                          pageController = TextEditingController(
                              text: minPageLimit.toString());
                        }
                        setState(() {});
                      },
                      onEditingComplete: () {
                        if (pageController.text.isEmpty) {
                          pageval = 1;
                        } else {
                          pageval = int.parse(pageController.text);
                        }
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor)),
                        labelText: "Enter Number of Pages   (1-20)",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            // Animation Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: mytimer.isActive
                        ? null
                        : () {
                            if (mytimer.isActive == false &&
                                referenceStringPointer >= pageval) {
                              isStarted = true;
                              setState(() {});

                              mytimer = Timer.periodic(
                                  const Duration(seconds: 2), (timer) {
                                setState(() {});
                                LRUFunction();
                                setState(() {});
                              });
                            } else if (mytimer.isActive) {
                              mytimer.cancel();
                              isStarted = false;
                              setState(() {});
                            } else {
                              isStarted = true;
                              setState(() {});
                              mytimer = Timer.periodic(
                                  const Duration(seconds: 2), (timer) {
                                setState(() {});
                                LRUFunction();
                                setState(() {});
                              });
                            }
                          },
                    child: const Text(
                      "Start Animation",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: mytimer.isActive
                        ? null
                        : () {
                            pagesIds = generateRandomIntegers(20, 1, 9);
                            setState(() {});
                          },
                    child: const Text(
                      "New Values",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),

            const SizedBox(
              height: 50,
            ),
            // Pages Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < pageval; i++)
                    Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.all(3),
                      child: Center(child: Text(pagesIds[i].toString())),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: stringResult[i] != '-' ? 2 : 1,
                              color: stringResult[i] == 'M'
                                  ? Colors.red
                                  : stringResult[i] == 'H'
                                      ? Colors.green
                                      : Colors.black)),
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Miss Hit
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total Miss: ${TotalMiss().toString()}",
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 40,
                ),
                Text(
                  "Total Hit: ${TotalHit().toString()}",
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 60,
              height: fraval * 60,
              child: Stack(
                children: [
                  for (int i = 0; i < fraval; i++)
                    Positioned(
                      top: i * 60,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black)),
                      ),
                    ),
                  stackValues[0] == -2 ? const SizedBox() : Frame0,
                  stackValues[1] == -2 ? const SizedBox() : Frame1,
                  stackValues[2] == -2 ? const SizedBox() : Frame2,
                  stackValues[3] == -2 ? const SizedBox() : Frame3,
                  stackValues[4] == -2 ? const SizedBox() : Frame4,
                  stackValues[5] == -2 ? const SizedBox() : Frame5,
                  stackValues[6] == -2 ? const SizedBox() : Frame6,
                  HitFrame
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
