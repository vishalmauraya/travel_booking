import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:travel_booking/providers/trips_provider.dart';
import 'package:travel_booking/screens/login_screen.dart';

void main() {
  testWidgets('Login screen shows email and password fields', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TripsProvider(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
  });
}
