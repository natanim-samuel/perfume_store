import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.nameKey,
    required this.subtitleKey,
    required this.price,
    required this.category,
    required this.gradientColors,
  });

  final String id;
  final String nameKey;
  final String subtitleKey;
  final String price;
  final String category;
  final List<Color> gradientColors;

  LinearGradient get gradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientColors,
  );

  static const hero = ProductModel(
    id: AppConstants.pidAqua,
    nameKey: 'AQUA UNIVERSALIS',
    subtitleKey: 'EAU DE PARFUM 125ML',
    price: '£90.00',
    category: AppConstants.catAll,
    gradientColors: [
      Color(0xFFF0C060),
      Color(0xFFC8803A),
      Color(0xFF6A3010),
    ],
  );

  static const List<ProductModel> all = [
    ProductModel(
      id: AppConstants.pidGardens,
      nameKey: 'GUERLAIN GARDENS',
      subtitleKey: 'EAU DE PARFUM 125ML',
      price: 'ETB 70.00',
      category: AppConstants.catFemme,
      gradientColors: AppColors.gardenColors,
    ),
    ProductModel(
      id: AppConstants.pidShalimar,
      nameKey: 'SHALIMAR DETAIL',
      subtitleKey: 'EAU DE PARFUM 90ML',
      price: 'ETB 60.00',
      category: AppConstants.catFemme,
      gradientColors: AppColors.shalimarColors,
    ),
    ProductModel(
      id: AppConstants.pidDreams,
      nameKey: 'GUERLAIN DREAMS',
      subtitleKey: 'EAU DE PARFUM 125ML',
      price: 'ETB 95.00',
      category: AppConstants.catVoyager,
      gradientColors: AppColors.dreamsColors,
    ),
    ProductModel(
      id: AppConstants.pidRitual,
      nameKey: 'SHALIMAR RITUAL',
      subtitleKey: 'EAU DE PARFUM 90ML',
      price: 'ETB 80.00',
      category: AppConstants.catPerfum,
      gradientColors: AppColors.ritualColors,
    ),
  ];
}