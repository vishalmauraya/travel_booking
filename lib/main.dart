import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/trips_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const TripsApp());
}

class TripsApp extends StatelessWidget {
  const TripsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TripsProvider(),
      child: MaterialApp(
        title: 'Trips & Bookings',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
