import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LuxuryCarsScreen extends StatelessWidget {
  final List<Map<String, String>> cars = [
    {
      'image': 'lib/assets/luxury/car1.jpg',
      'title': '2023 Rolls-Royce Phantom',
      'price': 'USD 500,000',
    },
    {
      'image': 'lib/assets/luxury/car2.jpg',
      'title': '2023 Bentley Continental GT',
      'price': 'USD 250,000',
    },
    {
      'image': 'lib/assets/luxury/car3.jpg',
      'title': '2023 Lamborghini Aventador',
      'price': 'USD 400,000',
    },
    {
      'image': 'lib/assets/luxury/car4.jpg',
      'title': '2023 Ferrari SF90 Stradale',
      'price': 'USD 500,000',
    },
    {
      'image': 'lib/assets/luxury/car5.jpg',
      'title': '2023 Aston Martin DB11',
      'price': 'USD 230,000',
    },
    {
      'image': 'lib/assets/luxury/car6.jpg',
      'title': '2023 Mercedes-Benz Maybach S680',
      'price': 'USD 300,000',
    },
  ];

  LuxuryCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Luxury Cars'),
        backgroundColor: const Color.fromARGB(255, 243, 123, 10),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    cars[index]['image']!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cars[index]['title']!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        cars[index]['price']!,
                        style: TextStyle(fontSize: 19, color: Colors.blueAccent),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 232, 120, 35)),
                            child: Text('Contact Seller', style: TextStyle(color: Colors.black)),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.whatsapp, color: Colors.green.shade100,),
                                
                                SizedBox(width: 5),
                                Text('WhatsApp', style: TextStyle(color: Colors.white)),
                              ],
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
}
