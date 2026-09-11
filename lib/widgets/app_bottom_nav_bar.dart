import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';
import '../screens/basket_screen.dart';


class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ap = context.watch<AppProvider>();

    return Container(
      decoration: BoxDecoration(
        color: context.bgColor.withOpacity(0.96),
        border: Border(top: BorderSide(color: context.borderColor)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: [
              if (ap.activeTab == AppTab.categories) ...[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        context.read<AppProvider>().searchProducts(value);
                      },
                      style: TextStyle(
                        color: context.textColor,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.search,
                        hintStyle: TextStyle(
                          color: context.textHintColor,
                          fontSize: 13,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 18,
                          color: context.textHintColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
              _NavIcon(
                icon: Icons.shopping_bag_outlined,
                badge: ap.basketCount,
                active: false,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BasketScreen()),
                ),
              ),
              const SizedBox(width: 28),
              _NavIcon(
                icon: Icons.person_outline_rounded,
                active: false,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    required this.active,
    required this.onTap,
    this.badge = 0,
  });

  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  final int badge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: 22,
            color: active ? context.goldColor : context.textHintColor,
          ),
          if (badge > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: context.goldColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$badge',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: context.isDark
                          ? const Color(0xFF0F0E0C)
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}