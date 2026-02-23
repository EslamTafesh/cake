class Item {
  final int id;
  final String name;
  final String type;
  final String category;
  final double price;
  final double originalPrice;
  final String description;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final int calories;
  final bool isFeatured;
  final bool isNew;
  final double discount;
  final List<String> ingredients;
  final List<String> sizes;

  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    required this.price,
    this.originalPrice = 0.0,
    required this.description,
    required this.imagePath,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.calories = 0,
    this.isFeatured = false,
    this.isNew = false,
    this.discount = 0.0,
    this.ingredients = const [],
    this.sizes = const ['Regular', 'Large'],
  });

  bool get hasDiscount => discount > 0;
  bool get hasOriginalPrice => originalPrice > 0;
}
