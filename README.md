# FreshTrack 🥦📦

**FreshTrack** is a full-featured Flutter application that helps users manage food items and track their expiry dates. By combining Firebase, local storage solutions, and Google Gemini AI, the app provides an intuitive and interactive platform to reduce food waste and make smart kitchen decisions.

---

## 🧩 I - Introduction

FreshTrack is designed to assist users in tracking food items by recording their expiry dates and notifying them in advance. The app offers a visually clean and functionally efficient way to prevent food spoilage. It also includes a powerful feature that leverages AI to suggest recipes based on ingredients nearing expiry, helping users make the most out of their groceries.

### Key Features:
- Email and password-based user authentication.
- Add food items by clicking a photo or uploading from the gallery.
- Set custom expiry dates for each food item.
- Visual color-coded UI for expiry tracking:
  - **Red border** for expired items.
  - **Green border** for items in good condition.
- Notification alerts when an item is about to expire.
- Separate list for items expiring within 3-4 days.
- Gemini AI integration to suggest recipes based on selected expiring items.
- Store favorite recipes in the recipe history section.
- Supports up to **10 items** at a time to keep tracking simple and manageable.

---

## 📌 N - Need

The primary goals behind FreshTrack include:
- Helping users reduce food waste through timely expiry tracking.
- Encouraging better food utilization by suggesting creative recipes.
- Ensuring user data is securely stored both remotely (Firebase) and locally (Hive + Secure Storage).
- Providing a smooth, fast, and scalable experience using GetX state management.

---

## ⚙️ S - Setup

### 🔧 Prerequisites
- Flutter SDK installed
- Firebase project set up with Authentication and Firestore
- Android/iOS emulator or a physical test device
- `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) added correctly

### 🛠 Installation Steps

```bash
# Step 1: Clone the repository
git clone https://github.com/yourusername/freshtrack.git
cd freshtrack

# Step 2: Get dependencies
flutter pub get

# Step 3: Run the app
flutter run
```

---

## 🏗️ A - Architecture

FreshTrack is organized using a modular and scalable architecture. The app uses the **GetX** package for state management and dependency injection.

### Folder Structure

```
lib/
├── getx_controllers/    # GetX controllers managing app logic and state
├── screens/             # UI screens for different features
├── services/            # Firebase and API integration functions
├── helpers/             # Functions related to Hive and local storage
├── widgets/             # Reusable components across screens
├── styling/             # Theme, colors, and text styling
```

---

## 📦 M - Modules & Packages

### 🔥 Firebase and Backend
- `firebase_core`
- `cloud_firestore1`
- `firebase_database`
- `firebase_ui_firestore`

### 🧠 State Management
- `getx`

### 💾 Local Storage
- `hive`
- `hive_flutter`
- `flutter_secure_storage: ^9.2.4`

### 🖼 Image Handling
- `cloudinary_flutter: ^1.3.0`
- `cloudinary_url_gen: ^1.6.0`
- `image_picker: ^1.1.2`
- `flutter_image_compress: ^2.3.0`
- `image: ^4.3.0`
- `cached_network_image: ^3.4.0`

### ✨ UI/UX
- `page_transition: ^2.1.0`
- `slider_button: ^2.1.0`
- `curved_navigation_bar: ^1.0.6`
- `font_awesome_flutter: ^10.8.0`
- `cupertino_icons: ^1.0.6`
- `smooth_page_indicator: ^1.2.0+3`
- `group_button: ^5.3.4`
- `toastification: ^2.3.0`

### 🤖 Gemini AI (Recipe Generation)
- `googleapis_auth: ^1.6.0`
- `google_generative_ai: ^0.4.6`

### 🌐 Networking
- `dio: ^5.8.0+1`

---

## 🧪 E - Example Use

1. **User Registration/Login**  
   The user signs in using email and password for secure access.

2. **Add Food Item**  
   The user clicks a photo or selects one from the gallery, adds the food item's name and sets an expiry date.

3. **Track Expiry**  
   - Expired items are highlighted with a red border.
   - Fresh items are shown with a green border.
   - Items that will expire in 3–4 days are placed in an "About to Expire" list.

4. **Notifications**  
   Users get notified about upcoming expiry items via system alerts.

5. **Get Recipes with AI**  
   From the “About to Expire” list, users can select one or more items to generate recipes using Gemini AI. The recipes can be saved in the history section.

6. **History and Deletion**  
   Old or used items can be removed manually, and favorite recipes are stored in the history for future use.

---

## 👨‍💻 M - Maintainers

- **Your Name** – [@yourhandle](https://github.com/yourusername)
- Contributions are welcome! Feel free to fork, suggest changes, or submit a pull request.

---

> 🌱 "Don’t waste food, FreshTrack it – use it before you lose it."
