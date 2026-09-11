import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../generated/app_localizations.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tp = context.watch<ThemeProvider>();
    final lp = context.watch<LocaleProvider>();

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar — identical to AppTopBar ──────────────────────────
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  // App name / hamburger area
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _navLine(context, 22),
                      const SizedBox(height: 5),
                      _navLine(context, 16),
                      const SizedBox(height: 5),
                      _navLine(context, 22),
                    ],
                  ),
                  const Spacer(),
                  // Theme toggle — identical to _ThemeToggleButton
                  GestureDetector(
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
                  ),
                  const SizedBox(width: 10),
                  // Language switcher — identical to _LangSwitcher
                  Container(
                    decoration: BoxDecoration(
                      color: context.surfaceColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: context.borderColor),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: ['en', 'am'].map((lang) {
                        final isActive =
                            lp.locale.languageCode == lang;
                        return GestureDetector(
                          onTap: () => lp.setLocale(Locale(lang)),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? context.goldColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              lang.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'CormorantGaramond',
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
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── Hero bottle ───────────────────────────────────────────────
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(horizontal: 48),
              decoration: BoxDecoration(
                color: context.surfaceColor,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: context.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: context.isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/images/aqua.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFF0C060),
                          const Color(0xFFC8803A),
                          const Color(0xFF6A3010),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 56,
                          height: 18,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2244AA),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 100,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white30),
                          ),
                          child: Center(
                            child: Text(
                              'GUERLAIN',
                              style: TextStyle(
                                fontFamily: 'CormorantGaramond',
                                color: Colors.white,
                                letterSpacing: 3,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ── Text block ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  Text(
                    l10n.luxuryPerfumes,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      height: 1.1,
                      letterSpacing: 2,
                      color: context.textColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Gold divider — same style as detail screen accent
                  Container(
                    width: 36,
                    height: 1,
                    color: context.goldColor,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l10n.discover,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      height: 1.7,
                      letterSpacing: 0.3,
                      color: context.textSubColor,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ── CTA button — same style as Add to basket ─────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const HomeScreen()),
                  ),
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
                    l10n.getStarted,
                    style: const TextStyle(
                      fontFamily: 'CormorantGaramond',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _navLine(BuildContext context, double width) => Container(
    width: width,
    height: 1.5,
    decoration: BoxDecoration(
      color: context.textSubColor,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}