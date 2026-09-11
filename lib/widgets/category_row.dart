import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';

class CategoryRow extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onChanged;

  const CategoryRow({
    super.key,
    required this.categories,
    required this.selected,
    required this.onChanged,
  });

  String _label(String cat, AppLocalizations l10n) {
    switch (cat) {
      case 'all': return l10n.allCategory;
      case 'femme': return l10n.femmeCategory;
      case 'voyager': return l10n.voyagerCategory;
      case 'perfum': return l10n.parfumCategory;
      case 'home': return l10n.homeCategory;
      default: return cat.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (_, i) {
          final cat = categories[i];
          final isSelected = selected == cat;
          return GestureDetector(
            onTap: () => onChanged(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? context.goldColor : context.surfaceColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? context.goldColor : context.borderColor,
                ),
              ),
              child: Text(
                _label(cat, l10n),
                style: TextStyle(
                  fontFamily: 'CormorantGaramond',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: isSelected
                      ? (context.isDark ? Colors.black : Colors.white)
                      : context.textSubColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}