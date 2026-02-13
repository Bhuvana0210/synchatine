import 'package:flutter/material.dart';
import 'dart:math' as math;

class SheSaidYes extends StatefulWidget {
  final String message;

  const SheSaidYes({super.key, required this.message});

  @override
  State<SheSaidYes> createState() => _SheSaidYesState();
}

class _SheSaidYesState extends State<SheSaidYes>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // 🌸 Elegant Gradient Background (same aesthetic)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.pink.shade300,
                  Colors.pink.shade100,
                  Colors.purple.shade100,
                  Colors.pink.shade200,
                ],
              ),
            ),
          ),

          // 💕 Floating Hearts Background
          ...List.generate(24, (i) {
            return Positioned(
              left: (i * 70.0) % size.width,
              top: size.height * (i / 24),
              child: Icon(
                Icons.favorite,
                color: Colors.white.withOpacity(0.22),
                size: 18 + (i % 3) * 8,
              ),
            );
          }),

          SafeArea(
            child: Column(
              children: [
                // 🌷 Romantic Top Bar
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade500,
                        Colors.purple.shade400
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.35),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'Yay! 💕',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // 💌 Main Card
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Center(
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                isSmallScreen ? 22 : 28),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // ❤️ Animated Heart
                                AnimatedBuilder(
                                  animation: _rotationAnimation,
                                  builder: (_, __) {
                                    return Transform.rotate(
                                      angle: math.sin(
                                              _rotationAnimation.value) *
                                          0.08,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.pink.shade400,
                                              Colors.red.shade400,
                                            ],
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          size:
                                              isSmallScreen ? 24 : 32,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 18),

                                // Main Title Message
                                Text(
                                  widget.message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize:
                                        isSmallScreen ? 22 : 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink.shade700,
                                    fontFamily: 'Georgia',
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Divider
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 2,
                                      color: Colors.pink.shade300,
                                    ),
                                    const SizedBox(width: 10),
                                    Icon(
                                      Icons.favorite,
                                      size: 16,
                                      color: Colors.pink.shade400,
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 40,
                                      height: 2,
                                      color: Colors.pink.shade300,
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 18),

                                // 💖 Love Letter Box
                                Container(
                                  padding:
                                      const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: Colors.pink.shade100,
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    border: Border.all(
                                      color:
                                          Colors.pink.shade400,
                                      width: 1.3,
                                    ),
                                  ),
                                  child: Text(
                                    "Muddu, I look at you and see our entire history—every laugh, every hurdle we cleared, and every milestone that led us to this moment. Turning you from my girlfriend into my wife is the proudest achievement of my life. You aren't just my partner; you are my witness, my anchor, and my greatest adventure. I loved you then, I love you more now, and I’ll spend the rest of our lives proving that the best is still yet to come. 💖😘",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize:
                                          isSmallScreen ? 14 : 15,
                                      height: 1.4,
                                      color: Colors
                                          .pink.shade900,
                                      fontFamily:
                                          'Georgia',
                                      fontStyle:
                                          FontStyle.italic,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                // Bottom Emoji Row
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 12,
                                  children: const [
                                    Text("💕", style: TextStyle(fontSize: 22)),
                                    Text("💖", style: TextStyle(fontSize: 22)),
                                    Text("💝", style: TextStyle(fontSize: 22)),
                                    Text("💗", style: TextStyle(fontSize: 22)),
                                    Text("💓", style: TextStyle(fontSize: 22)),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                Text(
                                  '✨ Forever Yours ✨',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.pink.shade400,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: 'Georgia',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
