enum TripStatus {
  booked,
  cancelled,
  completed;

  static TripStatus fromString(String value) {
    switch (value.toLowerCase()) {
      case 'booked':
        return TripStatus.booked;
      case 'cancelled':
        return TripStatus.cancelled;
      case 'completed':
        return TripStatus.completed;
      default:
        throw ArgumentError('Unknown trip status: $value');
    }
  }

  String get label {
    switch (this) {
      case TripStatus.booked:
        return 'Booked';
      case TripStatus.cancelled:
        return 'Cancelled';
      case TripStatus.completed:
        return 'Completed';
    }
  }
}

class Trip {
  const Trip({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.pickup,
    required this.drop,
  });

  final int id;
  final String title;
  final String date;
  final TripStatus status;
  final String pickup;
  final String drop;

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'] as int,
      title: json['title'] as String,
      date: json['date'] as String,
      status: TripStatus.fromString(json['status'] as String),
      pickup: json['pickup'] as String,
      drop: json['drop'] as String,
    );
  }

  Trip copyWith({TripStatus? status}) {
    return Trip(
      id: id,
      title: title,
      date: date,
      status: status ?? this.status,
      pickup: pickup,
      drop: drop,
    );
  }
}
