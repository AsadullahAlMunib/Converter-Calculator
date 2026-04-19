import 'package:flutter/material.dart';

class ConvertScreen extends StatefulWidget {
  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  String _input = "0";
  String _result = "0";
  String _currentCat = "Length";
  String _from = "Meter";
  String _to = "Km";

  final Map<String, Map<String, double>> _data = {
    'Length': {'Meter': 1, 'Km': 1000, 'Cm': 0.01, 'Mm': 0.001, 'Mile': 1609.34, 'Foot': 0.3048, 'Inch': 0.0254, 'Yard': 0.9144},
    'Mass': {'Kg': 1, 'Gram': 0.001, 'Mg': 1e-6, 'Ton': 1000, 'Pound': 0.4535, 'Ounce': 0.0283},
    'Temp': {'Celsius': 1, 'Fahrenheit': 1, 'Kelvin': 1},
    'Time': {'Sec': 1, 'Min': 60, 'Hour': 3600, 'Day': 86400, 'Week': 604800, 'Year': 3.154e+7},
    'Digital': {'Byte': 1, 'KB': 1024, 'MB': 1.04e+6, 'GB': 1.07e+9, 'TB': 1.09e+12},
    'Speed': {'m/s': 1, 'km/h': 0.277, 'mph': 0.447, 'knot': 0.514},
    'Energy': {'Joule': 1, 'Calorie': 4.184, 'kWh': 3.6e+6},
    'Pressure': {'Pascal': 1, 'Bar': 100000, 'Atm': 101325, 'PSI': 6894},
  };

  void _convert() {
    double v = double.tryParse(_input) ?? 0;
    if (_currentCat == 'Temp') {
      double res = 0;
      if (_from == _to) res = v;
      else if (_from == 'Celsius' && _to == 'Fahrenheit') res = (v * 9/5) + 32;
      else if (_from == 'Fahrenheit' && _to == 'Celsius') res = (v - 32) * 5/9;
      setState(() => _result = res.toStringAsFixed(2));
      return;
    }
    double f = _data[_currentCat]![_from]!;
    double t = _data[_currentCat]![_to]!;
    setState(() => _result = ((v * f) / t).toStringAsPrecision(6).replaceAll(RegExp(r'0*$'), '').replaceAll(RegExp(r'\.$'), ''));
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          colors: isDark ? [Color(0xFF0F172A), Color(0xFF1E293B)] : [Color(0xFFE2E8F0), Colors.white],
        ),
      ),
      child: Column(
        children: [
          _buildCats(isDark),
          _buildCard(isDark),
          _buildKeypad(isDark),
        ],
      ),
    );
  }

  Widget _buildCats(bool isDark) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _data.keys.map((c) => GestureDetector(
          onTap: () => setState(() { _currentCat = c; _from = _data[c]!.keys.first; _to = _data[c]!.keys.last; _convert(); }),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              gradient: _currentCat == c ? LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)]) : null,
              color: _currentCat == c ? null : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
              borderRadius: BorderRadius.circular(20),
              boxShadow: _currentCat == c ? [BoxShadow(color: Colors.cyan.withOpacity(0.4), blurRadius: 10)] : [],
            ),
            child: Center(child: Text(c, style: TextStyle(fontWeight: FontWeight.bold, color: _currentCat == c ? Colors.white : (isDark ? Colors.white60 : Colors.black54)))),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildCard(bool isDark) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white24),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: Column(children: [
        _row(_from, _input, true, isDark),
        Divider(height: 40, color: Colors.cyan.withOpacity(0.3), thickness: 2),
        _row(_to, _result, false, isDark),
      ]),
    );
  }

  Widget _row(String u, String v, bool isFrom, bool isDark) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      DropdownButton<String>(
        value: u,
        dropdownColor: isDark ? Color(0xFF1E293B) : Colors.white,
        items: _data[_currentCat]!.keys.map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: isDark ? Colors.white : Colors.black87)))).toList(),
        onChanged: (val) => setState(() { if(isFrom) _from = val!; else _to = val!; _convert(); }),
        underline: SizedBox(),
      ),
      Flexible(child: Text(v, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: isFrom ? (isDark ? Colors.white : Colors.black) : Color(0xFF2DA5D7)), overflow: TextOverflow.ellipsis)),
    ]);
  }

  Widget _buildKeypad(bool isDark) {
    var keys = ["7", "8", "9", "4", "5", "6", "1", "2", "3", ".", "0", "⌫"];
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 40),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.8),
        itemCount: keys.length,
        itemBuilder: (context, i) => InkWell(
          onTap: () => setState(() {
            if(keys[i] == "⌫") _input = _input.length > 1 ? _input.substring(0, _input.length-1) : "0";
            else _input = _input == "0" ? keys[i] : _input + keys[i];
            _convert();
          }),
          child: Center(child: Text(keys[i], style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: isDark ? Colors.white70 : Colors.black87))),
        ),
      ),
    );
  }
}