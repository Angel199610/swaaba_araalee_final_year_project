import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopularFamilyCarsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> popularCars = [
    {
      'title': '2023 Toyota Prius Hybrid',
      'image': 'lib/assets/hybrid/car1.jpg', // Replace with actual image path
      'price': 'RM 125,800',
      'monthly': 'RM 1,200/month',
      'year': 2023,
      'mileage': '10 - 20K KM',
      'transmission': 'Automatic',
      'engine': '1800 cc Hybrid',
      'color': 'White',
      'location': 'Kuala Lumpur, Malaysia',
      'featured': true,
    },
    {
      'title': '2022 Honda Insight Hybrid',
      'image': 'lib/assets/hybrid/car2.jpg',
      'price': 'RM 110,500',
      'monthly': 'RM 1,050/month',
      'year': 2022,
      'mileage': '15 - 25K KM',
      'transmission': 'Automatic',
      'engine': '1500 cc Hybrid',
      'color': 'Silver',
      'location': 'Selangor, Malaysia',
      'featured': false,
    },
    {
      'title': '2021 Hyundai Ioniq Hybrid',
      'image': 'lib/assets/hybrid/car3.jpg',
      'price': 'RM 99,800',
      'monthly': 'RM 950/month',
      'year': 2021,
      'mileage': '30 - 40K KM',
      'transmission': 'Automatic',
      'engine': '1600 cc Hybrid',
      'color': 'Blue',
      'location': 'Penang, Malaysia',
      'featured': true,
    },
    {
      'title': '2021 Hyundai Ioniq Hybrid',
      'image': 'lib/assets/hybrid/car4.jpg',
      'price': 'RM 99,800',
      'monthly': 'RM 950/month',
      'year': 2021,
      'mileage': '30 - 40K KM',
      'transmission': 'Automatic',
      'engine': '1600 cc Hybrid',
      'color': 'Blue',
      'location': 'Penang, Malaysia',
      'featured': true,
    },
    {
      'title': '2021 Hyundai Ioniq Hybrid',
      'image': 'lib/assets/hybrid/car5.jpg',
      'price': 'RM 99,800',
      'monthly': 'RM 950/month',
      'year': 2021,
      'mileage': '30 - 40K KM',
      'transmission': 'Automatic',
      'engine': '1600 cc Hybrid',
      'color': 'Blue',
      'location': 'Penang, Malaysia',
      'featured': true,
    },
    {
      'title': '2021 Hyundai Ioniq Hybrid',
      'image': 'lib/assets/hybrid/car6.jpg',
      'price': 'RM 99,800',
      'monthly': 'RM 950/month',
      'year': 2021,
      'mileage': '30 - 40K KM',
      'transmission': 'Automatic',
      'engine': '1600 cc Hybrid',
      'color': 'Blue',
      'location': 'Penang, Malaysia',
      'featured': true,
    },
  ];

  PopularFamilyCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hybrid Cars'),
      ),
      body: ListView.builder(
        itemCount: popularCars.length,
        itemBuilder: (context, index) {
          final car = popularCars[index];

          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        car['image'],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (car['featured'])
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car['title'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(car['monthly'],
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Text(car['price'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _carDetail(Icons.calendar_today, '${car['year']}'),
                          _carDetail(Icons.speed, car['mileage']),
                          _carDetail(Icons.settings, car['transmission']),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _carDetail(Icons.electric_car, car['engine']),
                          _carDetail(Icons.color_lens, car['color']),
                          _carDetail(Icons.location_on, car['location']),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 241, 135, 43),
                                foregroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              child: Text('Contact Seller'),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.whatsapp,
                                      color: Colors.green.shade100),
                                  SizedBox(width: 5),
                                  Text('WhatsApp'),
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
      ),
    );
  }

  Widget _carDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 5),
        Text(text, style: TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }
}
