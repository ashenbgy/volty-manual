import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('About',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/bike.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.45)),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                'Volty Bike Manual App\n\n'
                'Version 1.0.0\n'
                'A simple offline manual viewer with search.\n'
                'Built with Flutter.\n\n\n\n\n'
                '           r==\n'
                '        _  //\n'
                '       |_)//(\'\'\'\':\n'
                '         //  \\_____:_____.-----.P\n'
                '        //   | ===  |   /        \\\n'
                '    .:\'//.   \\ \\=|   \\ /  .:\'\':.\n'
                '   :\': // \':   \\ \\ \'\'..\'--:\'-.. \':\n'
                '   \'.\' \'\' .\'    \\:.....:--\'.-\'\' .\'\n'
                '    \':..:\'                \':..:\'',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.05,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}