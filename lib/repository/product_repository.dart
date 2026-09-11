import '../models/product_model.dart';

class ProductRepository {
  const ProductRepository();

  // FIX: was "static get products => null" — now returns actual list
  static List<ProductModel> get products => ProductModel.all;

  ProductModel getHero() => ProductModel.hero;
  List<ProductModel> getAll() => ProductModel.all;

  List<ProductModel> getByCategory(String category) {
    if (category == 'all') return ProductModel.all;
    return ProductModel.all.where((p) => p.category == category).toList();
  }

  ProductModel? getById(String id) {
    try {
      return ProductModel.all.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}