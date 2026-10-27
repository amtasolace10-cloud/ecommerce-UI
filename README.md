# AI Shop - Flutter App - README

## Project ka Overview
Ye aik AI-powered E-commerce shop hai. Ismai user products dekh sakta hai, search kar sakta hai, AI se recommend karwa sakta hai, aur AI assistant se baat karke product dhoond sakta hai. Ye pure Dart mai hai, koi extra package nahi lagaya gaya.

## Main Features

1.  Product Browsing: 8 demo products (Electronics, Fashion, Home)
2.  AI Recommendations: AI khud batata hai "Recommended for you"
3.  Smart Search: User likhe "shoes for running" to AI samajh kar shoes dikha dega
4.  AI Chat Assistant: Neeche "Ask AI" button se AI se baat kar sakte hn
5.  Cart System: Add / Remove / Total price
6.  Responsive Grid: Har screen par sahi dikhta hai

## Project Architecture 

Is project ko 7 hisson mai banaya gaya hai:

### 1. MODELS
 Product: id, name, category, description, price, rating, icon, color
 ChatMessage: AI chat ke messages (fromUser: true/false)

### 2. SERVICE LAYER
Ye Broker Architecture jaisa hai. Asli AI baad mai yahan lage ga.

 ProductRepository: Product lane ka abstract. Abhi LocalProductRepository use ho raha hai jo local list deta hai (400ms delay).
 AiService: AI ke 3 kaam:
     recommend(): Similar products dikhana
     smartSearch(): Keyword se search (e.g., "shoes")
     chat(): User ke message ka jawab dena

 MockAiService: Abhi nakli AI hai. Simple logic:
     Same category wale products ko pehle dikhata hai
     Rating se sort karta hai
     Future mai isko real LLM / API se replace kar sakte hn

### 3. STATE MANAGEMENT (Bina Package Ke)
 AppState extends ChangeNotifier: Poore app ka data yahan hai
     all, visible, recommended, cart, category, query
     Functions: init(), _refresh(), setCategory(), search(), add(), remove()
 AppScope extends InheritedNotifier: Ye state ko poore app mai pohanchata hai bina Provider ke. AppScope.of(context) se kahin se bhi state mil jati hai.

### 4. APP ROOT
 ShopApp: App start hoti hai yahan se
 state = AppState(repo: LocalProductRepository(), ai: MockAiService())
 Yahan par hum real backend lagayn ge to sirf ye line change hogi

### 5. SCREENS (UI)

a) RootScreen: Neeche 2 tabs (Home, Cart) aur beech mai "Ask AI" ka Floating Button
b) HomeScreen: 
       Sticky Search Bar (upar constant mtlb paste rehta hai)
       Category Chips (All, Electronics, Fashion, Home)
       Promo Banner (Mega Sale)
       Recommended Row (AI wale products)
       All Products Grid (SliverGrid)
c) ProductDetailScreen: Product ki detail + Similar products (AI se)
d) CartScreen: Cart items, quantity +/-, Total price, Checkout button

### 6. AI ASSISTANT
 AssistantSheet: Neeche se khulne wali chat sheet (75% height)
 User likhta hai "I need headphones" -> AI smartSearch chalata hai -> 3 products ke naam batata hai
 Typing... ka effect bhi hai

### 7. REUSABLE WIDGETS
 SectionTitle: Heading with icon
 RecommendedRow: Horizontal list
 ProductCard: Har product ka card (image, name, rating, price, add button)

## Kaise Chalana Hai?

1.  flutter pub get
2.  flutter run -d edge

Koi API key nahi chahiye hogi kyunki ye Mock AI hai.

## Future Mai Kya Karna Hai? (Real AI Lagana)

Real AI lagane ke liye sirf 2 files badalni hain:

1.  LocalProductRepository ki jagah FirebaseProductRepository ya ApiProductRepository banani h
2.  MockAiService ki jagah OpenAiService banao jo real API call kare

Baqi poori app waisi hi chalegi.
