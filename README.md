# 🧮 BMI Calculator App

A Flutter BMI Calculator app built using Cubit state management with Clean Architecture.

---

## 🚀 Features

- BMI calculation using weight, height, age  
- Input validation with warning state  
- Cubit state management  
- Clean Architecture structure  
- Result classification  

---

## ⚠️ Validation Rule

If:
- Weight < 10 kg  
- OR Age < 5 years  

The app shows:

> "برجاء إدخال بيانات منطقية يا بطل!"

---

## 🏗️ Project Structure


lib/
├── cubits/
│ └── bmi_cubit/
│ ├── bmi_cubit.dart
│ └── bmi_states.dart
├── views/
│ ├── bmi_input_view.dart
│ └── bmi_result_view.dart
└── main.dart


---

## 📸 Screenshots

### 🏠 Input Screen

![Input Screen](assets/images/input.png)

---

### 📊 Result Screen

![Result Screen](assets/images/result.png)

---

## 🛠️ Tech Stack

- Flutter 💙
- Dart
- flutter_bloc (Cubit)

---

## 🚀 Getting Started

```bash
flutter pub get
flutter run