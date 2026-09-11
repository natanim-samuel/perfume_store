import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../repository/product_repository.dart';

// ── Basket item model ────────────────────────────────────────────────────────
class BasketItem {
  BasketItem({
    required this.product,
    this.quantity = 1,
  });

  final ProductModel product;
  int quantity;
}

enum AppTab { detail, categories }

// ── APP PROVIDER ─────────────────────────────────────────────────────────────
class AppProvider extends ChangeNotifier {
  AppProvider() : _repo = const ProductRepository();

  final ProductRepository _repo;

  // ── Tab navigation ────────────────────────────────────────────────────────
  AppTab _activeTab = AppTab.categories;

  AppTab get activeTab => _activeTab;

  void setTab(AppTab tab) {
    if (_activeTab == tab) return;

    _activeTab = tab;
    notifyListeners();
  }

  // ── Category filter ───────────────────────────────────────────────────────
  String _activeCategory = 'all';

  String get activeCategory => _activeCategory;

  void setCategory(String cat) {
    if (_activeCategory == cat) return;

    _activeCategory = cat;
    notifyListeners();
  }

  // ── Search ────────────────────────────────────────────────────────────────
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  void searchProducts(String query) {
    _searchQuery = query.toLowerCase().trim();
    notifyListeners();
  }

  // ── Products ──────────────────────────────────────────────────────────────
  List<ProductModel> get filteredProducts {
    final categoryProducts = _repo.getByCategory(_activeCategory);

    if (_searchQuery.isEmpty) {
      return categoryProducts;
    }

    return categoryProducts.where((product) {
      return product.nameKey.toLowerCase().contains(_searchQuery) ||
          product.subtitleKey.toLowerCase().contains(_searchQuery) ||
          product.category.toLowerCase().contains(_searchQuery);
    }).toList();
  }

  ProductModel get heroProduct => _repo.getHero();

  // ── Selected product (detail view) ───────────────────────────────────────
  ProductModel? _selectedProduct;

  ProductModel? get selectedProduct => _selectedProduct;

  void selectProduct(ProductModel product) {
    _selectedProduct = product;
    _activeTab = AppTab.detail;
    notifyListeners();
  }

  void clearSelection() {
    _selectedProduct = null;
    _activeTab = AppTab.categories;
    notifyListeners();
  }

  // ── Basket ────────────────────────────────────────────────────────────────
  final List<BasketItem> _basketItems = [];

  /// Unmodifiable view of basket items
  List<BasketItem> get basketItems => List.unmodifiable(_basketItems);

  /// Total number of individual units in basket
  int get basketCount =>
      _basketItems.fold(0, (sum, item) => sum + item.quantity);

  /// Alias used by footer
  int get totalQuantity => basketCount;

  /// Formatted total price string
  String get totalPrice {
    double total = 0;

    for (final item in _basketItems) {
      final cleaned = item.product.price
          .replaceAll('ETB', '')
          .replaceAll(',', '')
          .trim();

      total += (double.tryParse(cleaned) ?? 0) * item.quantity;
    }

    return 'ETB${total.toStringAsFixed(2)}';
  }

  /// Add product — increments quantity if already in basket
  void addToBasket(ProductModel product) {
    final existing = _basketItems.cast<BasketItem?>().firstWhere(
          (i) => i!.product.id == product.id,
      orElse: () => null,
    );

    if (existing != null) {
      existing.quantity++;
    } else {
      _basketItems.add(BasketItem(product: product));
    }

    notifyListeners();
  }

  /// Remove one item row by index
  void removeFromBasket(int index) {
    if (index < 0 || index >= _basketItems.length) return;

    _basketItems.removeAt(index);
    notifyListeners();
  }

  /// Decrement quantity; remove row if reaches zero
  void decrementBasketItem(int index) {
    if (index < 0 || index >= _basketItems.length) return;

    if (_basketItems[index].quantity > 1) {
      _basketItems[index].quantity--;
    } else {
      _basketItems.removeAt(index);
    }

    notifyListeners();
  }

  /// Increment quantity of existing item
  void incrementBasketItem(int index) {
    if (index < 0 || index >= _basketItems.length) return;

    _basketItems[index].quantity++;
    notifyListeners();
  }

  /// Remove all items
  void clearBasket() {
    _basketItems.clear();
    notifyListeners();
  }
}

// ── LOCALE PROVIDER ───────────────────────────────────────────────────────────
class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  bool get isAmharic => _locale.languageCode == 'am';

  void setLocale(Locale locale) {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();
  }

  void toggle() {
    _locale = isAmharic
        ? const Locale('en')
        : const Locale('am');

    notifyListeners();
  }
}

// ── THEME PROVIDER ────────────────────────────────────────────────────────────
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  void toggle() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    notifyListeners();
  }

  void setDark() {
    if (_themeMode == ThemeMode.dark) return;

    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void setLight() {
    if (_themeMode == ThemeMode.light) return;

    _themeMode = ThemeMode.light;
    notifyListeners();
  }
}