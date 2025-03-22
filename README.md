# Car Rental App

## Overview

The Car Rental App is a Flutter-based mobile application designed to facilitate the renting and listing of cars. It follows Clean Architecture principles and leverages Firebase for authentication, data storage, and notifications. The app enables users to search for available cars, book them, and make payments, while also allowing car owners to list their vehicles and manage bookings.

## Features

- **User Authentication:** Firebase Authentication for secure login and sign-up.
- **Car Search:** Search for cars by location using Google API.
- **Booking System:** Users can book available cars, and owners can approve or deny requests.
- **Payments:** Integrated with Razorpay for seamless transactions.
- **Car Registration:** Owners can register their cars for rental.
- **Revenue Tracking:** Owners can check their generated revenue.
- **Notifications:** Firebase Cloud Messaging for real-time updates.

## Tech Stack

- **Flutter** (for cross-platform mobile development)
- **Firebase**
  - Authentication
  - Firestore Database
  - Cloud Storage
  - Cloud Messaging (FCM)
- **Google API** (for location-based car search)
- **Razorpay** (for handling payments)
- **Clean Architecture** (ensuring modularity and maintainability)

## App Flow

The following diagram illustrates the overall flow of the Car Rental App:



### User Journey

1. **Login/Register** via Firebase Authentication.
2. **Customer Role:**
   - Access the Customer Home Screen.
   - Search for cars by location.
   - Book an available car.
   - Wait for owner approval.
   - Make payment upon approval.
   - View all bookings.
3. **Owner Role:**
   - Register a car.
   - Approve or deny booking requests.
   - Track revenue generated.

## Installation & Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/CarRentalApp.git
   cd CarRentalApp
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Configure Firebase:
   - Set up a Firebase project.
   - Enable Authentication (Email/Google Sign-in).
   - Configure Firestore and Cloud Storage.
   - Enable Firebase Cloud Messaging (FCM).
4. Run the app:
   ```sh
   flutter run
   ```

## Contribution

Feel free to contribute to the project by submitting issues or pull requests.

## License

This project is licensed under the MIT License.
