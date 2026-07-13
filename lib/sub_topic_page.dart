import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'part.dart';
import 'pdf_page.dart';
import 'widgets/glass_container.dart';

class SubTopicPage extends StatefulWidget {
  const SubTopicPage({super.key});

  @override
  State<SubTopicPage> createState() => _SubTopicPageState();
}

class _SubTopicPageState extends State<SubTopicPage> {
  List<Part> _allParts = [];
  List<Part> _filteredParts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadParts();
  }

  Future<void> _loadParts() async {
    try {
      final rawData = await rootBundle.loadString('assets/parts.csv');
      List<List<dynamic>> listData =
          const CsvToListConverter(eol: '\n').convert(rawData);
      
      setState(() {
        _allParts = listData.skip(1).map((row) {
          return Part.fromCsv(row);
        }).toList();
        _filteredParts = _allParts;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading parts: $e', style: const TextStyle(color: Colors.white))),
        );
      }
    }
  }

  void _filterParts(String query) {
    final settings = context.read<SettingsProvider>();
    final isSinhala = settings.locale.languageCode == 'si';

    setState(() {
      _filteredParts = _allParts.where((part) {
        final categoryMatches = (part.parentCode ?? '').toLowerCase().contains(query.toLowerCase());
        final nameMatches = (isSinhala ? part.nameSi : part.nameEn).toLowerCase().contains(query.toLowerCase());
        return categoryMatches || nameMatches;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final settings = context.watch<SettingsProvider>();
    final isSinhala = settings.locale.languageCode == 'si';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.subTopics, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bike.jpg', fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GlassContainer(
                    opacity: 0.2,
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: l10n.searchSubTopics,
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
                        prefixIcon: const Icon(Icons.search, color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      onChanged: _filterParts,
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredParts.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off, size: 64, color: Colors.white.withValues(alpha: 0.5)),
                              const SizedBox(height: 16),
                              Text(
                                l10n.noMatchingTopics,
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _filteredParts.length,
                          itemBuilder: (context, index) {
                            final part = _filteredParts[index];
                            final isFav = settings.isFavorite(part.code);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to specific page logic (dummy page 1 for now)
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PdfPage(page: 1)));
                                },
                                child: GlassContainer(
                                  opacity: 0.1,
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.menu_book, color: Theme.of(context).primaryColor),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              part.parentCode ?? 'Topic',
                                              style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              isSinhala ? part.nameSi : part.nameEn,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          isFav ? Icons.bookmark : Icons.bookmark_border,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          settings.toggleFavorite(part.code);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}