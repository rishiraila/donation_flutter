import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_controller.dart' show CarouselSliderController; // ✅ Import with specific alias

class HeroCarousel extends StatefulWidget {
  @override
  _HeroCarouselState createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final List<Map<String, String>> carouselItems = [
    {
      'message': 'Help Dr. Bhagat rescue and care for abandoned elderly parents from the streets',
      'image': 'assets/andrej.jpg'
    },
    {
      'message': 'Help Aaboo rescue children from the horrors of red-light areas',
      'image': 'assets/jaikishan.jpg'
    },
    {
      'message': 'Donate now to support the cause and make a difference',
      'image': 'assets/larm.jpg'
    },
  ];

  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController(); // ✅ Use correct controller type

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
      double carouselHeight = screenWidth < 600
        ? 200 // Mobile
        : screenWidth < 1024
            ? 300 // Tablet
            : 400; // Desktop

    double fontSize = screenWidth < 600
        ? 16
        : screenWidth < 1024
            ? 20
            : 24;
      EdgeInsetsGeometry cardPadding = screenWidth < 600
        ? EdgeInsets.all(10)
        : EdgeInsets.symmetric(horizontal: 30);

     return Container(
      padding: cardPadding,
      color: Colors.red.shade50,
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: carouselItems.length,
            itemBuilder: (context, index, realIdx) {
              final item = carouselItems[index];
              return buildCarouselCard(item['message']!, item['image']!, fontSize);
            },
            options: CarouselOptions(
              height: carouselHeight,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            carouselController: _controller,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left, size: 32),
                onPressed: () {
                  int previousIndex = (_currentIndex - 1 + carouselItems.length) % carouselItems.length;
                  _controller.animateToPage(
                    previousIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                color: Colors.red,
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.chevron_right, size: 32),
                onPressed: () {
                  int nextIndex = (_currentIndex + 1) % carouselItems.length;
                  _controller.animateToPage(
                    nextIndex,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCarouselCard(String message, String imageUrl, double fontSize) {
  final bool isAssetImage = imageUrl.startsWith('assets/');

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          blurRadius: 6,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        fit: StackFit.expand,
        children: [
          isAssetImage
              ? Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
          Container(
            color: Colors.black.withOpacity(0.4), // Dark overlay for readability
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.6),
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement action for the button
                  },
                  child: Text('Donate Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                     textStyle: TextStyle(fontSize: fontSize * 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
