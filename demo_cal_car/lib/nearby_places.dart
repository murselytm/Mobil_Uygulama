// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:demo_cal_car/nearby_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NearbyPlaces extends StatefulWidget {
  const NearbyPlaces({super.key});

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  String apiKey = "";
  String radius = "50";

  double latitude = 31.5111093;
  double longtiude = 74.27964;

  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yakın Yerler"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  getNearbyPlaces();
                },
                child: const Text("En Yakın Yere Götür")),
            if (nearbyPlacesResponse.results != null)
              for (int i = 0; i < nearbyPlacesResponse.results!.length; i++)
                nearbyPlacesWidget(nearbyPlacesResponse.results![i])
          ],
        ),
      ),
    );
  }

  void getNearbyPlaces() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' +
            latitude.toString() +
            ',' +
            longtiude.toString() +
            '' +
            '&radius=' +
            radius +
            '&key=' +
            apiKey);

    var response = await http.post(url);
    nearbyPlacesResponse =
        NearbyPlacesResponse.fromJson(jsonDecode(response.body));
    setState(() {});
  }

  nearbyPlacesWidget(Results results) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("Name " + results.name!),
          Text("Result: " +
              results.geometry!.location!.lat.toString() +
              " ," +
              results.geometry!.location!.lng.toString()),
          Text(results.openingHours != null ? "Open" : "Closed")
        ],
      ),
    );
  }
}
