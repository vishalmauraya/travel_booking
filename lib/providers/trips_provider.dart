import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../data/mock_trips.dart';
import '../models/trip.dart';

class TripsProvider extends ChangeNotifier {
  TripsProvider() {
    final list = jsonDecode(mockTripsJson) as List<dynamic>;
    _trips = list.map((e) => Trip.fromJson(e as Map<String, dynamic>)).toList();
  }

  late List<Trip> _trips;
  String _searchQuery = '';

  List<Trip> get trips => List.unmodifiable(_trips);

  String get searchQuery => _searchQuery;

  List<Trip> get filteredTrips {
    if (_searchQuery.isEmpty) return trips;
    final query = _searchQuery.toLowerCase();
    return _trips
        .where((trip) => trip.title.toLowerCase().contains(query))
        .toList();
  }

  Trip? tripById(int id) {
    try {
      return _trips.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void updateTripStatus(int id, TripStatus status) {
    final index = _trips.indexWhere((t) => t.id == id);
    if (index == -1) return;
    _trips[index] = _trips[index].copyWith(status: status);
    notifyListeners();
  }
}
