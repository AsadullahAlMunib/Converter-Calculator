import 'package:flutter/material.dart';
import 'theme.dart'; // নিশ্চিত করুন এই লাইনটি আছে
import 'home_screen.dart';
import 'convert_screen.dart';
import 'settings_screen.dart';

void main() => runApp(const ConverterApp());

class ConverterApp extends StatefulWidget {
  const ConverterApp({super.key});

  @override
  _ConverterAppState createState() => _ConverterAppState();
}

class _ConverterAppState extends State<ConverterApp> {
  bool _isDark = true;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Precision Pro',
      theme: AppTheme.lightTheme, // এখানে ভুল ধরছিল, এখন ঠিক হবে
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Precision Pro", style: TextStyle(fontWeight: FontWeight.w900)),
          centerTitle: true,
          actions: [
            Builder(builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle_outlined, color: Color(0xFF06B6D4), size: 30),
              onPressed: () => Navigator.push(context, MaterialPageRoute(
                builder: (c) => SettingsScreen(
                  isDark: _isDark, 
                  onThemeToggle: () => setState(() => _isDark = !_isDark)
                )
              )),
            )),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: _currentIndex == 0 ? HomeScreen() : ConvertScreen(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          selectedItemColor: const Color(0xFF06B6D4),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.calculate), label: "Calculator"),
            BottomNavigationBarItem(icon: Icon(Icons.swap_horizontal_circle), label: "Converter"),
          ],
        ),
      ),
    );
  }
}