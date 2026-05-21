# Trips & Bookings

Mini Flutter app for the **Flutter Developer Test** — login, trips list with search, and trip details with status updates.

## Features

| Screen | Behavior |
|--------|----------|
| **Login** | Email format + password (min 6 chars) validation; navigates to Home on success (no backend auth). |
| **Home** | Lists mock trips (title, date, status); search bar filters by title (contains, case-insensitive). |
| **Trip Details** | All trip fields; **Booked** trips can change to **Completed** or **Cancelled** via dropdown; list updates immediately via `ChangeNotifier`. |

## State management

[`provider`](https://pub.dev/packages/provider) + `ChangeNotifier` (`TripsProvider`) holds trip list, search query, and status updates shared across Home and Details.

## Mock data

Trips are loaded from `lib/data/mock_trips.dart` (same JSON as in the test brief).

## Run locally

```bash
flutter pub get
flutter run
```

## Build APK (Android)

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

## Project structure

```
lib/
  main.dart
  models/trip.dart
  data/mock_trips.dart
  providers/trips_provider.dart
  screens/
    login_screen.dart
    home_screen.dart
    trip_details_screen.dart
```

## Test credentials

Any valid email (e.g. `user@example.com`) and password with 6+ characters (e.g. `password`).

## Notes

- No real authentication or API — UI-only flow as specified.
- Status changes apply only when current status is **Booked**.
