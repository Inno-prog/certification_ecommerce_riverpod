// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shop';

  @override
  String get home => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get cart => 'Cart';

  @override
  String get profile => 'Profile';

  @override
  String get orders => 'Orders';

  @override
  String get productDetail => 'Product detail';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(String name) {
    return '$name added to cart';
  }

  @override
  String get viewCart => 'View';

  @override
  String get emptyCart => 'Your cart is empty';

  @override
  String get emptyFavorites => 'No favorites yet';

  @override
  String get emptyOrders => 'No orders yet';

  @override
  String get total => 'Total';

  @override
  String get checkout => 'Checkout';

  @override
  String get checkoutSoon => 'Payment coming soon';

  @override
  String get quantity => 'Quantity';

  @override
  String get noProductFound => 'No product found';

  @override
  String get productNotFound => 'Product not found';

  @override
  String get error => 'Error';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get sortBy => 'Sort by';

  @override
  String get filterBy => 'Filter';

  @override
  String get allCategories => 'All';

  @override
  String get relevance => 'Relevance';

  @override
  String get priceLowHigh => 'Price: low to high';

  @override
  String get priceHighLow => 'Price: high to low';

  @override
  String get topRated => 'Top rated';

  @override
  String get rating => 'Rating';

  @override
  String get description => 'Description';

  @override
  String get orderPlaced => 'Order placed!';

  @override
  String get orderDate => 'Date';

  @override
  String get orderStatus => 'Status';

  @override
  String get orderStatusPending => 'Pending';

  @override
  String get orderStatusShipped => 'Shipped';

  @override
  String get orderStatusDelivered => 'Delivered';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get darkMode => 'Dark mode';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get clearCart => 'Clear cart';

  @override
  String get clearCartConfirm => 'Clear the entire cart?';

  @override
  String items(int count) {
    return '$count item(s)';
  }
}
