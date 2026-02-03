# How to Run the Smart Campus Helper App

## Prerequisites
1.  **Flutter SDK**: Ensure Flutter is installed. Run `flutter doctor` in your terminal to verify.
2.  **IDE**: Android Studio or VS Code with Flutter and Dart plugins installed.

## Setup Instructions
1.  **Open the Project**: Open the folder `Smart Campus Helper App` in Android Studio or VS Code.
2.  **Install Dependencies**: Run the following command in the terminal inside the project directory:
    ```bash
    flutter pub get
    ```
3.  **Run the App**:
    - Connect your Android device or start an emulator.
    - Run the project using the "Run" button in your IDE or by typing:
      ```bash
      flutter run
      ```

## Project Explanation for Viva

### 1. What architecture does this app use?
The app uses a **Layered/Modular Architecture**. We have separate folders for `models` (data structures), `providers` (logic and state), `screens` (UI), and `services` (data fetching).

### 2. How is data managed?
Data is stored in **local JSON files** inside the `assets/data` folder. We use `rootBundle` to read these files and convert them into Dart objects using factory constructors in our models.

### 3. Which State Management is used?
We use the **Provider** package. It's an industry-standard way to manage state in Flutter. It allows us to notify the UI when the data changes (like toggling Dark Mode or logging in).

### 4. Why local JSON?
For a university project, local JSON is preferred because:
- It works **100% offline**.
- It requires **no paid subscriptions** or API keys.
- It is reliable for demonstrations.

### 5. How does Dark Mode work?
We use a `ThemeProvider` that listens for changes. When toggled, it updates the `MaterialApp`'s `themeMode` and saves the preference locally using `SharedPreferences` so it persists after closing the app.

### 6. How does the Emergency Call work?
We use the `url_launcher` package. It triggers the native Android dialer with the phone number provided in the JSON data.
