import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/hybrid_car_service.dart';
import 'dart:async'; // For Timer

class HybridCarsScreen extends StatefulWidget {
  const HybridCarsScreen({super.key});

  @override
  State<HybridCarsScreen> createState() => _HybridCarsScreenState();
}

class _HybridCarsScreenState extends State<HybridCarsScreen> {
  late Future<List<Map<String, dynamic>>> _hybridCarsFuture;

  // Define static image sets for each car
  final List<List<String>> carImageSets = [
    [
      'lib/assets/hybrid/hybrid1_back.jpg',
      'lib/assets/hybrid/hybrid1_front.jpg',
      'lib/assets/hybrid/hybrid1_inside.jpg',
      'lib/assets/hybrid/hybrid1_beside.jpg',
    ],
    [
      'lib/assets/hybrid/hybrid2_front.jpg',
      'lib/assets/hybrid/hybrid2_back.jpg',
      'lib/assets/hybrid/hybrid2_inside.jpg',
      'lib/assets/hybrid/hybrid2_beside.jpg',
    ],
  ];

  @override
  void initState() {
    super.initState();
    _hybridCarsFuture = HybridCarService.fetchHybridCars();
  }

  // Function to launch phone call
  Future<void> _launchPhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch phone call')),
      );
    }
  }

  // Function to launch WhatsApp
  Future<void> _launchWhatsApp(String phoneNumber, String message) async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hybrid Cars',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 248, 139, 37),
        automaticallyImplyLeading: false, // Remove back arrow
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _hybridCarsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Snapshot error: ${snapshot.error}");
            String errorMessage = snapshot.error.toString();
            return Center(
                child: Text('Error loading hybrid cars: $errorMessage'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hybrid cars available'));
          }

          final hybridCars = snapshot.data!;
          return ListView.builder(
            itemCount: hybridCars.length,
            itemBuilder: (context, index) {
              final car = hybridCars[index];
              final images = carImageSets[index % carImageSets.length];

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: images.isNotEmpty
                              ? SizedBox(
                                  height: 250, // Reduced height to minimize cropping
                                  width: double.infinity,
                                  child: ImageCarousel(
                                    images: images,
                                  ),
                                )
                              : const Icon(Icons.image_not_supported,
                                  size: 200),
                        ),
                        if (car['featured'] == 1 || car['featured'] == true)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 245, 137, 42),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.thumb_up,
                                      color: Colors.white, size: 16),
                                  SizedBox(width: 5),
                                  Text('Featured',
                                      style: TextStyle(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['title'] ?? 'No title',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            car['price'] ?? 'No price',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 245, 137, 42),
                            ),
                          ),
                          const SizedBox(height: 10),
                          CarDetailsTable(car: car),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 245, 137, 42),
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _launchPhoneCall('+256780619890');
                                  },
                                  child: const Text(
                                    'Contact Seller',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () {
                                    _launchWhatsApp('+256780619890',
                                        'Hello, I am interested in the ${car['title']} hybrid car listed for ${car['price']}. Can you provide more details?');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.whatsapp,
                                          color: Colors.green.shade100),
                                      const SizedBox(width: 5),
                                      const Text('WhatsApp'),
                                    ],
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
            },
          );
        },
      ),
    );
  }
}

