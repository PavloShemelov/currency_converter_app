import 'package:flutter/material.dart';
import 'currency_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();
  final britishController = TextEditingController();
  final yenController = TextEditingController(); // Yen controller

  double dollar = 0.0;
  double euro = 0.0;
  double british = 0.0;
  double yen = 0.0; // Yen variable

  void _clearAll() {
    realController.text = '';
    dollarController.text = '';
    euroController.text = '';
    britishController.text = '';
    yenController.text = ''; // Yen
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    var real = double.parse(text);
    dollarController.text = (real / dollar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
    britishController.text = (real / british).toStringAsFixed(2);
    yenController.text = (real / yen).toStringAsFixed(0); // Yen calculation
  }

  void _dollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    var dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
    britishController.text = (dollar * this.dollar / british).toStringAsFixed(2);
    yenController.text = (dollar * this.dollar / yen).toStringAsFixed(0); // Yen calculation
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    var euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
    britishController.text = (euro * this.euro / british).toStringAsFixed(2);
    yenController.text = (euro * this.euro / yen).toStringAsFixed(0); // Yen calculation
  }

  void _britishChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    var british = double.parse(text);
    realController.text = (british * this.british).toStringAsFixed(2);
    dollarController.text = (british * this.british / dollar).toStringAsFixed(2);
    euroController.text = (british * this.british / euro).toStringAsFixed(2);
    yenController.text = (british * this.british / yen).toStringAsFixed(0); // Yen calculation
  }

  void _yenChanged(String text) { // Yen changed method
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    var yen = double.parse(text);
    realController.text = (yen * this.yen).toStringAsFixed(2);
    dollarController.text = (yen * this.yen / dollar).toStringAsFixed(2);
    euroController.text = (yen * this.yen / euro).toStringAsFixed(2);
    britishController.text = (yen * this.yen / british).toStringAsFixed(2);
  }

  static const lightBlue = Color(0xFF87CEEB);
  static const _goldenColor = Color(0xFFFFD700);
  static const _lightColor = Color(0xFFFfcfaf1);

  final kLabelStyle = TextStyle(
      color: _goldenColor, fontWeight: FontWeight.bold, fontSize: 22);

  Widget buildTextField(String label, String prefix, TextEditingController controller, Function(String) onChanged) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: label,
        labelStyle: kLabelStyle,
        prefixText: prefix,
      ),
      style: kLabelStyle,
      onChanged: onChanged,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightColor,
      appBar: AppBar(
        title: Text('Currency Converter', style: TextStyle(color: _lightColor, fontSize: 24)),
        backgroundColor: lightBlue,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh, color: _lightColor, size: 24),
            onPressed: _clearAll,
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Text('Loading API Data...', style: kLabelStyle));
            default:
              if (snapshot.hasError) {
                return Center(
                    child: Text('Error Loading Data...', style: kLabelStyle));
              } else if (snapshot.hasData) {
                Map<String, dynamic>? data = snapshot.data;
                if (data != null) {
                  dollar = data['results']['currencies']['USD']['buy'];
                  euro = data['results']['currencies']['EUR']['buy'];
                  british = data['results']['currencies']['GBP']['buy'];
                  yen = data['results']['currencies']['JPY']['buy']; // Yen data assignment
                }
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.adb, size: 120.0, color: _goldenColor),
                        Divider(color: lightBlue, thickness: 2.5, indent: 60, endIndent: 60),
                        buildTextField('Real', 'R\$ ', realController, _realChanged),
                        Divider(),
                        buildTextField('Dollar', '\$ ', dollarController, _dollarChanged),
                        Divider(),
                        buildTextField('Euro', '€ ', euroController, _euroChanged),
                        Divider(),
                        buildTextField('Pound Sterling', '£ ', britishController, _britishChanged),
                        Divider(),
                        buildTextField('Japanese Yen', '¥ ', yenController, _yenChanged), // Yen text field
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('No data available...', style: kLabelStyle));
              }
          }
        },
      ),
    );
  }
}
