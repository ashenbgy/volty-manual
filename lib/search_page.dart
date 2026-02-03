// lib/search_page.dart
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'pdf_page.dart';
import 'part.dart';
import 'package:flutter/services.dart';
import 'sub_topic_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Part> _parts = [];
  List<Part> _filtered = [];

  @override
  void initState() {
    super.initState();
    _loadParts();
  }

  void _loadParts() async {
    final csv = await DefaultAssetBundle.of(context).loadString('assets/parts.csv');
    debugPrint('CSV first line: ${csv.split('\n').first}');
    final rows = const CsvToListConverter().convert(csv, eol: '\n');
    _parts = rows.skip(1).map((r) => Part.fromCsv(r)).toList();
    _filtered = _parts.where((p) => p.parentCode == null).toList(); // ← parents only
    setState(() {});
  }

  void _search(String q) {
    final query = q.toLowerCase();
    setState(() {
      _filtered = _parts
          .where((p) =>
              p.nameEn.toLowerCase().contains(query) ||
              p.nameSi.toLowerCase().contains(query) ||
              p.code.toLowerCase().contains(query))
          .toList();
    });
  }

  void _jumpToPart(Part p) {
    final children = _parts.where((c) => c.parentCode == p.code).toList();
    if (children.isEmpty) {                       // leaf → open PDF
      final pageNo = p.page; 
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => PdfPage(page: pageNo)));
    } else {                                      // parent → show children
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => SubTopicPage(children: children)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // image under status bar
      appBar: AppBar(
        title: const Text('Search', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bike.jpg', fit: BoxFit.cover),
          Container(color: Colors.white.withOpacity(0.45)),
          Column(
            children: [
              const SizedBox(height: 100), // space below transparent AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: _search,
                ),
              ),
              Expanded(
                child: _parts.isEmpty
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final p = _filtered[i];
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  p.code,
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(p.nameEn),
                              subtitle: Text(p.nameSi),
                              onTap: () => _jumpToPart(p),
                            )
                          );
                        },
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}