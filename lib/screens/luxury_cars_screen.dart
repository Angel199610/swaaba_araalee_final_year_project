import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/luxury_car_service.dart';
import 'dart:async'; // For Timer

class LuxuryCarsScreen extends StatefulWidget {
  const LuxuryCarsScreen({super.key});

  @override
  State<LuxuryCarsScreen> createState() => _LuxuryCarsScreenState();
}

class _LuxuryCarsScreenState extends State<LuxuryCarsScreen> {
  late Future<List<Map<String, dynamic>>> _luxuryCarsFuture;

  @override
  void initState() {
    super.initState();
    _luxuryCarsFuture = LuxuryCarService.fetchLuxuryCars();
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
        title: const Text('Luxury Cars'),
        backgroundColor: const Color.fromARGB(255, 243, 123, 10),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _luxuryCarsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print("Snapshot error: ${snapshot.error}");
            String errorMessage = snapshot.error.toString();
            return Center(
                child: Text('Error loading luxury cars: $errorMessage'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No luxury cars available'));
          }

          final luxuryCars = snapshot.data!;
          return ListView.builder(
            itemCount: luxuryCars.length,
            itemBuilder: (context, index) {
              final car = luxuryCars[index];
              final images = [
                car['image_front'],
                car['image_back'],
                car['image_inside'],
                car['image_beside'],
                car['image_full'],
              ].where((image) => image != null && image.isNotEmpty).toList();

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
                                  height: 200,
                                  width: double.infinity,
                                  child: ImageCarousel(
                                    images: images.cast<String>(),
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
                                color: Colors.blue,
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
                                color: Colors.blue),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.confirmation_number,
                                  car['ref_no'] ?? 'N/A', 'Ref No'),
                              _carDetail(Icons.directions_car,
                                  car['chassis_no'] ?? 'N/A', 'Chassis No'),
                              _carDetail(Icons.model_training,
                                  car['model_code'] ?? 'N/A', 'Model Code'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.speed,
                                  '${car['mileage'] ?? 'N/A'} km', 'Mileage'),
                              _carDetail(Icons.settings,
                                  car['transmission'] ?? 'N/A', 'Transmission'),
                              _carDetail(Icons.local_gas_station,
                                  car['fuel'] ?? 'N/A', 'Fuel'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.engineering,
                                  car['engine_code'] ?? 'N/A', 'Engine Code'),
                              _carStyle(
                                  Icons.engineering,
                                  '${car['engine_size'] ?? 'N/A'}cc',
                                  'Engine Size'),
                              _carDetail(Icons.color_lens,
                                  car['ext_color'] ?? 'N/A', 'Color'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.location_on,
                                  car['location'] ?? 'N/A', 'Location'),
                              _carDetail(
                                  Icons.event,
                                  car['registration_year_month'] ?? 'N/A',
                                  'Reg Year'),
                              _carDetail(
                                  Icons.build,
                                  car['manufacture_year_month'] ?? 'N/A',
                                  'Mfg Year'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.drive_eta, car['drive'] ?? 'N/A',
                                  'Drive'),
                              _carDetail(Icons.door_sliding,
                                  '${car['doors'] ?? 'N/A'}', 'Doors'),
                              _carDetail(Icons.airline_seat_recline_normal,
                                  '${car['seats'] ?? 'N/A'}', 'Seats'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(Icons.directions_car,
                                  car['steering'] ?? 'N/A', 'Steering'),
                              _carDetail(Icons.square_foot,
                                  car['dimensions'] ?? 'N/A', 'Dimensions'),
                              _carDetail(Icons.fitness_center,
                                  '${car['weight'] ?? 'N/A'} kg', 'Weight'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _carDetail(
                                  Icons.cable, '${car['m3'] ?? 'N/A'}', 'M3'),
                              _carDetail(Icons.opacity, car['max_cap'] ?? 'N/A',
                                  'Max Cap'),
                              _carDetail(Icons.subtitles,
                                  car['sub_ref_no'] ?? 'N/A', 'Sub Ref No'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 232, 120, 35),
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    _launchPhoneCall('+256780619890');
                                  },
                                  child: const Text('Contact Seller'),
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
                                    _launchWhatsApp(
                                        '+256780619890',
                                        'Hello, I am interested in the ${car['title']} luxury car listed for ${car['price']}. Can you provide more details?');
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

  Widget _carDetail(IconData icon, String text, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 5),
            Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _carStyle(IconData icon, String text, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey),
            const SizedBox(width: 5),
            Text(text,
                style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

// Custom ImageCarousel widget using PageView
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
    // Auto-play every 3 seconds
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
            return Image.network(
              widget.images[index],
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                print("Error loading image: $error");
                return const Icon(Icons.error, size: 50, color: Colors.red);
              },
            );
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
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