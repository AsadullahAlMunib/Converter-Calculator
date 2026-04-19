import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // লিঙ্ক ওপেন করার জন্য

class SettingsScreen extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  SettingsScreen({required this.isDark, required this.onThemeToggle});

  // GitHub লিঙ্ক ওপেন করার ফাংশন
  void _launchURL() async {
    const url = 'https://github.com/AsadullahAlMunib'; // আপনার GitHub লিঙ্ক
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = const Color(0xFF06B6D4);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings & Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: accentColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // প্রোফাইল সেকশন
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [accentColor.withOpacity(0.2), Colors.transparent]),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: accentColor.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: accentColor,
                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 15),
                const Text("Asadullah Al Munib", 
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text("Student & Developer", 
                  style: TextStyle(color: Colors.grey, letterSpacing: 1.2)),
                const SizedBox(height: 15),
                
                // GitHub বাটন
                ElevatedButton.icon(
                  onPressed: _launchURL,
                  icon: const Icon(Icons.code),
                  label: const Text("GitHub"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 30),
          const Text("Preference", style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // থিম টগল কার্ড
          _buildTile(
            icon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: "Dark Mode",
            isDark: isDark,
            trailing: Switch(
              value: isDark,
              onChanged: (_) => onThemeToggle(),
              activeColor: accentColor,
            ),
          ),

          const SizedBox(height: 15),
          const Text("App Info", style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          _buildTile(
            icon: Icons.info_outline,
            title: "Version",
            isDark: isDark,
            trailing: const Text("1.0.0", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  Widget _buildTile({required IconData icon, required String title, required Widget trailing, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: const Color(0xFF06B6D4)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: trailing,
      ),
    );
  }
}