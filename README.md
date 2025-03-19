# Investment Dashboard & Feature Screen (Flutter)

## Project Overview

This Flutter project provides a Dashboard Screen and a Feature Screen to manage and display investment opportunities using Riverpod for state management, Dio for API calls, and Flutter Secure Storage for authentication.

## Features

### Dashboard Screen:
- Displays a welcome message.
- Shows investment summary (total investments, total value).
- Fetches and lists top 3 investment opportunities.

### Feature Screen:
- Fetches investment opportunities from a simulated API.
- Displays investment details (name, description, ROI, risk, duration, amount).- - Allows users to search and filter investments.

### Tech Stack
- Flutter (Dart)
- State Management: Riverpod
- Networking: Dio
- Local Storage: Flutter Secure Storage
- JSON Data Fetching: Mock API

### Installation
1. Clone this repository:
```
git clone https://github.com/akbarikeyur/investment.git
cd your-repo-name
```

2. Install dependencies:
<sub>
flutter pub get
</sub>

3. Run the project:

<sub>flutter run</sub>

## Folder Structure
<sub>
lib/
│── main.dart                  # Entry point of the application
│── screens/
│   ├── dashboard_screen.dart   # Dashboard UI & logic
│   ├── feature_screen.dart     # Investment opportunities listing
│── models/
│   ├── investment.dart         # Investment model class
│── providers/
│   ├── dashboard_provider.dart # Riverpod provider for dashboard
│   ├── feature_provider.dart   # Riverpod provider for investments
│── services/
│   ├── api_service.dart        # Handles API calls using Dio
│── utils/
│   ├── app_utility.dart        # Helper functions
│── assets/
│   ├── investment_data.json    # Sample investment data (for testing)
</sub>

## API Integration
- Fetches data from investment_data.json.
- Uses Dio for handling API calls.
- Example API service function:
<sub>
class ApiService {
  final Dio _dio = Dio();

  Future<List<Investment>> fetchInvestmentData() async {
    final jsonList = await fetchDataFromJson();
    return jsonList.map((json) => Investment.fromJson(json)).toList();
  }
}
</sub>

## Riverpod State Management
- DashboardProvider: Fetches and holds summary & top investments.
- FeatureProvider: Fetches and filters the complete investment list.
- Example provider usage:

final dashboardProvider = FutureProvider<List<Investment>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchInvestmentData();
});

## Secure Authentication
- Implements biometric or PIN-based authentication using flutter_secure_storage.

## Future Enhancements
- Add search & filter functionality to the feature screen.
- Implement investment details screen on tap.
- Integrate real API endpoints.
- Add unit & widget tests.

## License

This project is open-source under the MIT License.
