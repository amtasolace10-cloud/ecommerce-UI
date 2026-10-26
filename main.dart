// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(const ShopApp());

// 1. MODELS

class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double rating;
  final IconData icon;
  final MaterialColor color;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.rating,
    required this.icon,
    required this.color,
  });
}

class ChatMessage {
  final String text;
  final bool fromUser;
  const ChatMessage(this.text, {required this.fromUser});
}

// 2. SERVICE LAYER (the "AI seams")
// Replace the Mock classes with real API implementations.

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}

abstract class AiService {
  Future<List<Product>> recommend(List<Product> all, {Product? basedOn});
  Future<List<Product>> smartSearch(String query, List<Product> all);
  Future<String> chat(String message, List<Product> catalog);
}

class LocalProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return const [
      Product(id: '1', name: 'Wireless Headphones', category: 'Electronics', description: 'Noise cancelling over-ear headphones with 30h battery.', price: 79.99, rating: 4.5, icon: Icons.headphones, color: Colors.indigo),
      Product(id: '2', name: 'Smart Watch', category: 'Electronics', description: 'Fitness tracking, heart rate and notifications.', price: 129.00, rating: 4.3, icon: Icons.watch, color: Colors.teal),
      Product(id: '3', name: 'Running Shoes', category: 'Fashion', description: 'Lightweight breathable shoes for daily running.', price: 59.50, rating: 4.6, icon: Icons.directions_run, color: Colors.orange),
      Product(id: '4', name: 'Leather Backpack', category: 'Fashion', description: 'Durable backpack with laptop compartment.', price: 49.99, rating: 4.2, icon: Icons.backpack, color: Colors.brown),
      Product(id: '5', name: 'Coffee Maker', category: 'Home', description: 'Programmable drip coffee maker, 12 cups.', price: 39.99, rating: 4.4, icon: Icons.coffee_maker, color: Colors.red),
      Product(id: '6', name: 'Desk Lamp', category: 'Home', description: 'LED desk lamp with adjustable brightness.', price: 24.99, rating: 4.1, icon: Icons.light, color: Colors.amber),
      Product(id: '7', name: 'Bluetooth Speaker', category: 'Electronics', description: 'Portable waterproof speaker with deep bass.', price: 34.99, rating: 4.4, icon: Icons.speaker, color: Colors.purple),
      Product(id: '8', name: 'Sunglasses', category: 'Fashion', description: 'UV400 polarized sunglasses.', price: 19.99, rating: 4.0, icon: Icons.wb_sunny, color: Colors.blueGrey),
    ];
  }
}

/// Mock AI: simple keyword logic. Swap with a real LLM / vector-search call.
class MockAiService implements AiService {
  @override
  Future<List<Product>> recommend(List<Product> all, {Product? basedOn}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final list = List<Product>.from(all);
    if (basedOn != null) {
      list.removeWhere((p) => p.id == basedOn.id);
      list.sort((a, b) {
        final sa = a.category == basedOn.category ? 1 : 0;
        final sb = b.category == basedOn.category ? 1 : 0;
        return sb.compareTo(sa);
      });
    } else {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return list.take(4).toList();
  }

  @override
  Future<List<Product>> smartSearch(String query, List<Product> all) async {
    final tokens = query
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();
    if (tokens.isEmpty) return all;
    int score(Product p) {
      final text = '${p.name} ${p.category} ${p.description}'.toLowerCase();
      return tokens.where(text.contains).length;
    }

    final results = all.where((p) => score(p) > 0).toList()
      ..sort((a, b) => score(b).compareTo(score(a)));
    return results;
  }

  @override
  Future<String> chat(String message, List<Product> catalog) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final found = await smartSearch(message, catalog);
    if (found.isEmpty) {
      return "I couldn't find a match. Try describing what you need, e.g. 'shoes for running'.";
    }
    final names = found.take(3).map((p) => p.name).join(', ');
    return 'You might like: $names.';
  }
}

// 3. STATE (ChangeNotifier + InheritedNotifier, no packages)

class AppState extends ChangeNotifier {
  AppState({required this.repo, required this.ai});

  final ProductRepository repo;
  final AiService ai;

  List<Product> all = [];
  List<Product> visible = [];
  List<Product> recommended = [];
  final Map<Product, int> cart = {};
  String category = 'All';
  String query = '';
  bool loading = true;

  List<String> get categories => ['All', ...{...all.map((p) => p.category)}];
  int get cartCount => cart.values.fold(0, (a, b) => a + b);
  double get cartTotal =>
      cart.entries.fold(0.0, (sum, e) => sum + e.key.price * e.value);

  Future<void> init() async {
    all = await repo.fetchProducts();
    recommended = await ai.recommend(all);
    loading = false;
    await _refresh();
  }

  Future<void> _refresh() async {
    var list = query.trim().isEmpty ? all : await ai.smartSearch(query, all);
    if (category != 'All') {
      list = list.where((p) => p.category == category).toList();
    }
    visible = list;
    notifyListeners();
  }

  Future<void> setCategory(String c) {
    category = c;
    return _refresh();
  }

  Future<void> search(String q) {
    query = q;
    return _refresh();
  }

  void add(Product p) {
    cart[p] = (cart[p] ?? 0) + 1;
    notifyListeners();
  }

  void remove(Product p) {
    final n = (cart[p] ?? 0) - 1;
    if (n <= 0) {
      cart.remove(p);
    } else {
      cart[p] = n;
    }
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
}


// 4. APP ROOT

class ShopApp extends StatefulWidget {
  const ShopApp({super.key});
  @override
  State<ShopApp> createState() => _ShopAppState();
}

class _ShopAppState extends State<ShopApp> {
  late final AppState state;

