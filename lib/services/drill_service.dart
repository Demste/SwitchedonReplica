import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:switchedon/globals.dart';
import 'package:switchedon/models/drill.dart';

class DrillService extends ChangeNotifier {
  Future<void> loadDrills() async {
    try {
      final response = await http.get(Uri.parse('https://fake-json-api.mock.beeceptor.com/users'));
      
      if (response.statusCode == 200) {
        // JSON verisini al
        final List<dynamic> decodedData = json.decode(response.body);
        // Verileri globalDrills listesine dönüştür
        globalDrills = getDrillsFromList(decodedData);
        notifyListeners(); // Veriler güncellenince dinleyicilere bildirim yapar
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Hata işleme
      print(e);
    }
  }

  List<Drill> getDrillsFromList(List<dynamic> data) {
    return data.map((item) {
      return Drill(
        id: item["id"],
        sport: "Basketball",
        type: item["email"] ?? "Unknown",
        level: item["name"] ?? "Unknown",
        name: item["name"] ?? "No Name",
        tags: ['Passing'],
        banner: item["name"] ?? "No Banner",
        directions: item["name"] ?? "No Directions",
      );
    }).toList();
  }
  
}
