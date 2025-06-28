Vehicle Tracking System (Flutter + Firebase)
A real-time vehicle tracking mobile application built with Flutter and Firebase, designed for two types of users: Drivers and Vehicle Owners.

🚀 Features
Real-time GPS Tracking:

Drivers' locations are updated live on the map.

Owners can view all active trips.

Trip History & Analytics:

Owners access detailed trip reports (route, distance, duration).

User Roles:

Driver: Shares location/starts trips.

Owner: Monitors drivers/views trip history.

Firebase Integration:

Authentication (Email/Google).

Firestore (Storing trips, users).

Realtime Database/Cloud Functions (Optional for live updates).

Map Integration:

Google Maps API or Mapbox (showing routes, markers).

📸 Screenshots
https://mostaql.com/portfolio/2267409-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82-%D8%AA%D8%AA%D8%A8%D8%B9-%D8%A7%D9%84%D9%85%D8%B1%D9%83%D8%A8%D8%A7%D8%AA

🔧 Tech Stack
Frontend: Flutter (iOS & Android).

Backend: Firebase (Auth, Firestore, Cloud Messaging).

Maps: Google Maps SDK/Mapbox.

State Management: Provider/Riverpod.

⚙️ Setup
Clone the repo:

bash
[git clone [https://github.com/SAEED-K-24/vehicle_tracking_app.git]
Install dependencies:

bash
flutter pub get

Configure Firebase:

Add your google-services.json (Android) and GoogleService-Info.plist (iOS).

Enable Firebase Auth and Firestore.
