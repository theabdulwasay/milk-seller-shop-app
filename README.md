<div align="center">

# 🥛 Al Wasay Milk Shop

### Fresh milk. Happy customers. A simpler way to run your shop.

A friendly, responsive Flutter app for keeping everyday milk-shop sales,
products, stock, and customer details together.

<br>

**Welcome & Onboarding** &nbsp;·&nbsp; **Demo Login & Sign-up** &nbsp;·&nbsp;
**Sales Dashboard** &nbsp;·&nbsp; **Inventory** &nbsp;·&nbsp;
**Customers** &nbsp;·&nbsp; **Reports**

</div>

---

## ✨ About the app

Al Wasay Milk Shop is a polished starting point for a small dairy business.
Sign in to a sample shop, record a sale, keep an eye on low stock, and review
how the business is doing—all from a layout that adapts to mobile and desktop.

### What you can do

- **Start with a warm welcome** — a milk-shop-inspired introduction leads into
  the app.
- **Try the login and sign-up screens** — explore an account flow with helpful
  form validation and password visibility controls.
- **See the shop at a glance** — review today's sales, orders, customers,
  outstanding payments, and recent activity.
- **Record sales** — choose a customer and product, check the total, track
  payment status, and automatically update stock.
- **Manage your inventory** — add products, restock them, and spot low-stock
  items.
- **Keep a customer book** — add customers and see their order count and total
  purchases.
- **Review sales reports** — check recent daily sales, order averages, and
  payment totals.
- **Use a responsive layout** — navigate with a compact bottom bar on smaller
  screens or a side rail on larger displays.

## 🚀 Get started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and
  available on your `PATH`.
- A supported target, such as a browser, Android device, or desktop.

### Run locally

From the project directory:

```powershell
flutter pub get
flutter run
```

To launch directly in Chrome:

```powershell
flutter run -d chrome
```

### Run the tests

```powershell
flutter analyze
flutter test
```

## 🔐 Demo sign-in

This project currently uses a **demo-only** sign-in and sign-up flow—there is
no authentication server or stored account.

1. Choose **Get Started**, or select **Login**.
2. Enter any valid email address, such as `shop@example.com`.
3. Enter any password with **at least 4 characters**, such as `milk1234`.
4. Select **Login** to open the sample shop dashboard.

For sign-up, enter a name, a phone number, a valid email, and matching passwords
with at least four characters. Your account and credentials are **not saved**.
Password recovery and Google/Apple sign-in are currently explanatory
placeholders; they do not authenticate anyone.

> **Before real-world use:** Add a real authentication provider and a database.
> Shop records and account information currently exist only as sample or
> in-memory app data.

## 🧰 Built with

- **Flutter** and **Dart**
- **Material 3** widgets
- Built-in Flutter icons and a custom-drawn dairy illustration
- No third-party runtime packages

## 📁 Project layout

```text
lib/
  auth_screens.dart   Welcome, demo login, sign-up, and dairy illustration
  main.dart           Shop dashboard, sales, inventory, customers, and reports
test/
  widget_test.dart    Welcome, demo account, login, and sales-flow tests
web/
  index.html          Web app entry page
  manifest.json       Web app metadata
```

## 💾 Sample-data note

Products, sales, and customers are initialized with example data. Changes made
while using the app are kept in memory for the current session and reset when
the app restarts. Connect a database when you are ready to keep permanent shop
records.

## 🤝 Contributing

Issues and improvements are welcome. Please open an issue to discuss a larger
change before submitting it.

---

<div align="center">

Made with 🥛 and Flutter

</div>
