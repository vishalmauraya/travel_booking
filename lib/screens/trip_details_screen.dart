import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/trip.dart';
import '../providers/trips_provider.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key, required this.tripId});

  final int tripId;

  @override
  Widget build(BuildContext context) {
    return Consumer<TripsProvider>(
      builder: (context, provider, _) {
        final trip = provider.tripById(tripId);
        if (trip == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Trip Details')),
            body: const Center(child: Text('Trip not found')),
          );
        }
        return _TripDetailsBody(trip: trip);
      },
    );
  }
}

class _TripDetailsBody extends StatefulWidget {
  const _TripDetailsBody({required this.trip});

  final Trip trip;

  @override
  State<_TripDetailsBody> createState() => _TripDetailsBodyState();
}

class _TripDetailsBodyState extends State<_TripDetailsBody> {
  TripStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.trip.status;
  }

  @override
  void didUpdateWidget(covariant _TripDetailsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.trip.status != widget.trip.status) {
      _selectedStatus = widget.trip.status;
    }
  }

  List<DropdownMenuItem<TripStatus>> _statusOptions(Trip trip) {
    if (trip.status != TripStatus.booked) return [];
    return const [
      DropdownMenuItem(
        value: TripStatus.completed,
        child: Text('Completed'),
      ),
      DropdownMenuItem(
        value: TripStatus.cancelled,
        child: Text('Cancelled'),
      ),
    ];
  }

  void _onStatusChanged(TripStatus? newStatus) {
    if (newStatus == null || newStatus == widget.trip.status) return;
    setState(() => _selectedStatus = newStatus);
    context.read<TripsProvider>().updateTripStatus(widget.trip.id, newStatus);
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            trip.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          _DetailRow(label: 'Date', value: trip.date),
          _DetailRow(label: 'Status', value: trip.status.label),
          _DetailRow(label: 'Pickup', value: trip.pickup),
          _DetailRow(label: 'Drop-off', value: trip.drop),
          _DetailRow(label: 'Trip ID', value: trip.id.toString()),
          if (trip.status == TripStatus.booked) ...[
            const SizedBox(height: 32),
            Text(
              'Change Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TripStatus>(
                  isExpanded: true,
                  value: _selectedStatus == TripStatus.booked
                      ? null
                      : _selectedStatus,
                  hint: const Text('Select new status'),
                  items: _statusOptions(trip),
                  onChanged: _onStatusChanged,
                ),
              ),
            ),
          ] else ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Status cannot be changed (${trip.status.label})',
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
