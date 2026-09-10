# Platinum App

A modern Flutter-based real estate platform designed to provide users with a complete property discovery and management experience.

The application allows users to explore properties and units, view detailed information, manage favorites, place orders, book appointments, explore offers and services, and access property-related services through a unified mobile experience.

## Features

* 🏢 Property and unit browsing
* 🔎 Property search and filtering
* 📋 Detailed unit information
* ❤️ Favorites management
* 📦 Unit orders and order tracking
* 📅 Appointment booking
* 🏷️ Offers and discounts
* 🛠️ Property services and solutions
* 📄 Contracts and payment management
* 🗺️ Property location and map integration
* 🌐 Arabic & English localization
* 🌙 Light & dark mode
* 🔔 Push notifications
* 🔐 Secure authentication and token management
* 📸 360° panorama property viewing
* 📄 Paginated property listings

## Architecture

The application follows a scalable feature-based architecture with **MVVM and BLoC/Cubit** for state management.

Each feature is organized into separate layers:

```text
feature/
├── data/
│   ├── models/
│   └── repositories/
├── logic/
│   ├── cubit/
│   └── states/
└── ui/
    ├── screens/
    └── widgets/
```

This structure helps keep the codebase maintainable, testable, and easy to extend.

## Tech Stack

* **Flutter & Dart**
* **BLoC / Cubit**
* **MVVM**
* **Dio**
* **Retrofit**
* **GetIt**
* **Freezed**
* **JSON Serialization**
* **Firebase**
* **REST APIs**
* **Easy Localization**
* **Flutter ScreenUtil**
* **Git & GitHub**

## Backend Integration

The application communicates with a RESTful backend to handle:

* User authentication
* Properties and units
* Favorites
* Orders
* Appointments
* Offers
* Services
* Contracts
* Payments
* Notifications
* User profile management

Authentication includes secure access and refresh token handling.

## 360° Property Experience

The application includes an interactive **360° panorama viewer**, allowing users to explore supported properties in an immersive way directly from the mobile application.

## Localization & Theming

The application supports:

* Arabic and English
* Right-to-left (RTL) layouts
* Light and dark themes
* Responsive layouts across different screen sizes

## Project Structure

```text
lib/
├── core/
│   ├── di/
│   ├── networking/
│   ├── routing/
│   ├── theming/
│   └── ...
│
└── features/
    ├── authentication/
    ├── home/
    ├── units/
    ├── favorites/
    ├── orders/
    ├── appointments/
    ├── offers/
    ├── services/
    ├── contracts/
    ├── payments/
    ├── notifications/
    └── profile/
```

## Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* An Android or iOS development environment

### Installation

Clone the repository:

```bash
git clone https://github.com/odai-df/platinum_app.git
```

Navigate to the project:

```bash
cd platinum_app
```

Install dependencies:

```bash
flutter pub get
```

Generate required code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Run the application:

```bash
flutter run
```

## Screenshots

Screenshots of the application will be added here.

## Author

**Odai**

Flutter Developer

* GitHub: https://github.com/odai-df
* LinkedIn: Add your LinkedIn profile

## License

This project is for portfolio and demonstration purposes.
