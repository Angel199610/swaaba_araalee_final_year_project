import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './car_categories_screen.dart';
import './profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track the selected index

  final List<Widget> _screens = [
    const HomeScreenContent(), // Home Screen content
    const CarCategoriesScreen(), // Categories Screen
    const ProfileScreen(), // Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Removed the AppBar
      body: _screens[_currentIndex], // Display selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Setting the background color to white
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 6, 6, 6)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Color.fromARGB(255, 3, 3, 3)),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 5, 5, 5)),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex, // Set the current selected index
        selectedItemColor:
            const Color.fromARGB(255, 241, 124, 21), // Orange for selected
        unselectedItemColor: Colors.black, // Black for unselected
        onTap: _onItemTapped, // Call _onItemTapped on tap
      ),
    );
  }

  // Function to handle navigation logic when BottomNavigationBar items are tapped
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex =
          index; // Update the currentIndex to the selected tab index
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
          // Welcome Paragraph
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Hello Nanteza Angellah, Welcome To ",
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
            height: 100,
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
            padding: const EdgeInsets.symmetric(horizontal: 1.0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            children: [
              exploreMoreCard('Premium Cars', 'lib/assets/E_cars/premium.png'),
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
                SizedBox(height: 1),
              ],
            ),
          ),
          SizedBox(
            height: 200, // Adjusted height to fit text and image
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                hotDealCard(
                  'lib/assets/hot_cars/lan.png',
                  'Special offer',
                  'Description for Hot Deal 1. Great offer!',
                  '5 days remaining',
                ),
                hotDealCard(
                  'lib/assets/hot_cars/alphard.png',
                  'Special offer',
                  'Toyota Alphard. Special price!',
                  '\$30,000',
                ),
                hotDealCard(
                  'lib/assets/hot_cars/prad.png',
                  'Special offer',
                  '2023 BMW 10E. Limited time offer!',
                  '\$28,500',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget carLogoCard(String title, String imagePath) {
    return Container(
      width: 100,
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  static Widget exploreMoreCard(String title, String imagePath) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          height: 200,
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
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
      ],
    );
  }

  static Widget hotDealCard(
      String imagePath, String title, String description, String price) {
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
























// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import './car_categories_screen.dart';
// import './profile_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   static get fontWeight => null;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: null, // Removed the AppBar
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Welcome Paragraph
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Hello Nanteza Angellah, Welcome To ",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Heading and Slogan
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Swaaba Araalee",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 3),
//                   Text(
//                     "The Best Automotive Source",
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Car Logo Cards Section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "What do You Prefer",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   carLogoCard('Toyota', 'lib/assets/toyota.png'),
//                   carLogoCard('Nissan', 'lib/assets/Nissan.png'),
//                   carLogoCard('Subaru', 'lib/assets/Subaru.png'),
//                   carLogoCard('Mercedes-Benz', 'lib/assets/Mercedenz.png'),
//                   carLogoCard('Mitsubishi', 'lib/assets/mitshubi.png'),
//                   carLogoCard('Land Rover', 'lib/assets/landRover.png'),
//                 ],
//               ),
//             ),

//             // Explore More Section
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Explore More",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               ),
//             ),
//             GridView(
//               padding: const EdgeInsets.symmetric(horizontal: 1.0),
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//               ),
//               children: [
//                 exploreMoreCard(
//                     'Premium Cars', 'lib/assets/E_cars/premium.png'),
//                 exploreMoreCard('Hybrid Cars', 'lib/assets/E_cars/hybrid.png'),
//                 exploreMoreCard('Luxury Cars', 'lib/assets/E_cars/luxury.png'),
//                 exploreMoreCard(
//                     'Popular Family Cars', 'lib/assets/E_cars/popular.png'),
//               ],
//             ),

//             // Hot Deals Section
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Hot Deals",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 1),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 200, // Adjusted height to fit text and image
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   hotDealCard(
//                     'lib/assets/hot_cars/lan.png',
//                     'Special offer',
//                     'Description for Hot Deal 1. Great offer!',
//                     '5 days remaining',
//                   ),
//                   hotDealCard(
//                     'lib/assets/hot_cars/alphard.png',
//                     'Special offer',
//                     'Toyota Alphard. Special price!',
//                     '\$30,000',
//                   ),
//                   hotDealCard(
//                     'lib/assets/hot_cars/prad.png',
//                     'Special offer',
//                     '2023 BMW 10E. Limited time offer!',
//                     '\$28,500',
//                   ),
//                 ],
//               ),
//             ),

//             // Swaaba Araalee Qualified Section
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "SWAABA ARAALEE Qualified",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Swaaba Araalee qualified cars are thoroughly inspected by a professional entity. "
//                     "There are also cars that are entitled to an extended warranty to offer you a peace-of-mind purchase.",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   bulletWithIcon(
//                     icon: Icons.verified,
//                     text: "Up to 5 years warranty covered by warranty Smart",
//                   ),
//                   const SizedBox(height: 8),
//                   bulletWithIcon(
//                     icon: Icons.report,
//                     text: "Pre-inspected with a detailed report",
//                   ),
//                   const SizedBox(height: 8),
//                   bulletWithIcon(
//                     icon: Icons.person,
//                     text: "Sold by top trusted dealers",
//                   ),
//                 ],
//               ),
//             ),

//             // Location Details Section
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Location Details",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Located in Nakawa at Future Holdings\n opposite Spare Motors\n"
//                     "Tel: +256 741031785 / +256 785220954\n"
//                     "WhatsApp: +256 785220954\n"
//                     "Email: swaaba@swaaba_araalee.org",
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 16),
//                   Text(
//                     "Find Us on the Map",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                 ],
//               ),
//             ),

//             // Map Section
//             SizedBox(
//               height: 200,
//               child: GoogleMap(
//                 initialCameraPosition: CameraPosition(
//                   target: LatLng(0.3133, 32.5930), // Nakawa, Uganda coordinates
//                   zoom: 14.0,
//                 ),
//                 markers: {
//                   Marker(
//                     markerId: MarkerId('swaaba_araalee'),
//                     position: LatLng(0.3133, 32.5930),
//                     infoWindow: InfoWindow(
//                       title: 'Swaaba Araalee',
//                       snippet: 'Nakawa, Opposite Spare Motors',
//                     ),
//                   ),
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.white, // Setting the background color to white
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Color.fromARGB(255, 6, 6, 6)),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.category, color: Color.fromARGB(255, 3, 3, 3)),
//             label: 'Categories',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Color.fromARGB(255, 5, 5, 5)),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: 0, // Default selected index
//         selectedItemColor: const Color.fromARGB(
//             255, 241, 124, 21), // Setting selected icon color to orange
//         unselectedItemColor:
//             Colors.black, // Setting unselected icon color to black
//         onTap: (index) {
//           // Handling navigation based on selected index
//         },
//       ),
//     );
//   }

//   static Widget carLogoCard(String title, String imagePath) {
//     return Container(
//       width: 100,
//       margin: const EdgeInsets.only(right: 8.0),
//       child: Column(
//         children: [
//           Container(
//             height: 60,
//             width: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(30),
//               image: DecorationImage(
//                 image: AssetImage(imagePath),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 14),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget exploreMoreCard(String title, String imagePath) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//           height: 200,
//         ),
//         Positioned(
//           bottom: 10,
//           left: 10,
//           child: Container(
//             padding: const EdgeInsets.all(5.0),
//             decoration: BoxDecoration(
//               color: Colors.black.withOpacity(0.5),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   static Widget hotDealCard(
//       String imagePath, String title, String description, String price) {
//     return Container(
//       width: 150,
//       margin: const EdgeInsets.only(right: 12.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           gradient: LinearGradient(
//             colors: [Colors.black.withOpacity(0.7), Colors.transparent],
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               description,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               price,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget bulletWithIcon({required IconData icon, required String text}) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.black),
//         const SizedBox(width: 8),
//         Expanded(child: Text(text)),
//       ],
//     );
//   }
// }
