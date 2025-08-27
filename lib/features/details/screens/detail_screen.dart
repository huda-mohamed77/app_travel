import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; 
    final height = size.height;
    final width = size.width;

    const outerBg = Color(0xFFE1E9F4);
    const cardRadius = 24.0;
    const sectionGap = SizedBox(height: 16);

    return Scaffold(
      backgroundColor: outerBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Container(
            padding: EdgeInsets.all(width * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/mountain.png',
                            height: height * 0.65,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.35),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: width * 0.03,
                            right: width * 0.03,
                            bottom: width * 0.03,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.012,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Andes Mountain',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.055,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4,
                                            shadows: const [
                                              Shadow(
                                                offset: Offset(0, 1),
                                                blurRadius: 2,
                                                color: Colors.black26,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: height * 0.008),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              size: width * 0.05,
                                              color: Colors.white30,
                                            ),
                                            SizedBox(width: width * 0.01),
                                            Text(
                                              'South America',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: width * 0.035,
                                                height: 1,
                                                shadows: const [
                                                  Shadow(
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                    color: Colors.black26,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width * 0.03),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: width * 0.04,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.005),
                                      Text(
                                        '\$230',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.055,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                Row(
                  children: [
                    Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: height * 0.02),

                Row(
                  children: [
                    _IconBox(icon: Icons.access_time, size: width * 0.1),
                    SizedBox(width: width * 0.02),
                    Text(
                      '8 hours',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    _IconBox(icon: Icons.cloud, size: width * 0.1),
                    SizedBox(width: width * 0.02),
                    Text(
                      '16 C',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: width * 0.05),
                    _IconBox(icon: Icons.star, size: width * 0.1),
                    SizedBox(width: width * 0.02),
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                sectionGap,

                Container(
                  height: height * 0.1,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Text(
                      'This vast mountain range is renowned for its remarkable diversity in terms of topography and climate. It features towering peaks, active volcanoes, deep canyons, expansive plateaus.',
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.grey,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),

                SizedBox(height: height * 0.015),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final now = DateTime.now();
                          final formattedDate =
                              "${now.day}/${now.month}/${now.year}";
                          final formattedTime =
                              "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text(
                                "Booking Confirmed ✅",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Trip: Andes Mountain"),
                                  const SizedBox(height: 6),
                                  Text("Date: $formattedDate"),
                                  const SizedBox(height: 6),
                                  Text("Time: $formattedTime"),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "Your booking has been successfully recorded 🎉",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            vertical: height * 0.02,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Book Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.045,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            Transform.rotate(
                              angle: -0.6,
                              child: Icon(
                                Icons.send_sharp,
                                color: Colors.white,
                                size: width * 0.07,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final IconData icon;
  final double size;
  const _IconBox({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size * 0.3),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: size * 0.6, color: Colors.black54),
    );
  }
}
