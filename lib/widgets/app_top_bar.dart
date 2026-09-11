import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/app_provider.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: const [
            _HamburgerIcon(),
            Spacer(),
            _ThemeToggleButton(),
            SizedBox(width: 10),
            _LangSwitcher(),
          ],
        ),
      ),
    );
  }
}

class _HamburgerIcon extends StatelessWidget {
  const _HamburgerIcon();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _line(context, 22),
        const SizedBox(height: 5),
        _line(context, 16),
        const SizedBox(height: 5),
        _line(context, 22),
      ],
    );
  }

  Widget _line(BuildContext context, double width) => Container(
    width: width,
    height: 1.5,
    decoration: BoxDecoration(
      color: context.textSubColor,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return GestureDetector(
      onTap: tp.toggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: context.surfaceColor,
          shape: BoxShape.circle,
          border: Border.all(color: context.borderColor),
        ),
        child: Center(
          child: Text(
            tp.isDark ? '🌙' : '☀️',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class _LangSwitcher extends StatelessWidget {
  const _LangSwitcher();

  @override
  Widget build(BuildContext context) {
    final lp = context.watch<LocaleProvider>();
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ['en', 'am'].map((lang) {
          final isActive = lp.locale.languageCode == lang;
          return GestureDetector(
            onTap: () => lp.setLocale(Locale(lang)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? context.goldColor : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                lang.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: isActive
                      ? (context.isDark
                      ? const Color(0xFF0F0E0C)
                      : Colors.white)
                      : context.textSubColor,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}