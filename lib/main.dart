import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'she_said_yes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyValentine(),
    );
  }
}

class MyValentine extends StatefulWidget {
  const MyValentine({super.key});

  @override
  State<MyValentine> createState() => _MyValentineState();
}

class _MyValentineState extends State<MyValentine> {
  final GlobalKey _buttonAreaKey = GlobalKey();
  final math.Random _random = math.Random();

  Offset? _noPosition;

  double _noScale = 1;
  double _yesScale = 1;
  double _noRotation = 0;
  int _attempts = 0;

  static const double buttonWidth = 120;
  static const double buttonHeight = 50;

  void _moveNoButton() {
    final RenderBox? box =
        _buttonAreaKey.currentContext?.findRenderObject() as RenderBox?;

    if (box == null) return;

    final areaWidth = box.size.width;
    final areaHeight = box.size.height;

    final yesX = 40.0;
    final yesY = 85.0;

    Offset newPosition;

    do {
      final dx = _random.nextDouble() * (areaWidth - buttonWidth);
      final dy = _random.nextDouble() * (areaHeight - buttonHeight);
      newPosition = Offset(dx, dy);
    } while (_isOverlapping(newPosition, Offset(yesX, yesY)));

    setState(() {
      _noPosition = newPosition;
      _attempts++;

      _noScale = (_noScale - 0.08).clamp(0.4, 1.0);
      _yesScale += 0.05;
      _noRotation = (_random.nextDouble() - 0.5) * 0.6;
    });
  }

  bool _isOverlapping(Offset noPos, Offset yesPos) {
    return (noPos.dx < yesPos.dx + buttonWidth &&
        noPos.dx + buttonWidth > yesPos.dx &&
        noPos.dy < yesPos.dy + buttonHeight &&
        noPos.dy + buttonHeight > yesPos.dy);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // 💖 Soft Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pink.shade200,
                  Colors.pink.shade100,
                  Colors.pink.shade200,
                ],
              ),
            ),
          ),

          // 💕 Floating Hearts
          ...List.generate(25, (index) {
            return Positioned(
              left: (index * 73.5) % screenWidth,
              top: (index * 97.3) % screenHeight,
              child: Transform.rotate(
                angle: index * 0.4,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white.withOpacity(0.15),
                  size: 25 + (index % 3) * 15,
                ),
              ),
            );
          }),

          SafeArea(
            child: Center(
              child: Card(
                elevation: 10,
                shadowColor: Colors.pink.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                color: Colors.pink.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 👑 Title
                                            Text(
                        "My Queen 💖",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.3,
                          color: const Color(0xFFAD1457), // deeper romantic pink
                          shadows: [
                            Shadow(
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ],
                        ),
                      ),


                      const SizedBox(height: 10),

                      // 💕 Subtitle
                      Text(
                        "Will you be my Valentine?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.pink.shade800,
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        key: _buttonAreaKey,
                        height: 220,
                        width: 320,
                        child: Stack(
                          children: [
                            // 💖 YES BUTTON
                            Positioned(
                              left: 40,
                              top: 85,
                              child: AnimatedScale(
                                scale: _yesScale,
                                duration:
                                    const Duration(milliseconds: 200),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SheSaidYes(
                                          message:
                                              "YOU SAID YESSS 💖💖💖",
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(0xFFD81B60),
                                    foregroundColor: Colors.white,
                                    elevation: 6,
                                    shadowColor:
                                        Colors.black.withOpacity(0.25),
                                    padding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 15),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    "YES 💕",
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // 😈 NO BUTTON
                            AnimatedPositioned(
                              duration: Duration(
                                  milliseconds:
                                      250 -
                                          (_attempts * 10)
                                              .clamp(0, 150)),
                              curve: Curves.easeOut,
                              left:
                                  _noPosition?.dx ?? 170,
                              top:
                                  _noPosition?.dy ?? 85,
                              child: AnimatedRotation(
                                turns: _noRotation,
                                duration:
                                    const Duration(
                                        milliseconds:
                                            200),
                                child: AnimatedScale(
                                  scale: _noScale,
                                  duration:
                                      const Duration(
                                          milliseconds:
                                              200),
                                  child: ElevatedButton(
                                    onPressed:
                                        _moveNoButton,
                                    style:
                                        ElevatedButton
                                            .styleFrom(
                                      backgroundColor:
                                          const Color(
                                              0xFFF06292),
                                      foregroundColor:
                                          Colors.white,
                                      elevation: 6,
                                      shadowColor: Colors
                                          .black
                                          .withOpacity(
                                              0.25),
                                      padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                                  32,
                                              vertical:
                                                  15),
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    30),
                                      ),
                                    ),
                                    child:
                                        const Text(
                                      "No 😏",
                                      style: TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      if (_attempts > 4)
                        Text(
                          "Stop trying 😂",
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                Colors.pink.shade400,
                            fontStyle:
                                FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
