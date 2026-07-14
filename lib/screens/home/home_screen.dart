import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/links.dart';
import '../../helpers/app_localizations.dart';
import '../../helpers/settings_controller.dart';
import '../../widgets/category_header.dart';
import '../../widgets/link_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 800;

    // Filter links based on search query
    final filteredLinks = allUniversityLinks.where((item) {
      final query = _searchQuery.toLowerCase();
      return item.title.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);
    }).toList();

    // Group filtered links by category
    final Map<String, List<LinkItem>> groupedLinks = {};
    for (var link in filteredLinks) {
      groupedLinks.putIfAbsent(link.category, () => []).add(link);
    }

    final settings = SettingsProvider.of(context);
    final loc = AppLocalizations.of(context);
    final isDark = settings.isDarkMode;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Beautiful Sliver App Bar with rich gradients and welcome hero
          SliverAppBar(
            expandedHeight: isDesktop ? 140.0 : 220.0,
            floating: false,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? BUColors.cardDark : BUColors.primaryBlue,
            // Removed the logo beside the BU Gateway title at the very top
            title: Text(
              loc.appTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_rounded, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                tooltip: loc.settingsTitle,
              ),
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: Colors.white,
                ),
                onPressed: () => settings.updateDarkMode(!isDark),
                tooltip: loc.toggleThemeTooltip,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Rich Background Gradient
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: isDark
                            ? [const Color(0xFF0F1E36), BUColors.backgroundDark]
                            : [BUColors.primaryBlue, const Color(0xFF1565C0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Abstract decorative shapes
                  Positioned(
                    top: -40,
                    right: -40,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        color: BUColors.secondaryGold.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -20,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.04),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Welcome message in the center
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: isDesktop ? 10 : 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Large logo in the header
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'docs/assets/bu_logo_placeholder.png',
                              height: isDesktop ? 36 : 54,
                              width: isDesktop ? 36 : 54,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.school_rounded,
                                color: BUColors.primaryBlue,
                                size: 36,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Removed the welcome to bu gateway statement text
                          Text(
                            loc.slogan,
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Persistent Search Bar underneath
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(64.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                alignment: Alignment.center,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? BUColors.backgroundDark : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: loc.searchPlaceholder,
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[500] : Colors.grey[400],
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: isDark ? BUColors.secondaryGold : BUColors.primaryBlue,
                      ),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, size: 20),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 13),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          
          // Link List
          if (filteredLinks.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        loc.noResults,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else if (isDesktop)
            // Desktop Layout: Two side-by-side columns to fit on a single screen without scrolling
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: 16.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildCategoryWidgets(groupedLinks, [
                          'Primary',
                          'Academic',
                          'Staff Portal',
                          'Learning'
                        ]),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildCategoryWidgets(groupedLinks, [
                          'Finance',
                          'Library',
                          'Research'
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            // Mobile Layout: Single column list
            ..._buildSlivers(context, groupedLinks, screenWidth),
            
          // Footer
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Column(
                children: [
                  const Divider(indent: 32, endIndent: 32),
                  const SizedBox(height: 12),
                  Text(
                    loc.slogan,
                    style: const TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.footerCopyright,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCategoryWidgets(
    Map<String, List<LinkItem>> groupedLinks,
    List<String> categories,
  ) {
    final List<Widget> widgets = [];
    for (var cat in categories) {
      final links = groupedLinks[cat];
      if (links == null || links.isEmpty) continue;

      widgets.add(CategoryHeader(title: cat));
      widgets.add(
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: links.length,
          itemBuilder: (context, index) => LinkCard(linkItem: links[index]),
        ),
      );
    }
    return widgets;
  }

  List<Widget> _buildSlivers(
    BuildContext context,
    Map<String, List<LinkItem>> groupedLinks,
    double screenWidth,
  ) {
    final List<Widget> slivers = [];
    
    // Sort categories
    final categoriesInOrder = [
      'Primary',
      'Academic',
      'Staff Portal',
      'Learning',
      'Finance',
      'Library',
      'Research',
    ];
    
    final activeCategories = categoriesInOrder
        .where((cat) => groupedLinks.containsKey(cat))
        .toList();
    
    for (var cat in groupedLinks.keys) {
      if (!activeCategories.contains(cat)) {
        activeCategories.add(cat);
      }
    }
    
    for (var cat in activeCategories) {
      final links = groupedLinks[cat]!;
      if (links.isEmpty) continue;
      
      // Category Header
      slivers.add(
        SliverToBoxAdapter(
          child: CategoryHeader(title: cat),
        ),
      );
      
      // Category Links
      slivers.add(
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => LinkCard(linkItem: links[index]),
            childCount: links.length,
          ),
        ),
      );
    }
    
    return slivers;
  }
}

