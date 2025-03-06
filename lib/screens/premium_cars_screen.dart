import 'package:flutter/material.dart';

class PremiumCarsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cars = [
    {
      "image": "lib/assets/premium/car1.jpeg",
      "title": "2021 BMW 5 Series 530i",
      "price": "RM 250,000",
      "mileage": "30 - 40K KM",
      "transmission": "Automatic",
      "engine": "1998 cc",
      "color": "Black",
      "location": "Kuala Lumpur"
    },
    {
      "image": "lib/assets/premium/car2.jpg",
      "title": "2022 Mercedes-Benz E300 AMG",
      "price": "RM 320,000",
      "mileage": "10 - 15K KM",
      "transmission": "Automatic",
      "engine": "1991 cc",
      "color": "Silver",
      "location": "Petaling Jaya"
    },
    {
      "image": "lib/assets/premium/car3.jpg",
      "title": "2023 Audi A6 3.0 TFSI Quattro",
      "price": "RM 350,000",
      "mileage": "5 - 10K KM",
      "transmission": "Automatic",
      "engine": "2995 cc",
      "color": "Blue",
      "location": "Seremban"
    },
    {
      "image": "lib/assets/premium/car4.jpg",
      "title": "2023 Audi A6 3.0 TFSI Quattro",
      "price": "RM 350,000",
      "mileage": "5 - 10K KM",
      "transmission": "Automatic",
      "engine": "2995 cc",
      "color": "Blue",
      "location": "Seremban"
    },
    {
      "image": "lib/assets/premium/car5.jpg",
      "title": "2023 Audi A6 3.0 TFSI Quattro",
      "price": "RM 350,000",
      "mileage": "5 - 10K KM",
      "transmission": "Automatic",
      "engine": "2995 cc",
      "color": "Blue",
      "location": "Seremban"
    }
  ];

  PremiumCarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premium Cars"),
        backgroundColor: const Color.fromARGB(255, 248, 139, 37),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(car["image"],
                    fit: BoxFit.cover, height: 200, width: double.infinity),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car["title"],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(car["price"],
                          style: TextStyle(fontSize: 16, color: Colors.blue)),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.speed, size: 18),
                          SizedBox(width: 5),
                          Text(car["mileage"]),
                          SizedBox(width: 15),
                          Icon(Icons.settings, size: 18),
                          SizedBox(width: 5),
                          Text(car["transmission"]),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.local_gas_station, size: 18),
                          SizedBox(width: 5),
                          Text(car["engine"]),
                          SizedBox(width: 15),
                          Icon(Icons.color_lens, size: 18),
                          SizedBox(width: 5),
                          Text(car["color"]),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 18),
                          SizedBox(width: 5),
                          Text(car["location"]),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 242, 141, 40)),
                            child: Text(
                              "Contact Seller",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: Text(
                              "WhatsApp",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
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

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PremiumCarsScreen(),
  ));
}


