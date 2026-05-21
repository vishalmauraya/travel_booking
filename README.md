# Trips & Bookings

A mini Flutter app built for the **Flutter Developer Test** assignment. It includes three screens—Login, Home (trips list), and Trip Details—with form validation, search, and in-app status updates.

## Overview

| Screen | Description |
|--------|-------------|
| **Login** | Email and password fields with validation. On success, navigates to Home (no real backend auth). |
| **Home** | Displays trips from mock JSON. Search filters by trip title. Tap a trip to open details. |
| **Trip Details** | Shows all trip fields. Booked trips can be marked **Completed** or **Cancelled**; the home list updates immediately. |

## Tech stack

- **Flutter** (Material 3)
- **State management:** [`provider`](https://pub.dev/packages/provider) + `ChangeNotifier` (`TripsProvider`)

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Android SDK (for emulator or APK build), or a connected device

Check your setup:

```bash
flutter doctor
```

## Getting started

```bash
# Clone the repo, then:
cd travel_booking
flutter pub get
flutter run
```

## Usage

### Login

- **Email:** must be a valid format (e.g. `user@example.com`)
- **Password:** minimum 6 characters (e.g. `password`)
- Tap **Login** to open the trips list

### Home

- Scroll the list of trips (title, date, status badge)
- Use the search bar to filter by title (case-insensitive, contains match)
- Tap any trip to open **Trip Details**

### Trip Details

- View: title, date, status, pickup, drop-off, trip ID
- If status is **Booked**, use **Change Status** to set **Completed** or **Cancelled**
- Press back—the Home list reflects the new status

## Mock data

Trips are defined in `lib/data/mock_trips.dart`:

```json
[
  {"id": 1, "title": "Downtown Seattle to Sea-Tac", "date": "2026-01-20", "status": "Booked", "pickup": "Hotel A", "drop": "Sea-Tac"},
  {"id": 2, "title": "Sea-Tac to Downtown Seattle", "date": "2026-01-22", "status": "Completed", "pickup": "Sea-Tac", "drop": "Hotel B"},
  {"id": 3, "title": "Private Car: Bellevue to Sea-Tac", "date": "2026-01-25", "status": "Booked", "pickup": "Bellevue", "drop": "Sea-Tac"}
]
```

## Project structure

```
lib/
├── main.dart
├── models/
│   └── trip.dart
├── data/
│   └── mock_trips.dart
├── providers/
│   └── trips_provider.dart
└── screens/
    ├── login_screen.dart
    ├── home_screen.dart
    └── trip_details_screen.dart
```

## Build release APK (Android)

```bash
flutter build apk --release
```

APK path:

```
build/app/outputs/flutter-apk/app-release.apk
```

## Tests & analysis

```bash
flutter analyze
flutter test
```

## Implementation notes

- No real authentication or REST API—login is UI validation only, as required by the brief.
- Status transitions are limited to **Booked** → **Completed** or **Cancelled**; completed/cancelled trips cannot be changed again.
- Shared trip state lives in `TripsProvider` so Home and Details stay in sync without passing results through navigation.

## Submission checklist

- [ ] GitHub repository link (public or private)
- [ ] Release APK (`app-release.apk`)
- [ ] This README with setup and usage notes
