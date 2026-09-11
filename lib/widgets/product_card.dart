import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/product_model.dart';
import '../providers/app_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final ap = context.read<AppProvider>();

    return GestureDetector(
      onTap: () => ap.selectProduct(widget.product),
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) => setState(() => _hovered = false),
      onTapCancel: () => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.borderColor),
          boxShadow: _hovered
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Product name
            Text(
              widget.product.nameKey,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'CormorantGaramond',
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
                color: context.textSubColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),

            // ── Bottle: gradient background + transparent PNG on top ─────
            Container(
              width: 85,
              height: 95,
              decoration: BoxDecoration(
                // Gradient is the background color — visible through
                // transparent parts of the PNG
                gradient: widget.product.gradient,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Subtle shine on the gradient
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.18),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // PNG image — transparent bg shows gradient underneath
                  // Do NOT use ClipRRect here; it causes black fill on
                  // transparent PNGs
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      'assets/images/${widget.product.id}.png',
                      fit: BoxFit.contain,
                      // No ClipRRect wrapper — keeps transparency intact
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          'GUERLAIN',
                          style: TextStyle(
                            fontFamily: 'CormorantGaramond',
                            fontSize: 7,
                            letterSpacing: 1.5,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Subtitle
            Text(
              widget.product.subtitleKey,
              style: TextStyle(
                fontFamily: 'CormorantGaramond',
                fontSize: 8,
                letterSpacing: 1.5,
                color: context.textHintColor,
              ),
            ),
            const SizedBox(height: 6),

            // Price
            Text(
              widget.product.price,
              style: TextStyle(
                fontFamily: 'CormorantGaramond',
                fontSize: 18,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
                color: context.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}