  @override
  void initState() {
    super.initState();
    // Swap implementations here to plug in a real backend / AI.
    state = AppState(repo: LocalProductRepository(), ai: MockAiService())
      ..init();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      child: MaterialApp(
        title: 'AI Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
          scaffoldBackgroundColor: const Color(0xFFF6F6F8),
        ),
        home: const RootScreen(),
      ),
    );
  }
}

// 5. SCREENS

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: const [HomeScreen(), CartScreen()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => FractionallySizedBox(
            heightFactor: 0.75,
            child: AssistantSheet(state: state),
          ),
        ),
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Ask AI'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: state.cartCount > 0,
              label: Text('${state.cartCount}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    if (state.loading) return const Center(child: CircularProgressIndicator());

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // Sticky search bar
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            title: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: state.search,
              decoration: InputDecoration(
                hintText: 'Search or describe what you need…',
                prefixIcon: const Icon(Icons.auto_awesome, size: 20),
                filled: true,
                fillColor: const Color(0xFFF0F0F3),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Category chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final c = state.categories[i];
                  return ChoiceChip(
                    label: Text(c),
                    selected: state.category == c,
                    onSelected: (_) => state.setCategory(c),
                  );
                },
              ),
            ),
          ),
          // Promo banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 130,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepOrange, Colors.orangeAccent],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mega Sale',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Up to 40% off today',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Icon(Icons.local_offer, color: Colors.white, size: 56),
                ],
              ),
            ),
          ),
          // AI recommendations
          const SliverToBoxAdapter(
            child: SectionTitle('Recommended for you', icon: Icons.auto_awesome),
          ),
          SliverToBoxAdapter(child: RecommendedRow(products: state.recommended)),
          // Product grid
          const SliverToBoxAdapter(child: SectionTitle('All products')),
          if (state.visible.isEmpty)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('No products found')),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 220,
                  childAspectRatio: 0.66,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                      (_, i) => ProductCard(product: state.visible[i]),
                  childCount: state.visible.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Product> related = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = AppScope.of(context);
    // AI hook: "similar products"
    state.ai.recommend(state.all, basedOn: widget.product).then((r) {
      if (mounted) setState(() => related = r);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final state = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: ListView(
        children: [
          Container(
            height: 260,
            color: p.color.shade50,
            child: Center(child: Icon(p.icon, size: 120, color: p.color)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  Text(' ${p.rating}'),
                  const Spacer(),
                  Text(
                    '\$${p.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                Text(p.description),
              ],
            ),
          ),
          if (related.isNotEmpty) ...[
            const SectionTitle('Similar products', icon: Icons.auto_awesome),
            RecommendedRow(products: related),
          ],
          const SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            onPressed: () {
              state.add(p);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to cart')),
              );
            },
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to cart'),
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final items = state.cart.entries.toList();
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('My Cart',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, i) {
                final p = items[i].key;
                final qty = items[i].value;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: p.color.shade50,
                    child: Icon(p.icon, color: p.color),
                  ),
                  title: Text(p.name),
                  subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => state.remove(p),
                    ),
                    Text('$qty'),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => state.add(p),
                    ),
                  ]),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  'Total: \$${state.cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: items.isEmpty ? null : () {},
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 6. AI ASSISTANT (chat bottom sheet)
class AssistantSheet extends StatefulWidget {
  final AppState state;
  const AssistantSheet({super.key, required this.state});
  @override
  State<AssistantSheet> createState() => _AssistantSheetState();
}

class _AssistantSheetState extends State<AssistantSheet> {
  final controller = TextEditingController();
  final messages = <ChatMessage>[
    const ChatMessage('Hi! Tell me what you are looking for.', fromUser: false),
  ];
  bool typing = false;

  Future<void> send() async {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    controller.clear();
    setState(() {
      messages.add(ChatMessage(text, fromUser: true));
      typing = true;
    });
    final reply = await widget.state.ai.chat(text, widget.state.all);
    if (!mounted) return;
    setState(() {
      messages.add(ChatMessage(reply, fromUser: false));
      typing = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text('AI Shopping Assistant'),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length + (typing ? 1 : 0),
              itemBuilder: (_, i) {
                if (i == messages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text('Typing…'),
                    ),
                  );
                }
                final m = messages[i];
                return Align(
                  alignment: m.fromUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: m.fromUser
                          ? Colors.deepOrange
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      m.text,
                      style: TextStyle(
                        color: m.fromUser ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => send(),
                    decoration: const InputDecoration(
                      hintText: 'Ask anything…',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(onPressed: send, icon: const Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 7. REUSABLE WIDGETS
// ============================================================
class SectionTitle extends StatelessWidget {
  final String text;
  final IconData? icon;
  const SectionTitle(this.text, {super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: Colors.deepOrange),
          const SizedBox(width: 6),
        ],
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ]),
    );
  }
}

class RecommendedRow extends StatelessWidget {
  final List<Product> products;
  const RecommendedRow({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) =>
            SizedBox(width: 160, child: ProductCard(product: products[i])),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final p = product;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: p)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: p.color.shade50,
                child: Icon(p.icon, size: 64, color: p.color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Row(children: [
                    const Icon(Icons.star, size: 14, color: Colors.amber),
                    Text(' ${p.rating}', style: const TextStyle(fontSize: 12)),
                  ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 4, 6),
              child: Row(children: [
                Text(
                  '\$${p.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.add_shopping_cart, size: 20),
                  onPressed: () {
                    state.add(p);
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                        content: Text('${p.name} added'),
                        duration: const Duration(seconds: 1),
                      ));
                  },
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}