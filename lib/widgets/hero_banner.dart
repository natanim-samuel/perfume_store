import 'package:flutter/material.dart';
import '../generated/app_localizations.dart';
import '../theme/app_theme.dart';

class HeroBanner extends StatefulWidget {
  const HeroBanner({super.key});

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final banners = [
      {
        'image': 'assets/images/banner1.png',
        'title': 'AQUA UNIVERSALIS',
        'sub': l10n.eauDeParfum,
        'colors': [const Color(0xFFF0C060), const Color(0xFF6A3010)],
      },
      {
        'image': 'assets/images/banner2.png',
        'title': 'SHALIMAR RITUAL',
        'sub': l10n.eauDeParfum,
        'colors': [const Color(0xFFD4A5FF), const Color(0xFF4A235A)],
      },
      {
        'image': 'assets/images/banner3.png',
        'title': 'GUERLAIN GARDENS',
        'sub': l10n.eauDeParfum,
        'colors': [const Color(0xFF8B3A52), const Color(0xFF6B2A3E)],
      },
    ];

    return Column(
      children: [
        // Featured label
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.featured,
              style: TextStyle(
                fontFamily: 'CormorantGaramond',
                fontSize: 12,
                letterSpacing: 3,
                color: context.textHintColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 190,
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: banners.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) {
                  final b = banners[i];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Image or gradient fallback
                          Image.asset(
                            b['image'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: b['colors'] as List<Color>,
                                ),
                              ),
                            ),
                          ),
                          // Dark overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                          // Text
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  b['title'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'CormorantGaramond',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 3,
                                    color: Colors.white,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  b['sub'] as String,
                                  style: TextStyle(
                                    fontFamily: 'CormorantGaramond',
                                    fontSize: 11,
                                    letterSpacing: 2,
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              // Dot indicators
              Positioned(
                bottom: 12,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(banners.length, (i) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: _currentPage == i ? 20 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentPage == i
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}