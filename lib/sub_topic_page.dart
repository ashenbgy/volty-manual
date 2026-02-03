import 'package:flutter/material.dart';
import 'part.dart';
import 'pdf_page.dart';
import 'package:flutter/services.dart';

class SubTopicPage extends StatefulWidget {
  final List<Part> children;
  const SubTopicPage({required this.children, super.key});

  @override
  State<SubTopicPage> createState() => _SubTopicPageState();
}

class _SubTopicPageState extends State<SubTopicPage> {
  late List<Part> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.children;
  }

  void _search(String q) {
    final query = q.toLowerCase();
    setState(() {
      _filtered = widget.children
          .where((c) =>
              c.nameEn.toLowerCase().contains(query) ||
              c.nameSi.toLowerCase().contains(query) ||
              c.code.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Select Sub Topic', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bike.jpg', fit: BoxFit.cover),
          Container(color: Colors.white.withOpacity(0.45)),
          Column(
            children: [
              const SizedBox(height: 100), // space below app-bar
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
                child: _filtered.isEmpty
                    ? const Center(
                        child: Text(
                          'No matching topics',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final c = _filtered[i];
                          final pageNo = c.page;
                          return Card(
                            color: Colors.white.withOpacity(0.8),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.brown[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  c.code,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(c.nameEn),
                              subtitle: Text(c.nameSi),
                              trailing: Text('p. ${c.page}'),
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PdfPage(page: pageNo),
                                ),
                              ),
                            ),
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