import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/links.dart';
import '../webview_screen.dart';

class LinkCard extends StatefulWidget {
  final LinkItem linkItem;

  const LinkCard({super.key, required this.linkItem});

  @override
  State<LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<LinkCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    ); // AnimationController
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openLink() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          title: widget.linkItem.title,
          url: widget.linkItem.url,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          _openLink();
        },
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? BUColors.cardDark : BUColors.cardLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? (isDark ? BUColors.secondaryGold : BUColors.primaryBlue)
                    : Colors.transparent,
                width: 1.5,
              ), // Border.all
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? (isDark ? BUColors.secondaryGold : BUColors.primaryBlue)
                          .withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.04),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: const Offset(0, 4),
                ), // BoxShadow
              ],
            ), // BoxDecoration
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Emoji icon container with BU branding gradient backdrop
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          BUColors.primaryBlue.withValues(alpha: 0.1),
                          BUColors.secondaryGold.withValues(alpha: 0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ), // LinearGradient
                      borderRadius: BorderRadius.circular(12),
                    ), // BoxDecoration
                    alignment: Alignment.center,
                    child: Text(
                      widget.linkItem.iconEmoji,
                      style: const TextStyle(fontSize: 24),
                    ), // Text
                  ), // Container
                  const SizedBox(width: 16),

                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.linkItem.title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : BUColors.textLightPrimary,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.linkItem.description,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: isDark ? BUColors.textDarkSecondary : BUColors.textLightSecondary,
                                fontSize: 13,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Trailing Launch Icon
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.open_in_new_rounded,
                      size: 16,
                      color: isDark
                          ? BUColors.secondaryGold.withValues(alpha: 0.8)
                          : BUColors.primaryBlue.withValues(alpha: 0.6),
                    ), // Icon
                  ), // Container
                ],
              ), // Row
            ), // Padding
          ), // AnimatedContainer
        ), // ScaleTransition
      ), // GestureDetector
    ); // MouseRegion
  }
}