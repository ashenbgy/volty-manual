import 'package:flutter/material.dart';
import 'search_page.dart';
import 'explore_page.dart';
import 'about_page.dart';
import 'package:flutter/services.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        // 1. make it see-through
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,

        // 2. left-aligned big headline
        title: const Text(
          'Bike Manual',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,

        // 3. system-icon colour that works on your odometer image
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,

        // 4. optional pop-up menu (kebab) on the right
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            color: Colors.brown[50],
            onSelected: (val) {
              switch (val) {
                case 'explore':
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ExplorePage()));
                  break;
                case 'search':
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchPage()));
                  break;
                case 'about':
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
                  break;
                case 'exit':
                  SystemNavigator.pop(); // <-- closes the app
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'explore', child: Text('Explore')),
              const PopupMenuItem(value: 'search', child: Text('Search')),
              const PopupMenuItem(value: 'about', child: Text('About')),
              const PopupMenuItem(value: 'exit', child: Text('Exit')),
            ],
          ),
        ]
      ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        // background
        Image.asset(
          'assets/odometer.jpg',
          fit: BoxFit.cover,
        ),
        // slight dark tint so buttons stay readable
        Container(color: Colors.black.withOpacity(0.4)),
        // buttons
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _menuButton(context, 'Explore', Icons.explore, const ExplorePage()),
              const SizedBox(height: 24),
              _menuButton(context, 'Search', Icons.search, const SearchPage()),
              const SizedBox(height: 24),
              _menuButton(context, 'About', Icons.info, const AboutPage()),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _menuButton(BuildContext ctx, String label, IconData icon, Widget page) {
  return ElevatedButton.icon(
    icon: Icon(icon, size: 28),
    label: Text(label, style: const TextStyle(fontSize: 20)),
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(200, 60),
      backgroundColor: Colors.white.withOpacity(0.85), // normal colour
      foregroundColor: Colors.black,                   // normal text/icon
      overlayColor: Colors.brown.withOpacity(0.8),     // splash / highlight
    ),
    onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
  );
}
}