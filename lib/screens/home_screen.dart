import 'package:flutter/material.dart';
import 'package:swaaba_aralee/screens/brand_cars_screen.dart';
import 'package:swaaba_aralee/screens/hybrid_car_screen.dart';
import 'package:swaaba_aralee/screens/luxury_cars_screen.dart';
import 'package:swaaba_aralee/screens/popular_family_cars_screen.dart';
import 'package:swaaba_aralee/screens/premium_cars_screen.dart';
import 'package:swaaba_aralee/screens/profile_screen.dart';
import 'package:swaaba_aralee/services/api_service.dart';
import 'contact_us_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final ApiService _apiService = ApiService();
  String? _userName;

  late final List<Widget> _screens;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreenContent(),
      const ContactUsPage(),
      ProfileScreen(apiService: _apiService),
    ];
    _loadUser();

    // Initialize the AnimationController for the scrolling text
    _controller = AnimationController(
      duration: const Duration(seconds: 10), // Adjust speed here
      vsync: this,
    )..repeat(); // Makes the animation loop indefinitely

    // Define the animation to move from right to left
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  void _loadUser() async {
    try {
      final user = await _apiService.getUser();
      setState(() {
        _userName = user['name'];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          if (_currentIndex == 0)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    AppBar(
                      title: Text(
                        _userName != null
                            ? 'Welcome, $_userName'
                            : 'Swaaba Araalee',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Animated scrolling text
                          SizedBox(
                            width: double.infinity,
                            height: 20, // Adjust height as needed
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                // Measure the text width
                                final textPainter = TextPainter(
                                  text: const TextSpan(
                                    text: "More than 170,014 cars for You at ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  textDirection: TextDirection.ltr,
                                )..layout();

                                final textWidth = textPainter.width;
                                final containerWidth = constraints.maxWidth;

                                return AnimatedBuilder(
                                  animation: _animation,
                                  builder: (context, child) {
                                    // Calculate the offset to move the text
                                    final offset = (_animation.value *
                                            (containerWidth + textWidth)) -
                                        textWidth;
                                    return Transform.translate(
                                      offset: Offset(offset, 0),
                                      child: child,
                                    );
                                  },
                                  child: const Text(
                                    "The Best Automotive Source ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 6, 6, 6)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_emergency_rounded,
                color: Color.fromARGB(255, 3, 3, 3)),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 5, 5, 5)),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 241, 124, 21),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 140),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "What do You Prefer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
          CarLogoList(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color.fromARGB(255, 233, 165, 93),
            child: const Text(
              "Explore More",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 233, 165, 93),
            child: GridView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
              ),
              children: [
                exploreMoreCard(
                    'Premium Cars', 'lib/assets/E_cars/premium.png', context),
                exploreMoreCard(
                    'Hybrid Cars', 'lib/assets/E_cars/hybrid.png', context),
                exploreMoreCard(
                    'Luxury Cars', 'lib/assets/E_cars/luxury.png', context),
                exploreMoreCard(
                    'Popular Cars', 'lib/assets/E_cars/popular.png', context),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Hot Deals",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                hotDealCard(
                  'lib/assets/hot_cars/lan.png',
                  'SPECIAL OFFER',
                  '2019 BMW 330i Sport Sedan',
                  '5 days 22 hours',
                ),
                hotDealCard(
                  'lib/assets/hot_cars/alphard.png',
                  'SPECIAL OFFER',
                  'Toyota Alphard 2.5G S package',
                  'UGX 50,000,000',
                ),
                hotDealCard(
                  'lib/assets/hot_cars/prad.png',
                  'SPECIAL OFFER',
                  '2023 BMW i4 0.0 eDrive40 M',
                  '3 days 17 hours',
                ),
              ],
            ),
          ),
          const SwaabaQualifiedSection(),
        ],
      ),
    );
  }

  static Widget exploreMoreCard(
      String title, String imagePath, BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (title == 'Premium Cars') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PremiumCarsScreen()),
            );
          } else if (title == 'Luxury Cars') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LuxuryCarsScreen()),
            );
          } else if (title == 'Popular Family Cars') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PopularFamilyCarsScreen()),
            );
          } else if (title == 'Hybrid Cars') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HybridCarsScreen()),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget hotDealCard(
      String imagePath, String title, String description, String price) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
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

class CarLogoCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final BuildContext parentContext;

  const CarLogoCard(this.title, this.imagePath, this.parentContext,
      {super.key});

  @override
  _CarLogoCardState createState() => _CarLogoCardState();
}

class _CarLogoCardState extends State<CarLogoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            widget.parentContext,
            MaterialPageRoute(
              builder: (context) => BrandCarsScreen(brand: widget.title),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
          transformAlignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovered ? 0.4 : 0.2),
                      blurRadius: _isHovered ? 12 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarLogoList extends StatefulWidget {
  @override
  _CarLogoListState createState() => _CarLogoListState();
}

class _CarLogoListState extends State<CarLogoList> {
  final ScrollController _scrollController = ScrollController();
  bool _showLeftArrow = false;
  bool _showRightArrow = true;

  final List<Map<String, String>> carLogos = [
    {'title': 'Toyota', 'imagePath': 'lib/assets/toyota.png'},
    {'title': 'Nissan', 'imagePath': 'lib/assets/Nissan.png'},
    {'title': 'Subaru', 'imagePath': 'lib/assets/Subaru.png'},
    {'title': 'Mercedes-Benz', 'imagePath': 'lib/assets/Mercedenz.png'},
    {'title': 'Mitsubishi', 'imagePath': 'lib/assets/mitshubi.png'},
    {'title': 'Land Rover', 'imagePath': 'lib/assets/landRover.png'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _showLeftArrow = _scrollController.offset > 0;
        _showRightArrow = _scrollController.offset <
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: carLogos.length,
            itemBuilder: (context, index) {
              return CarLogoCard(
                carLogos[index]['title']!,
                carLogos[index]['imagePath']!,
                context,
              );
            },
          ),
          if (_showLeftArrow)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: _scrollLeft,
                icon: const Icon(
                  Icons.arrow_left,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
            ),
          if (_showRightArrow)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: IconButton(
                onPressed: _scrollRight,
                icon: const Icon(
                  Icons.arrow_right,
                  color: Colors.black54,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SwaabaQualifiedSection extends StatelessWidget {
  const SwaabaQualifiedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: const Color.fromARGB(255, 239, 127, 7),
            child: const Text(
              "SWAABA ARALEE Qualified",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Swaaba Aralee my qualified cars are thoroughly inspected by a professional entity. There are also cars that are entitled to an extended warranty to offer you a peace-of-mind purchase",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(
                      Icons.shield,
                      color: Color.fromARGB(255, 239, 127, 7),
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Up to 5 years warranty covered by Warranty Smart",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.description,
                      color: Color.fromARGB(255, 239, 127, 7),
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Pre-inspected with detailed report",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.handshake,
                      color: Color.fromARGB(255, 239, 127, 7),
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Sold by the top trusted dealers",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}