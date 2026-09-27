import 'package:flutter/material.dart';

import 'auth_screens.dart';

void main() {
  runApp(const MilkSellerApp());
}

const _green = Color(0xFF177A58);
const _ink = Color(0xFF20332C);
const _muted = Color(0xFF718079);
const _canvas = Color(0xFFF5F7F4);

String money(num amount) => 'Rs. ${amount.toStringAsFixed(0)}';

String quantityText(double quantity) {
  if (quantity == quantity.roundToDouble()) {
    return quantity.toStringAsFixed(0);
  }
  return quantity.toStringAsFixed(1);
}

class Product {
  Product({
    required this.name,
    required this.unit,
    required this.price,
    required this.stock,
    required this.color,
    required this.icon,
  });

  final String name;
  final String unit;
  double price;
  double stock;
  final Color color;
  final IconData icon;
}

class Customer {
  Customer({required this.name, required this.phone});

  final String name;
  final String phone;
}

class Sale {
  Sale({
    required this.customer,
    required this.product,
    required this.quantity,
    required this.total,
    required this.date,
    required this.payment,
  });

  final String customer;
  final String product;
  final double quantity;
  final double total;
  final DateTime date;
  final String payment;
}

class MilkSellerApp extends StatelessWidget {
  const MilkSellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _green,
      brightness: Brightness.light,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Milk Seller Shop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: _canvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: _canvas,
          foregroundColor: _ink,
          surfaceTintColor: Colors.transparent,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: const BorderSide(color: Color(0xFFE8EDE9)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7F9F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE4EAE5)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE4EAE5)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        ),
      ),
      home: WelcomePage(
        dashboardBuilder: (_) => const ShopHomePage(),
      ),
    );
  }
}

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({super.key});

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  int _selectedPage = 0;

  final List<Product> _products = [
    Product(
      name: 'Fresh cow milk',
      unit: 'liter',
      price: 220,
      stock: 48,
      color: const Color(0xFFEAF4FF),
      icon: Icons.water_drop_outlined,
    ),
    Product(
      name: 'Desi ghee',
      unit: 'kg',
      price: 2400,
      stock: 12,
      color: const Color(0xFFFFF3DC),
      icon: Icons.local_dining_outlined,
    ),
    Product(
      name: 'Yogurt',
      unit: 'kg',
      price: 300,
      stock: 19,
      color: const Color(0xFFF0EAFE),
      icon: Icons.icecream_outlined,
    ),
    Product(
      name: 'Fresh cream',
      unit: 'pack',
      price: 180,
      stock: 4,
      color: const Color(0xFFFFECE8),
      icon: Icons.breakfast_dining_outlined,
    ),
  ];

  final List<Customer> _customers = [
    Customer(name: 'Ayesha Khan', phone: '0300 1234567'),
    Customer(name: 'Bilal Ahmed', phone: '0312 7654321'),
    Customer(name: 'Sara Malik', phone: '0333 4567890'),
    Customer(name: 'Walk-in customer', phone: '—'),
  ];

  late final List<Sale> _sales = [
    Sale(
      customer: 'Ayesha Khan',
      product: 'Fresh cow milk',
      quantity: 2,
      total: 440,
      date: DateTime.now().subtract(const Duration(hours: 1)),
      payment: 'Paid',
    ),
    Sale(
      customer: 'Bilal Ahmed',
      product: 'Desi ghee',
      quantity: 1,
      total: 2400,
      date: DateTime.now().subtract(const Duration(hours: 3)),
      payment: 'Paid',
    ),
    Sale(
      customer: 'Sara Malik',
      product: 'Yogurt',
      quantity: 2,
      total: 600,
      date: DateTime.now().subtract(const Duration(days: 1)),
      payment: 'Due',
    ),
    Sale(
      customer: 'Ayesha Khan',
      product: 'Fresh cow milk',
      quantity: 3,
      total: 660,
      date: DateTime.now().subtract(const Duration(days: 2)),
      payment: 'Paid',
    ),
    Sale(
      customer: 'Walk-in customer',
      product: 'Fresh cream',
      quantity: 2,
      total: 360,
      date: DateTime.now().subtract(const Duration(days: 3)),
      payment: 'Paid',
    ),
    Sale(
      customer: 'Bilal Ahmed',
      product: 'Fresh cow milk',
      quantity: 4,
      total: 880,
      date: DateTime.now().subtract(const Duration(days: 4)),
      payment: 'Due',
    ),
    Sale(
      customer: 'Sara Malik',
      product: 'Yogurt',
      quantity: 1,
      total: 300,
      date: DateTime.now().subtract(const Duration(days: 5)),
      payment: 'Paid',
    ),
  ];

  static const _pageNames = [
    'Dashboard',
    'Sales',
    'Inventory',
    'Customers',
    'Reports',
  ];

  static const _pageIcons = [
    Icons.space_dashboard_outlined,
    Icons.receipt_long_outlined,
    Icons.inventory_2_outlined,
    Icons.people_outline,
    Icons.bar_chart_outlined,
  ];

  double get _todaySales {
    final now = DateTime.now();
    return _sales
        .where((sale) =>
            sale.date.year == now.year &&
            sale.date.month == now.month &&
            sale.date.day == now.day)
        .fold(0, (total, sale) => total + sale.total);
  }

  int get _todayOrders {
    final now = DateTime.now();
    return _sales
        .where((sale) =>
            sale.date.year == now.year &&
            sale.date.month == now.month &&
            sale.date.day == now.day)
        .length;
  }

  double get _dueTotal => _sales
      .where((sale) => sale.payment == 'Due')
      .fold(0, (total, sale) => total + sale.total);

  void _notify(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _addSale() async {
    if (_products.isEmpty || _customers.isEmpty) {
      _notify('Add a product and customer before recording a sale.');
      return;
    }

    final draft = await showDialog<_SaleDraft>(
      context: context,
      builder: (context) => _SaleDialog(
        products: _products,
        customers: _customers,
      ),
    );
    if (draft == null || !mounted) return;

    final product = _products[draft.productIndex];
    if (draft.quantity > product.stock) {
      _notify(
        'Not enough ${product.name} in stock. Available: '
        '${quantityText(product.stock)} ${product.unit}.',
      );
      return;
    }

    setState(() {
      product.stock -= draft.quantity;
      _sales.insert(
        0,
        Sale(
          customer: _customers[draft.customerIndex].name,
          product: product.name,
          quantity: draft.quantity,
          total: product.price * draft.quantity,
          date: DateTime.now(),
          payment: draft.payment,
        ),
      );
    });
    _notify('Sale recorded successfully.');
  }

  Future<void> _addProduct() async {
    final draft = await showDialog<_ProductDraft>(
      context: context,
      builder: (context) => const _ProductDialog(),
    );
    if (draft == null || !mounted) return;

    setState(() {
      _products.add(
        Product(
          name: draft.name,
          unit: draft.unit,
          price: draft.price,
          stock: draft.stock,
          color: const Color(0xFFEAF4FF),
          icon: Icons.inventory_2_outlined,
        ),
      );
    });
    _notify('${draft.name} added to inventory.');
  }

  Future<void> _restock(Product product) async {
    final amount = await showDialog<double>(
      context: context,
      builder: (context) => _RestockDialog(product: product),
    );
    if (amount == null || !mounted) return;

    setState(() => product.stock += amount);
    _notify('${product.name} stock updated.');
  }

  Future<void> _addCustomer() async {
    final customer = await showDialog<Customer>(
      context: context,
      builder: (context) => const _CustomerDialog(),
    );
    if (customer == null || !mounted) return;

    setState(() => _customers.add(customer));
    _notify('${customer.name} added to your customers.');
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 850;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: isWide ? 28 : 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _pageNames[_selectedPage],
              style: const TextStyle(
                color: _ink,
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              _pageSubtitle,
              style: const TextStyle(color: _muted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFE1F0E9),
              foregroundColor: _green,
              child: const Icon(Icons.storefront_outlined),
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWide)
            NavigationRail(
              backgroundColor: _canvas,
              selectedIndex: _selectedPage,
              onDestinationSelected: (index) =>
                  setState(() => _selectedPage = index),
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: _green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.water_drop_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              destinations: List.generate(
                _pageNames.length,
                (index) => NavigationRailDestination(
                  icon: Icon(_pageIcons[index]),
                  label: Text(_pageNames[index]),
                ),
              ),
            ),
          Expanded(child: _buildPage()),
        ],
      ),
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: _selectedPage,
              onDestinationSelected: (index) =>
                  setState(() => _selectedPage = index),
              destinations: List.generate(
                _pageNames.length,
                (index) => NavigationDestination(
                  icon: Icon(_pageIcons[index]),
                  label: _pageNames[index],
                ),
              ),
            ),
    );
  }

  String get _pageSubtitle => switch (_selectedPage) {
        0 => 'Your shop at a glance',
        1 => 'Keep track of every order',
        2 => 'Manage products and stock',
        3 => 'Your regular customers',
        _ => 'A clear view of your sales',
      };

  Widget _buildPage() => switch (_selectedPage) {
        0 => _dashboardPage(),
        1 => _salesPage(),
        2 => _inventoryPage(),
        3 => _customersPage(),
        _ => _reportsPage(),
      };

  Widget _dashboardPage() {
    final lowStock = _products.where((product) => product.stock <= 5).length;

    return _pageContent(
      children: [
        _welcomeCard(),
        const SizedBox(height: 18),
        _responsiveCards([
          _MetricCard(
            label: "Today's sales",
            value: money(_todaySales),
            note: '$_todayOrders orders today',
            icon: Icons.payments_outlined,
            tint: const Color(0xFFE5F4EB),
            iconColor: _green,
          ),
          _MetricCard(
            label: 'Total orders',
            value: '${_sales.length}',
            note: 'All recorded orders',
            icon: Icons.shopping_bag_outlined,
            tint: const Color(0xFFEAF1FF),
            iconColor: const Color(0xFF5078D5),
          ),
          _MetricCard(
            label: 'Customers',
            value: '${_customers.length}',
            note: 'In your customer book',
            icon: Icons.people_outline,
            tint: const Color(0xFFF1EAFE),
            iconColor: const Color(0xFF8464C8),
          ),
          _MetricCard(
            label: 'Pending payments',
            value: money(_dueTotal),
            note: '$lowStock low-stock items',
            icon: Icons.account_balance_wallet_outlined,
            tint: const Color(0xFFFFF1DB),
            iconColor: const Color(0xFFD9942C),
          ),
        ]),
        const SizedBox(height: 22),
        _sectionHeading(
          'Recent sales',
          actionLabel: 'View all',
          onAction: () => setState(() => _selectedPage = 1),
        ),
        const SizedBox(height: 10),
        _salesList(_sales.take(4).toList()),
        const SizedBox(height: 22),
        _sectionHeading(
          'Stock to watch',
          actionLabel: 'Manage stock',
          onAction: () => setState(() => _selectedPage = 2),
        ),
        const SizedBox(height: 10),
        _lowStockCard(),
      ],
    );
  }

  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF167A57), Color(0xFF27966B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 18,
        spacing: 18,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting,
                  style: const TextStyle(
                    color: Color(0xFFCFE8DA),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Fresh milk, happy customers.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your shop is ready for another great day.',
                  style: TextStyle(color: Color(0xFFE0F2E8)),
                ),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: _addSale,
            icon: const Icon(Icons.add),
            label: const Text('New sale'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: _green,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning!';
    if (hour < 17) return 'Good afternoon!';
    return 'Good evening!';
  }

  Widget _salesPage() {
    return _pageContent(
      children: [
        _sectionHeading(
          'All sales',
          actionLabel: '＋ New sale',
          onAction: _addSale,
        ),
        const SizedBox(height: 6),
        Text(
          '${_sales.length} orders recorded · ${money(_sales.fold<double>(0, (sum, sale) => sum + sale.total))} total',
          style: const TextStyle(color: _muted),
        ),
        const SizedBox(height: 16),
        _salesList(_sales),
      ],
    );
  }

  Widget _inventoryPage() {
    return _pageContent(
      children: [
        _sectionHeading(
          'Your products',
          actionLabel: '＋ Add product',
          onAction: _addProduct,
        ),
        const SizedBox(height: 6),
        const Text(
          'Update stock or add a new product to your shop.',
          style: TextStyle(color: _muted),
        ),
        const SizedBox(height: 16),
        ..._products.map(_productCard),
      ],
    );
  }

  Widget _customersPage() {
    return _pageContent(
      children: [
        _sectionHeading(
          'Customer book',
          actionLabel: '＋ Add customer',
          onAction: _addCustomer,
        ),
        const SizedBox(height: 6),
        const Text(
          'Customer details and their purchase history.',
          style: TextStyle(color: _muted),
        ),
        const SizedBox(height: 16),
        ..._customers.map(_customerCard),
      ],
    );
  }

  Widget _reportsPage() {
    final weekTotal = _sales
        .where((sale) => DateTime.now().difference(sale.date).inDays < 7)
        .fold<double>(0, (sum, sale) => sum + sale.total);
    final weekOrders = _sales
        .where((sale) => DateTime.now().difference(sale.date).inDays < 7)
        .length;
    final maxDay = List<double>.generate(7, _dailySales).fold<double>(
        0, (highest, amount) => amount > highest ? amount : highest);

    return _pageContent(
      children: [
        const _SectionHeading(title: 'Sales report'),
        const SizedBox(height: 6),
        const Text(
          'Your shop performance for the last seven days.',
          style: TextStyle(color: _muted),
        ),
        const SizedBox(height: 18),
        _responsiveCards([
          _MetricCard(
            label: 'Sales this week',
            value: money(weekTotal),
            note: '$weekOrders orders',
            icon: Icons.trending_up,
            tint: const Color(0xFFE5F4EB),
            iconColor: _green,
          ),
          _MetricCard(
            label: 'Average order',
            value: money(_sales.isEmpty
                ? 0
                : _sales.fold<double>(0, (sum, sale) => sum + sale.total) /
                    _sales.length),
            note: 'Across all orders',
            icon: Icons.receipt_long_outlined,
            tint: const Color(0xFFEAF1FF),
            iconColor: const Color(0xFF5078D5),
          ),
        ]),
        const SizedBox(height: 18),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily sales',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      final date =
                          DateTime.now().subtract(Duration(days: 6 - index));
                      final amount = _dailySales(index);
                      final fraction =
                          maxDay == 0 ? 0.05 : (amount / maxDay).clamp(0.08, 1);
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              amount == 0 ? '—' : money(amount),
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 9,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Flexible(
                              child: FractionallySizedBox(
                                heightFactor: fraction.toDouble(),
                                child: Container(
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: index == 6
                                        ? _green
                                        : const Color(0xFFA9D3BC),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              const [
                                'M',
                                'T',
                                'W',
                                'T',
                                'F',
                                'S',
                                'S'
                              ][date.weekday - 1],
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        _sectionHeading('Payment summary'),
        const SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _summaryRow('Paid orders', money(_paidTotal), _green),
                const Divider(height: 24),
                _summaryRow(
                    'Pending payments', money(_dueTotal), Colors.orange),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _dailySales(int index) {
    final date = DateTime.now().subtract(Duration(days: 6 - index));
    return _sales
        .where((sale) =>
            sale.date.year == date.year &&
            sale.date.month == date.month &&
            sale.date.day == date.day)
        .fold(0, (sum, sale) => sum + sale.total);
  }

  double get _paidTotal => _sales
      .where((sale) => sale.payment == 'Paid')
      .fold(0, (sum, sale) => sum + sale.total);

  Widget _pageContent({required List<Widget> children}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth > 1100 ? 1100.0 : 900.0;
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _responsiveCards(List<Widget> cards) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 780
            ? (cards.length > 2 ? 4 : 2)
            : constraints.maxWidth >= 500
                ? 2
                : 1;
        const spacing = 12.0;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              cards.map((card) => SizedBox(width: width, child: card)).toList(),
        );
      },
    );
  }

  Widget _sectionHeading(
    String title, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onAction,
            child: Text(actionLabel),
          ),
      ],
    );
  }

  Widget _salesList(List<Sale> sales) {
    if (sales.isEmpty) {
      return const _EmptyCard(
        icon: Icons.receipt_long_outlined,
        message: 'No sales yet. Record your first sale to see it here.',
      );
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          for (var index = 0; index < sales.length; index++) ...[
            _saleRow(sales[index]),
            if (index != sales.length - 1)
              const Divider(height: 1, indent: 64, endIndent: 16),
          ],
        ],
      ),
    );
  }

  Widget _saleRow(Sale sale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF4EE),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.local_drink_outlined, color: _green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sale.customer,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${quantityText(sale.quantity)} × ${sale.product} · ${_formatDate(sale.date)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                money(sale.total),
                style: const TextStyle(
                  color: _ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              _PaymentBadge(payment: sale.payment),
            ],
          ),
        ],
      ),
    );
  }

  Widget _productCard(Product product) {
    final lowStock = product.stock <= 5;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: product.color,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(product.icon, color: _green),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${money(product.price)} / ${product.unit}',
                      style: const TextStyle(color: _muted, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${quantityText(product.stock)} ${product.unit}',
                    style: TextStyle(
                      color: lowStock ? const Color(0xFFC05242) : _ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lowStock ? 'Low stock' : 'In stock',
                    style: TextStyle(
                      color: lowStock ? const Color(0xFFC05242) : _muted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              IconButton(
                tooltip: 'Restock ${product.name}',
                onPressed: () => _restock(product),
                icon: const Icon(Icons.add_circle_outline, color: _green),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _lowStockCard() {
    final products = _products.where((product) => product.stock <= 5).toList();
    if (products.isEmpty) {
      return const _EmptyCard(
        icon: Icons.check_circle_outline,
        message: 'All products are well stocked.',
      );
    }
    return Card(
      child: Column(
        children: [
          for (var index = 0; index < products.length; index++) ...[
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF0E8),
                child: Icon(Icons.warning_amber_rounded, color: Colors.orange),
              ),
              title: Text(products[index].name),
              subtitle: Text(
                '${quantityText(products[index].stock)} ${products[index].unit} remaining',
              ),
              trailing: IconButton(
                onPressed: () => _restock(products[index]),
                icon: const Icon(Icons.add_circle_outline, color: _green),
                tooltip: 'Restock ${products[index].name}',
              ),
            ),
            if (index != products.length - 1)
              const Divider(height: 1, indent: 68, endIndent: 16),
          ],
        ],
      ),
    );
  }

  Widget _customerCard(Customer customer) {
    final purchases =
        _sales.where((sale) => sale.customer == customer.name).toList();
    final spent = purchases.fold<double>(0, (sum, sale) => sum + sale.total);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFE5F4EB),
            foregroundColor: _green,
            child: Text(
              customer.name.isEmpty ? '?' : customer.name[0].toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          title: Text(
            customer.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${customer.phone} · ${purchases.length} orders',
            style: const TextStyle(color: _muted, fontSize: 12),
          ),
          trailing: Text(
            money(spent),
            style: const TextStyle(
              color: _ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String amount, Color color) {
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(label, style: const TextStyle(color: _muted)),
        ),
        Text(
          amount,
          style: const TextStyle(
            color: _ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return 'Today, ${_clockTime(date)}';
  }
  final yesterday = now.subtract(const Duration(days: 1));
  if (date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day) {
    return 'Yesterday';
  }
  return '${date.day}/${date.month}/${date.year}';
}

String _clockTime(DateTime date) {
  final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
  return '$hour:${date.minute.toString().padLeft(2, '0')} '
      '${date.hour < 12 ? 'AM' : 'PM'}';
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.note,
    required this.icon,
    required this.tint,
    required this.iconColor,
  });

  final String label;
  final String value;
  final String note;
  final IconData icon;
  final Color tint;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(color: _muted, fontSize: 12),
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(icon, color: iconColor, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: _ink,
        fontSize: 17,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  const _PaymentBadge({required this.payment});

  final String payment;

  @override
  Widget build(BuildContext context) {
    final paid = payment == 'Paid';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: paid ? const Color(0xFFE7F4EC) : const Color(0xFFFFF1DD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        payment,
        style: TextStyle(
          color: paid ? _green : const Color(0xFFAD721B),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              Icon(icon, color: _muted, size: 30),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaleDraft {
  const _SaleDraft({
    required this.productIndex,
    required this.customerIndex,
    required this.quantity,
    required this.payment,
  });

  final int productIndex;
  final int customerIndex;
  final double quantity;
  final String payment;
}

class _SaleDialog extends StatefulWidget {
  const _SaleDialog({required this.products, required this.customers});

  final List<Product> products;
  final List<Customer> customers;

  @override
  State<_SaleDialog> createState() => _SaleDialogState();
}

class _SaleDialogState extends State<_SaleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '1');
  int _productIndex = 0;
  int _customerIndex = 0;
  String _payment = 'Paid';

  Product get _product => widget.products[_productIndex];

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quantity = double.tryParse(_quantityController.text) ?? 0;

    return AlertDialog(
      title: const Text('Record a sale'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                initialValue: _productIndex,
                decoration: const InputDecoration(labelText: 'Product'),
                items: List.generate(
                  widget.products.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(
                      '${widget.products[index].name} '
                      '(${quantityText(widget.products[index].stock)} '
                      '${widget.products[index].unit})',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) setState(() => _productIndex = value);
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                initialValue: _customerIndex,
                decoration: const InputDecoration(labelText: 'Customer'),
                items: List.generate(
                  widget.customers.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Text(widget.customers[index].name),
                  ),
                ),
                onChanged: (value) {
                  if (value != null) setState(() => _customerIndex = value);
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantityController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Quantity (${_product.unit})',
                ),
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  final parsed = double.tryParse(value ?? '');
                  if (parsed == null || parsed <= 0) {
                    return 'Enter a quantity greater than zero.';
                  }
                  if (parsed > _product.stock) {
                    return 'Only ${quantityText(_product.stock)} '
                        '${_product.unit} available.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _payment,
                decoration: const InputDecoration(labelText: 'Payment status'),
                items: const [
                  DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                  DropdownMenuItem(value: 'Due', child: Text('Due')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _payment = value);
                },
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4EE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Total: ${money(_product.price * quantity)}',
                  style: const TextStyle(
                    color: _green,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              _SaleDraft(
                productIndex: _productIndex,
                customerIndex: _customerIndex,
                quantity: double.parse(_quantityController.text),
                payment: _payment,
              ),
            );
          },
          child: const Text('Save sale'),
        ),
      ],
    );
  }
}

class _ProductDraft {
  const _ProductDraft({
    required this.name,
    required this.unit,
    required this.price,
    required this.stock,
  });

  final String name;
  final String unit;
  final double price;
  final double stock;
}

class _ProductDialog extends StatefulWidget {
  const _ProductDialog();

  @override
  State<_ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<_ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _unit = TextEditingController(text: 'liter');
  final _price = TextEditingController();
  final _stock = TextEditingController(text: '0');

  @override
  void dispose() {
    _name.dispose();
    _unit.dispose();
    _price.dispose();
    _stock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _textField(_name, 'Product name', required: true),
              const SizedBox(height: 12),
              _textField(_unit, 'Unit (e.g. liter, kg, pack)', required: true),
              const SizedBox(height: 12),
              _textField(_price, 'Price per unit', numeric: true),
              const SizedBox(height: 12),
              _textField(_stock, 'Opening stock', numeric: true),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              _ProductDraft(
                name: _name.text.trim(),
                unit: _unit.text.trim(),
                price: double.parse(_price.text.trim()),
                stock: double.parse(_stock.text.trim()),
              ),
            );
          },
          child: const Text('Add product'),
        ),
      ],
    );
  }
}

