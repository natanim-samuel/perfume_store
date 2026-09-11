import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../models/product_model.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.animSlow,
    );
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;
    final product = widget.product;

    // ── No Scaffold — renders inside HomeScreen body ──────────────────────
    return FadeTransition(
      opacity: _fadeAnim,
      child: Column(
        children: [
          // ── Custom app bar ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                // BACK button — clears selectedProduct → goes back to grid
                IconButton(
                  onPressed: () => ap.clearSelection(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: context.textColor,
                    size: 20,
                  ),
                ),
                const Spacer(),
                // Basket icon with badge
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_bag_outlined,
                          color: context.textColor),
                    ),
                    if (ap.basketCount > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: context.goldColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${ap.basketCount}',
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          // ── Scrollable content ───────────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Bottle card ────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 340,
                    decoration: BoxDecoration(
                      gradient: product.gradient,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: context.borderColor),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.12),
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.08),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 230,
                              child: Image.asset(
                                'assets/images/${product.id}.png',
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                  'GUERLAIN',
                                  style: TextStyle(
                                    fontFamily: 'CormorantGaramond',
                                    fontSize: 14,
                                    letterSpacing: 3,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                ),
                              ),
                            ),
                        const SizedBox(height: 20),
                        // Dot indicators
                            const SizedBox(height: 16),
                            // Dot indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (i) {
                                return GestureDetector(
                                  onTap: () => setState(() => _dotIndex = i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    margin: const EdgeInsets.symmetric(horizontal: 4),
                                    width: _dotIndex == i ? 20 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: _dotIndex == i
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.35),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Product name ─────────────────────────────────────
                  Text(
                    product.nameKey,
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 13,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                      color: context.goldColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.subtitleKey,
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: context.textHintColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Description ──────────────────────────────────────
                  Text(
                    'An endless exploration and the source of many discoveries, '
                        'this fragrance reunites all the emotions of the Guerlain collection.',
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 16,
                      height: 1.7,
                      fontWeight: FontWeight.w300,
                      color: context.textSubColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Price ────────────────────────────────────────────
                  Text(
                    product.price,
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                      color: context.textColor,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Add to basket ────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ap.addToBasket(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.nameKey} added to basket',
                              style: const TextStyle(
                                  fontFamily: 'CormorantGaramond'),
                            ),
                            duration: const Duration(seconds: 1),
                            backgroundColor: context.goldColor,
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                      label: Text(
                        l10n.addToBasket,
                        style: const TextStyle(
                          fontFamily: 'CormorantGaramond',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.goldColor,
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}