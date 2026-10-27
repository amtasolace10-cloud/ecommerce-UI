# amta

AI Shop - E-commerce UI (Flutter)

## Getting Started

This is my submission for the E-commerce UI task from Microx Software House. It is a simple shopping app built with Flutter. The code is organised so AI features can be added later.

# Author: Amta Hafeez

Features
1) Search bar at the top
2) Category filter (All, Electronics, Fashion, Home)
3) Promo banner and "Recommended for you" list
4) Product grid with name, rating and price
5) Product details page with similar products
6) Cart with quantity buttons and total price
7) "Ask AI" chat assistant button

# How the code is organized:
Everything is in lib/main.dart, split into sections: models, services, state, screens, AI assistant and reusable widgets. No extra packages are used.

# How to run
flutter run -d edge

# How to add AI later
The app uses an AiService class for recommendations, search and chat. Right now it uses MockAiService, which only matches keywords. To use a real AI,i'll create a class that implements AiService and replace MockAiService() in main.dart. The screens do not need any changes.

# Limitations
1) Only 8 sample products
2) Icons are used instead of real images
3) The AI is a mock
4) Checkout is not built yet
