import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String category;
  final double rating;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.rating = 0,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    String? category,
    double? rating,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, name, price, description, imageUrl, category, rating, isFavorite];
}

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  double get total => product.price * quantity;

  @override
  List<Object?> get props => [id, product, quantity];
}

class UserProfile extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String avatarUrl;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, phone, address, avatarUrl];
}

class FilterSortState extends Equatable {
  final String? selectedCategory;
  final SortOption sortOption;
  final double? minPrice;
  final double? maxPrice;

  const FilterSortState({
    this.selectedCategory,
    this.sortOption = SortOption.relevance,
    this.minPrice,
    this.maxPrice,
  });

  FilterSortState copyWith({
    String? selectedCategory,
    SortOption? sortOption,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterSortState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      sortOption: sortOption ?? this.sortOption,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [selectedCategory, sortOption, minPrice, maxPrice];
}

enum SortOption { relevance, priceAsc, priceDesc, rating }