class _RestockDialog extends StatefulWidget {
  const _RestockDialog({required this.product});

  final Product product;

  @override
  State<_RestockDialog> createState() => _RestockDialogState();
}

class _RestockDialogState extends State<_RestockDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amount = TextEditingController();

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Restock ${widget.product.name}'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _amount,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: 'Quantity (${widget.product.unit})',
            helperText:
                'Currently in stock: ${quantityText(widget.product.stock)}',
          ),
          validator: (value) {
            final amount = double.tryParse(value ?? '');
            if (amount == null || amount <= 0) {
              return 'Enter a quantity greater than zero.';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(context, double.parse(_amount.text.trim()));
          },
          child: const Text('Update stock'),
        ),
      ],
    );
  }
}

class _CustomerDialog extends StatefulWidget {
  const _CustomerDialog();

  @override
  State<_CustomerDialog> createState() => _CustomerDialogState();
}

class _CustomerDialogState extends State<_CustomerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add customer'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Customer name'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a customer name.'
                  : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone number'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter a phone number.'
                  : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            Navigator.pop(
              context,
              Customer(name: _name.text.trim(), phone: _phone.text.trim()),
            );
          },
          child: const Text('Add customer'),
        ),
      ],
    );
  }
}

Widget _textField(
  TextEditingController controller,
  String label, {
  bool required = false,
  bool numeric = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: numeric
        ? const TextInputType.numberWithOptions(decimal: true)
        : TextInputType.text,
    decoration: InputDecoration(labelText: label),
    validator: (value) {
      final text = value?.trim() ?? '';
      if (required && text.isEmpty) return 'This field is required.';
      if (numeric) {
        final number = double.tryParse(text);
        if (number == null || number < 0) return 'Enter a valid amount.';
      }
      if (label == 'Price per unit' &&
          (double.tryParse(text) == null || double.parse(text) <= 0)) {
        return 'Price must be greater than zero.';
      }
      return null;
    },
  );
}
