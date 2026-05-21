import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip.dart';
import '../providers/trips_provider.dart';
import 'trip_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color _statusColor(TripStatus status, ColorScheme scheme) {
    switch (status) {
      case TripStatus.booked:
        return scheme.primary;
      case TripStatus.completed:
        return Colors.green;
      case TripStatus.cancelled:
        return scheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Trips'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search trips by title...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                isDense: true,
              ),
              onChanged: context.read<TripsProvider>().setSearchQuery,
            ),
          ),
          Expanded(
            child: Consumer<TripsProvider>(
              builder: (context, provider, _) {
                final trips = provider.filteredTrips;
                if (trips.isEmpty) {
                  return Center(
                    child: Text(
                      provider.searchQuery.isEmpty
                          ? 'No trips available'
                          : 'No trips match your search',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: trips.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    final scheme = Theme.of(context).colorScheme;
                    return Card(
                      child: ListTile(
                        title: Text(
                          trip.title,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(trip.date),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor(trip.status, scheme)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            trip.status.label,
                            style: TextStyle(
                              color: _statusColor(trip.status, scheme),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  TripDetailsScreen(tripId: trip.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
