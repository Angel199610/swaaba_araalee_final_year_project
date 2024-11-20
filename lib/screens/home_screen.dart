import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Removed the AppBar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Paragraph
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello John Doe, Welcome To ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Heading and Slogan
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Swaaba Araalee",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "The Best Automotive Source",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Car Logo Cards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "What do You Prefer",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  carLogoCard('Toyota', 'lib/assets/toyota.png'),
                  carLogoCard('Nissan', 'lib/assets/Nissan.png'),
                  carLogoCard('Subaru', 'lib/assets/Subaru.png'),
                  carLogoCard('Mercedes-Benz', 'lib/assets/Mercedenz.png'),
                  carLogoCard('Mitsubishi', 'lib/assets/mitshubi.png'),
                  carLogoCard('Land Rover', 'lib/assets/landRover.png'),
                ],
              ),
            ),

            // Explore More Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Explore More",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            GridView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              children: [
                exploreMoreCard(
                    'Premium Cars', 'lib/assets/E_cars/premium.png'),
                exploreMoreCard('Hybrid Cars', 'lib/assets/E_cars/hybrid.png'),
                exploreMoreCard('Luxury Cars', 'lib/assets/E_cars/luxury.png'),
                exploreMoreCard(
                    'Popular Family Cars', 'lib/assets/E_cars/popular.png'),
              ],
            ),

            // Hot Deals Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hot Deals",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  hotDealCard('lib/assets/hot_cars/lan.png', 'Hot Deal 1'),
                  hotDealCard('lib/assets/hot_cars/alphard.png', 'Hot Deal 2'),
                  hotDealCard('lib/assets/hot_cars/prad.png', 'Hot Deal 3'),
                ],
              ),
            ),

            // Swaaba Araalee Qualified Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "SWAABA ARAALEE Qualified",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Swaaba Araalee qualified cars are thoroughly inspected by a professional entity. "
                    "There are also cars that are entitled to an extended warranty to offer you a peace-of-mind purchase.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  bulletWithIcon(
                    icon: Icons.verified,
                    text: "Up to 5 years warranty covered by warranty Smart",
                  ),
                  const SizedBox(height: 8),
                  bulletWithIcon(
                    icon: Icons.report,
                    text: "Pre-inspected with a detailed report",
                  ),
                  const SizedBox(height: 8),
                  bulletWithIcon(
                    icon: Icons.person,
                    text: "Sold by top trusted dealers",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set the background color to white
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.orange),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Colors.orange),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail, color: Colors.orange),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.orange),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.orange),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Default selected index
        selectedItemColor: Colors.orange, // Set selected icon color to orange
        unselectedItemColor: Colors.black, // Set unselected icon color to black
        onTap: (index) {
          // Handle navigation based on selected index
        },
      ),
    );
  }

  static Widget carLogoCard(String title, String imagePath) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget exploreMoreCard(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static Widget hotDealCard(String imagePath, String title) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  static Widget bulletWithIcon({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
