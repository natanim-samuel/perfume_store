import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AppProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────────
            _BasketTopBar(l10n: l10n),

            // Gold divider line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 1,
                color: context.goldColor.withOpacity(0.3),
              ),
            ),

            // ── Content ──────────────────────────────────────────────────
            Expanded(
              child: ap.basketItems.isEmpty
                  ? _EmptyBasket(l10n: l10n)
                  : _BasketList(ap: ap, l10n: l10n),
            ),

            // ── Footer ───────────────────────────────────────────────────
            if (ap.basketItems.isNotEmpty)
              _BasketFooter(ap: ap, l10n: l10n),
          ],
        ),
      ),
    );
  }
}

// ── Top bar ──────────────────────────────────────────────────────────────────
class _BasketTopBar extends StatelessWidget {
  final AppLocalizations l10n;
  const _BasketTopBar({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          // Back button
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textColor,
              size: 20,
            ),
          ),
          // Centred title
          Expanded(
            child: Text(
              l10n.basket,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'CormorantGaramond',
                fontSize: 20,
                fontWeight: FontWeight.w400,
                letterSpacing: 4,
                color: context.textColor,
              ),
            ),
          ),
          // Placeholder to balance back button
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyBasket extends StatelessWidget {
  final AppLocalizations l10n;
  const _EmptyBasket({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 72,
            color: context.textHintColor,
          ),
          const SizedBox(height: 24),
          Text(
            l10n.basketEmpty,
            style: TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 24,
              fontWeight: FontWeight.w300,
              letterSpacing: 1,
              color: context.textHintColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.basketEmptySub,
            style: TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: context.textHintColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Basket list ───────────────────────────────────────────────────────────────
class _BasketList extends StatelessWidget {
  final AppProvider ap;
  final AppLocalizations l10n;
  const _BasketList({required this.ap, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemCount: ap.basketItems.length,
      separatorBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Divider(color: context.borderColor, height: 1),
      ),
      itemBuilder: (context, i) {
        final item = ap.basketItems[i];
        return _BasketItemRow(
          item: item,
          index: i,
          ap: ap,
          l10n: l10n,
        );
      },
    );
  }
}

// ── Single item row ───────────────────────────────────────────────────────────
class _BasketItemRow extends StatelessWidget {
  final BasketItem item;
  final int index;
  final AppProvider ap;
  final AppLocalizations l10n;

  const _BasketItemRow({
    required this.item,
    required this.index,
    required this.ap,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Thumbnail ─────────────────────────────────────────────────
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: item.product.gradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                'assets/images/${item.product.id}.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(
                    'G',
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // ── Info ──────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.nameKey,
                  style: TextStyle(
                    fontFamily: 'CormorantGaramond',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5,
                    color: context.textColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.product.subtitleKey,
                  style: TextStyle(
                    fontFamily: 'CormorantGaramond',
                    fontSize: 10,
                    letterSpacing: 1.5,
                    color: context.textHintColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Price per unit
                Text(
                  item.product.price,
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

          const SizedBox(width: 12),

          // ── Quantity controls + remove ────────────────────────────────
          Column(
            children: [
              // Remove entire row
              GestureDetector(
                onTap: () => ap.removeFromBasket(index),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: context.surfaceColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.borderColor),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: 15,
                    color: context.textHintColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Quantity row: − qty +
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _QtyButton(
                    icon: Icons.remove,
                    onTap: () => ap.decrementBasketItem(index),
                    context: context,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '${item.quantity}',
                      style: TextStyle(
                        fontFamily: 'CormorantGaramond',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: context.textColor,
                      ),
                    ),
                  ),
                  _QtyButton(
                    icon: Icons.add,
                    onTap: () => ap.incrementBasketItem(index),
                    context: context,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Quantity +/- button ───────────────────────────────────────────────────────
class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final BuildContext context;

  const _QtyButton({
    required this.icon,
    required this.onTap,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: ctx.surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ctx.borderColor),
        ),
        child: Icon(icon, size: 14, color: ctx.textColor),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────
class _BasketFooter extends StatelessWidget {
  final AppProvider ap;
  final AppLocalizations l10n;
  const _BasketFooter({required this.ap, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 36),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        border: Border(
          top: BorderSide(color: context.borderColor),
        ),
      ),
      child: Column(
        children: [
          // Total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.totalItems(ap.totalQuantity),
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 14,
                  letterSpacing: 0.5,
                  color: context.textSubColor,
                ),
              ),
              Text(
                ap.totalPrice,
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  color: context.textColor,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Cancel all orders
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => _ClearDialog(ap: ap, l10n: l10n),
              ),
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 16,
                color: context.textSubColor,
              ),
              label: Text(
                l10n.cancelAllOrders,
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 14,
                  letterSpacing: 2,
                  color: context.textSubColor,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Checkout
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {
                // Checkout action — wire to payment later
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.goldColor,
                foregroundColor: context.isDark
                    ? const Color(0xFF0F0E0C)
                    : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                l10n.checkout,
                style: const TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Clear all confirmation dialog ─────────────────────────────────────────────
class _ClearDialog extends StatelessWidget {
  final AppProvider ap;
  final AppLocalizations l10n;
  const _ClearDialog({required this.ap, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.surfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        l10n.cancelAllOrders,
        style: TextStyle(
          fontFamily: 'CormorantGaramond',
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 1,
          color: context.textColor,
        ),
      ),
      content: Text(
        l10n.cancelAllConfirm,
        style: TextStyle(
          fontFamily: 'CormorantGaramond',
          fontSize: 15,
          fontWeight: FontWeight.w300,
          height: 1.6,
          color: context.textSubColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.no,
            style: TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 15,
              letterSpacing: 1,
              color: context.textSubColor,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ap.clearBasket();
            Navigator.pop(context);
          },
          child: Text(
            l10n.yes,
            style: TextStyle(
              fontFamily: 'CormorantGaramond',
              fontSize: 15,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: context.goldColor,
            ),
          ),
        ),
      ],
    );
  }
}