class ImageCarousel extends StatefulWidget {
  final List<String> images;

  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted && widget.images.isNotEmpty) {
        final nextIndex = (_currentIndex + 1) % widget.images.length;
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.asset(
              widget.images[index],
              width: double.infinity,
              fit: BoxFit.cover, // Changed to BoxFit.cover to fill the width
            );
          },
        ),
        Positioned(
          bottom: 10,
          left: 1,
          right: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _pageController.animateToPage(
                  entry.key,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CarDetailsTable extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailsTable({super.key, required this.car});

  @override
  _CarDetailsTableState createState() => _CarDetailsTableState();
}

class _CarDetailsTableState extends State<CarDetailsTable> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> initialDetails = [
      {
        'icon': Icons.confirmation_number,
        'label': 'Ref No',
        'value': widget.car['ref_no'] ?? 'N/A',
      },
      {
        'icon': Icons.speed,
        'label': 'Mileage',
        'value': '${widget.car['mileage'] ?? 'N/A'} km',
      },
      {
        'icon': Icons.settings,
        'label': 'Transmission',
        'value': widget.car['transmission'] ?? 'N/A',
      },
      {
        'icon': Icons.local_gas_station,
        'label': 'Fuel',
        'value': widget.car['fuel'] ?? 'N/A',
      },
    ];

    final List<Map<String, dynamic>> additionalDetails = [
      {
        'icon': Icons.directions_car,
        'label': 'Chassis No',
        'value': widget.car['chassis_no'] ?? 'N/A',
      },
      {
        'icon': Icons.model_training,
        'label': 'Model Code',
        'value': widget.car['model_code'] ?? 'N/A',
      },
      {
        'icon': Icons.engineering,
        'label': 'Engine Code',
        'value': widget.car['engine_code'] ?? 'N/A',
      },
      {
        'icon': Icons.engineering,
        'label': 'Engine Size',
        'value': '${widget.car['engine_size'] ?? 'N/A'}cc',
      },
      {
        'icon': Icons.color_lens,
        'label': 'Color',
        'value': widget.car['ext_color'] ?? 'N/A',
      },
      {
        'icon': Icons.location_on,
        'label': 'Location',
        'value': widget.car['location'] ?? 'N/A',
      },
      {
        'icon': Icons.event,
        'label': 'Reg Year',
        'value': widget.car['registration_year_month'] ?? 'N/A',
      },
      {
        'icon': Icons.build,
        'label': 'Mfg Year',
        'value': widget.car['manufacture_year_month'] ?? 'N/A',
      },
      {
        'icon': Icons.drive_eta,
        'label': 'Drive',
        'value': widget.car['drive'] ?? 'N/A',
      },
      {
        'icon': Icons.door_sliding,
        'label': 'Doors',
        'value': '${widget.car['doors'] ?? 'N/A'}',
      },
      {
        'icon': Icons.airline_seat_recline_normal,
        'label': 'Seats',
        'value': '${widget.car['seats'] ?? 'N/A'}',
      },
      {
        'icon': Icons.directions_car,
        'label': 'Steering',
        'value': widget.car['steering'] ?? 'N/A',
      },
      {
        'icon': Icons.square_foot,
        'label': 'Dimensions',
        'value': widget.car['dimensions'] ?? 'N/A',
      },
      {
        'icon': Icons.fitness_center,
        'label': 'Weight',
        'value': '${widget.car['weight'] ?? 'N/A'} kg',
      },
      {
        'icon': Icons.cable,
        'label': 'M3',
        'value': '${widget.car['m3'] ?? 'N/A'}',
      },
      {
        'icon': Icons.opacity,
        'label': 'Max Cap',
        'value': widget.car['max_cap'] ?? 'N/A',
      },
      {
        'icon': Icons.subtitles,
        'label': 'Sub Ref No',
        'value': widget.car['sub_ref_no'] ?? 'N/A',
      },
    ];

    final List<Map<String, dynamic>> displayedDetails = [
      ...initialDetails,
      if (_isExpanded) ...additionalDetails,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FixedColumnWidth(40),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(3),
          },
          children: displayedDetails.asMap().entries.map((entry) {
            final detail = entry.value;
            return TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    detail['icon'],
                    size: 16,
                    color: const Color.fromARGB(255, 245, 137, 42),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    detail['label'],
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    detail['value'],
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'See Less' : 'See More',
            style: const TextStyle(
              color: Color.fromARGB(255, 245, 137, 42),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

































// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../services/hybrid_car_service.dart'; // Import the new service
// import 'dart:async'; // For Timer

// class HybridCarsScreen extends StatefulWidget {
//   const HybridCarsScreen({super.key});

//   @override
//   State<HybridCarsScreen> createState() => _HybridCarsScreenState();
// }

// class _HybridCarsScreenState extends State<HybridCarsScreen> {
//   late Future<List<Map<String, dynamic>>> _hybridCarsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _hybridCarsFuture = HybridCarService.fetchHybridCars();
//   }

//   // Function to launch phone call
//   Future<void> _launchPhoneCall(String phoneNumber) async {
//     final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
//     if (await canLaunchUrl(phoneUri)) {
//       await launchUrl(phoneUri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not launch phone call')),
//       );
//     }
//   }

//   // Function to launch WhatsApp
//   Future<void> _launchWhatsApp(String phoneNumber, String message) async {
//     final Uri whatsappUri = Uri.parse(
//       'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
//     );
//     if (await canLaunchUrl(whatsappUri)) {
//       await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not launch WhatsApp')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hybrid Cars'),
//         backgroundColor: const Color.fromARGB(255, 248, 139, 37),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _hybridCarsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             print("Snapshot error: ${snapshot.error}");
//             String errorMessage = snapshot.error.toString();
//             return Center(
//                 child: Text('Error loading hybrid cars: $errorMessage'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(child: Text('No hybrid cars available'));
//           }

//           final hybridCars = snapshot.data!;
//           return ListView.builder(
//             itemCount: hybridCars.length,
//             itemBuilder: (context, index) {
//               final car = hybridCars[index];
//               final images = [
//                 car['image_front'],
//                 car['image_back'],
//                 car['image_inside'],
//                 car['image_beside'],
//                 car['image_full'],
//               ].where((image) => image != null && image.isNotEmpty).toList();

//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: images.isNotEmpty
//                               ? SizedBox(
//                                   height: 200,
//                                   width: double.infinity,
//                                   child: ImageCarousel(
//                                     images: images.cast<String>(),
//                                   ),
//                                 )
//                               : const Icon(Icons.image_not_supported,
//                                   size: 200),
//                         ),
//                         if (car['featured'] == 1 || car['featured'] == true)
//                           Positioned(
//                             top: 10,
//                             left: 10,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 10, vertical: 5),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: const Row(
//                                 children: [
//                                   Icon(Icons.thumb_up,
//                                       color: Colors.white, size: 16),
//                                   SizedBox(width: 5),
//                                   Text('Featured',
//                                       style: TextStyle(color: Colors.white)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             car['title'] ?? 'No title',
//                             style: const TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             car['price'] ?? 'No price',
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue),
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.confirmation_number,
//                                   car['ref_no'] ?? 'N/A', 'Ref No'),
//                               _carDetail(Icons.directions_car,
//                                   car['chassis_no'] ?? 'N/A', 'Chassis No'),
//                               _carDetail(Icons.model_training,
//                                   car['model_code'] ?? 'N/A', 'Model Code'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.speed,
//                                   '${car['mileage'] ?? 'N/A'} km', 'Mileage'),
//                               _carDetail(Icons.settings,
//                                   car['transmission'] ?? 'N/A', 'Transmission'),
//                               _carDetail(Icons.local_gas_station,
//                                   car['fuel'] ?? 'N/A', 'Fuel'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.engineering,
//                                   car['engine_code'] ?? 'N/A', 'Engine Code'),
//                               _carStyle(
//                                   Icons.engineering,
//                                   '${car['engine_size'] ?? 'N/A'}cc',
//                                   'Engine Size'),
//                               _carDetail(Icons.color_lens,
//                                   car['ext_color'] ?? 'N/A', 'Color'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.location_on,
//                                   car['location'] ?? 'N/A', 'Location'),
//                               _carDetail(
//                                   Icons.event,
//                                   car['registration_year_month'] ?? 'N/A',
//                                   'Reg Year'),
//                               _carDetail(
//                                   Icons.build,
//                                   car['manufacture_year_month'] ?? 'N/A',
//                                   'Mfg Year'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.drive_eta, car['drive'] ?? 'N/A',
//                                   'Drive'),
//                               _carDetail(Icons.door_sliding,
//                                   '${car['doors'] ?? 'N/A'}', 'Doors'),
//                               _carDetail(Icons.airline_seat_recline_normal,
//                                   '${car['seats'] ?? 'N/A'}', 'Seats'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(Icons.directions_car,
//                                   car['steering'] ?? 'N/A', 'Steering'),
//                               _carDetail(Icons.square_foot,
//                                   car['dimensions'] ?? 'N/A', 'Dimensions'),
//                               _carDetail(Icons.fitness_center,
//                                   '${car['weight'] ?? 'N/A'} kg', 'Weight'),
//                             ],
//                           ),
//                           const SizedBox(height: 5),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _carDetail(
//                                   Icons.cable, '${car['m3'] ?? 'N/A'}', 'M3'),
//                               _carDetail(Icons.opacity, car['max_cap'] ?? 'N/A',
//                                   'Max Cap'),
//                               _carDetail(Icons.subtitles,
//                                   car['sub_ref_no'] ?? 'N/A', 'Sub Ref No'),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor:
//                                         const Color.fromARGB(255, 245, 137, 42),
//                                     foregroundColor: Colors.black,
//                                   ),
//                                   onPressed: () {
//                                     // Replace with the actual seller's phone number
//                                     _launchPhoneCall('+256780619890');
//                                   },
//                                   child: const Text('Contact Seller'),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.green,
//                                     foregroundColor: Colors.white,
//                                   ),
//                                   onPressed: () {
//                                     // Replace with the actual seller's phone number
//                                     _launchWhatsApp(
//                                         '+256780619890',
//                                         'Hello, I am interested in the ${car['title']} hybrid car listed for ${car['price']}. Can you provide more details?');
//                                   },
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(FontAwesomeIcons.whatsapp,
//                                           color: Colors.green.shade100),
//                                       const SizedBox(width: 5),
//                                       const Text('WhatsApp'),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _carDetail(IconData icon, String text, String label) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: Colors.grey),
//             const SizedBox(width: 5),
//             Text(text,
//                 style: const TextStyle(fontSize: 14, color: Colors.black)),
//           ],
//         ),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }

//   Widget _carStyle(IconData icon, String text, String label) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Icon(icon, size: 16, color: Colors.grey),
//             const SizedBox(width: 5),
//             Text(text,
//                 style: const TextStyle(fontSize: 14, color: Colors.black)),
//           ],
//         ),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12, color: Colors.grey),
//         ),
//       ],
//     );
//   }
// }

// // Custom ImageCarousel widget using PageView
// class ImageCarousel extends StatefulWidget {
//   final List<String> images;

//   const ImageCarousel({super.key, required this.images});

//   @override
//   State<ImageCarousel> createState() => _ImageCarouselState();
// }

// class _ImageCarouselState extends State<ImageCarousel> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     // Auto-play every 3 seconds
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       if (mounted && widget.images.isNotEmpty) {
//         final nextIndex = (_currentIndex + 1) % widget.images.length;
//         _pageController.animateToPage(
//           nextIndex,
//           duration: const Duration(milliseconds: 300),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         PageView.builder(
//           controller: _pageController,
//           itemCount: widget.images.length,
//           onPageChanged: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           itemBuilder: (context, index) {
//             return Image.network(
//               widget.images[index],
//               width: double.infinity,
//               fit: BoxFit.cover,
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) return child;
//                 return const Center(child: CircularProgressIndicator());
//               },
//               errorBuilder: (context, error, stackTrace) {
//                 print("Error loading image: $error");
//                 return const Icon(Icons.error, size: 50, color: Colors.red);
//               },
//             );
//           },
//         ),
//         Positioned(
//           bottom: 10,
//           left: 0,
//           right: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: widget.images.asMap().entries.map((entry) {
//               return GestureDetector(
//                 onTap: () => _pageController.animateToPage(
//                   entry.key,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                 ),
//                 child: Container(
//                   width: 8,
//                   height: 8,
//                   margin: const EdgeInsets.symmetric(horizontal: 4),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: _currentIndex == entry.key
//                         ? Colors.white
//                         : Colors.white.withOpacity(0.4),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ],
//     );
//   }
// }