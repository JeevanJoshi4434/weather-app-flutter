import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String image;
  final String val;
  const HourlyForecast({
    super.key,
    required this.time,
    required this.image,
    required this.val,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        height: 170,
        width: 150,
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              image,
              scale: 5,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '$val ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
