import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'map_view.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              iconSize: 50,
              color: Colors.deepPurple,
              icon: const Icon(Icons.navigation),
              onPressed: () {
                Get.to(() => const MapView()); // Navigate to MapView widget
              },
            ),
          ],
        ),
      ),
    );
  }
}
