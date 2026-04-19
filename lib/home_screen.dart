import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _eq = "0";
  String _res = "0";

  void _press(String t) {
    setState(() {
      if (t == "AC") {
        _eq = "0";
        _res = "0";
      } else if (t == "⌫") {
        _eq = _eq.length > 1 ? _eq.substring(0, _eq.length - 1) : "0";
      } else if (t == "=") {
        try {
          Parser p = Parser();
          Expression exp = p.parse(_eq.replaceAll('×', '*').replaceAll('÷', '/'));
          _res = '${exp.evaluate(EvaluationType.REAL, ContextModel())}';
          if (_res.endsWith(".0")) _res = _res.substring(0, _res.length - 2);
        } catch (e) {
          _res = "Error";
        }
      } else {
        if (_eq == "0") _eq = t;
        else _eq += t;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(_eq, style: TextStyle(fontSize: 28, color: Colors.grey)),
                const SizedBox(height: 10),
                Text(_res, style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: const Color(0xFF2DA5D7))),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
            boxShadow: isDark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)],
          ),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: ["(", ")", "AC", "÷", "7", "8", "9", "×", "4", "5", "6", "-", "1", "2", "3", "+", ".", "0", "⌫", "="]
                .map((t) => _buildBtn(t, isDark)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildBtn(String t, bool isDark) {
    // কালার ক্যাটাগরি লজিক
    LinearGradient? btnGradient;
    Color? btnColor;
    Color textColor = isDark ? Colors.white : Colors.black87;

    if (t == "=") {
      // ইকুয়াল বাটন: ভায়োলেট গ্রেডিয়েন্ট
      btnGradient = const LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)]);
      textColor = Colors.white;
    } else if (["+", "-", "×", "÷"].contains(t)) {
      // অপারেটর: অরেঞ্জ/এম্বার গ্রেডিয়েন্ট
      btnGradient = const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)]);
      textColor = Colors.white;
    } else if (["AC", "⌫"].contains(t)) {
      // ডিলিট/ক্লিয়ার: রেড/পিঙ্ক গ্রেডিয়েন্ট
      btnGradient = const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFEC4899)]);
      textColor = Colors.white;
    } else if (["(", ")", "."].contains(t)) {
      // স্পেশাল ক্যারেক্টার: ব্লু/সায়ান গ্রেডিয়েন্ট
      btnGradient = const LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)]);
      textColor = Colors.white;
    } else {
      // সাধারণ নাম্বার বাটন
      btnColor = isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05);
    }

    return GestureDetector(
      onTap: () => _press(t),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: btnGradient,
          color: btnColor,
          boxShadow: btnGradient != null 
              ? [BoxShadow(color: btnGradient.colors.first.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] 
              : [],
        ),
        child: Center(
          child: Text(t, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: textColor)),
        ),
      ),
    );
  }
}