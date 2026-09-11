import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_top_bar.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/category_row.dart';
import '../widgets/hero_banner.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final showDetail =
        ap.activeTab == AppTab.detail && ap.selectedProduct != null;

    return Scaffold(
      backgroundColor: context.bgColor,
      // ── Hide top bar and bottom nav when in detail view ────────────────
      appBar: showDetail ? null : const AppTopBar(),
      bottomNavigationBar: showDetail ? null : const AppBottomNavBar(),
      body: showDetail
          ? SafeArea(
        child: DetailScreen(product: ap.selectedProduct!),
      )
          : _CategoriesTab(ap: ap, l10n: l10n),
    );
  }
}

class _CategoriesTab extends StatelessWidget {
  const _CategoriesTab({required this.ap, required this.l10n});
  final AppProvider ap;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final products = ap.filteredProducts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeroBanner(),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            l10n.categories,
            style: TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 30,
              fontWeight: FontWeight.w300,
              letterSpacing: 2,
              color: context.textColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        CategoryRow(
          categories: AppConstants.categories,
          selected: ap.activeCategory,
          onChanged: ap.setCategory,
        ),
        const SizedBox(height: 16),
        Expanded(
          child: products.isEmpty
              ? Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                fontFamily: 'CormorantGaramond',
                color: context.textHintColor,
                fontSize: 16,
              ),
            ),
          )
              : GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemCount: products.length,
            itemBuilder: (context, i) {
              return ProductCard(product: products[i]);
            },
          ),
        ),
      ],
    );
  }
}