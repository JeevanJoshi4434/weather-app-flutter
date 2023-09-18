import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_forcast/APIs/Secrets.dart';
import 'package:weather_forcast/Screens/additional_info_item.dart';
import 'package:weather_forcast/Screens/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherHomeScreen extends StatefulWidget {
  const WeatherHomeScreen({super.key});

  @override
  State<WeatherHomeScreen> createState() => _WeatherHomeScreenState();
}

class _WeatherHomeScreenState extends State<WeatherHomeScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Bhowali';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPI'),
      );
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
      // temp = data['list'][0]['main']['temp'] - 273.5;
    } catch (e) {
      throw e.toString();
    }
  }

  String getMonth(int num) {
    switch (num) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
    }
    return 'Dec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: getCurrentWeather, icon: const Icon(Icons.refresh))
          ],
          title: const Text(
            "Weather App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            final data = snapshot.data;
            final currentTemp = data?['list'][1]['main']['temp'];
            final humidity = data?['list'][1]['main']['humidity'];
            final pressure = data?['list'][1]['main']['pressure'];
            final speed = data?['list'][1]['wind']['speed'];
            final currentTemp2 = data?['list'][2]['main']['temp'];
            final currentTemp3 = data?['list'][3]['main']['temp'];
            final currentTemp4 = data?['list'][4]['main']['temp'];
            final currentTemp5 = data?['list'][5]['main']['temp'];
            final currentTemp6 = data?['list'][6]['main']['temp'];
            final double currentTempCelcius =
                data?['list'][0]['main']['temp'] - 273.15;
            final currentSky = data?['list'][1]['weather'][0]['main'];
            final currentSky2 = data?['list'][2]['weather'][0]['main'];
            final currentSky3 = data?['list'][3]['weather'][0]['main'];
            final currentSky4 = data?['list'][4]['weather'][0]['main'];
            final currentSky5 = data?['list'][5]['weather'][0]['main'];
            final currentSky6 = data?['list'][6]['weather'][0]['main'];
            final String dateTime = data?['list'][2]['dt_txt'];
            final String dateTime2 = data?['list'][3]['dt_txt'];
            final String dateTime3 = data?['list'][4]['dt_txt'];
            final String dateTime4 = data?['list'][5]['dt_txt'];
            final String dateTime5 = data?['list'][6]['dt_txt'];
            final dateStamp = DateTime.parse(dateTime);
            final dateStamp2 = DateTime.parse(dateTime2);
            final dateStamp3 = DateTime.parse(dateTime3);
            final dateStamp4 = DateTime.parse(dateTime4);
            final dateStamp5 = DateTime.parse(dateTime5);
            final String timeStamp = '${dateStamp.hour}:00';
            final String timeStamp2 = '${dateStamp2.hour}:00';
            final String timeStamp3 = '${dateStamp3.hour}:00';
            final String timeStamp4 = '${dateStamp4.hour}:00';
            final String timeStamp5 = '${dateStamp5.hour}:00';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // main card
                  Container(
                    width: double.infinity,
                    height: 300,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$currentTemp° K",
                                style: const TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "/ ${currentTempCelcius.toStringAsFixed(2)}° C",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            'assets/images/cloudy-day.png',
                            scale: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '$currentSky $dateTime',
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // weather forecast
                  const Text("Weather Forecast",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      HourlyForecast(
                        time: '$timeStamp ',
                        image: 'assets/images/day-night.png',
                        val: '$currentTemp2° K $currentSky2',
                      ),
                      HourlyForecast(
                        time: '$timeStamp2 ',
                        image: 'assets/images/day-night.png',
                        val: '$currentTemp3° K $currentSky3',
                      ),
                      HourlyForecast(
                        time: '$timeStamp3 ',
                        image: 'assets/images/day-night.png',
                        val: '$currentTemp4° K $currentSky4',
                      ),
                      HourlyForecast(
                        time: '$timeStamp4 ',
                        image: 'assets/images/day-night.png',
                        val: '$currentTemp5° K $currentSky5',
                      ),
                      HourlyForecast(
                        time: '$timeStamp5 ',
                        image: 'assets/images/day-night.png',
                        val: '$currentTemp6° K $currentSky6',
                      )
                    ]),
                  ),
                  // additional Info
                  const SizedBox(
                    height: 20,
                  ),
                  // weather forecast
                  const Text("Additional Information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalInfo(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            val: '$humidity '),
                        AdditionalInfo(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            val: '$speed km/hr'),
                        AdditionalInfo(
                            icon: Icons.beach_access,
                            label: 'Pressure',
                            val: '$pressure '),
                      ])
                ],
              ),
            );
          },
        ));
  }
}
