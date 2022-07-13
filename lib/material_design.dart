import 'package:flutter/material.dart';

class MaterialDesingPage extends StatefulWidget {
  const MaterialDesingPage({Key? key}) : super(key: key);

  @override
  State<MaterialDesingPage> createState() => _MaterialDesingPageState();
}

class _MaterialDesingPageState extends State<MaterialDesingPage> {
  final List<Option> _options = [
    Option(text: 'Opsi pertama'),
    Option(text: 'Opsi kedua'),
    Option(text: 'Opsi ketiga'),
    Option(text: 'Opsi keempat'),
  ];

  late String _selectedOption = _options.first.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material Design'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: _options
                  .map(
                    (option) => Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: option.isChecked,
                            onChanged: (value) {
                              if (value != null) {
                                option.isChecked = value;
                                setState(() {});
                              }
                            },
                          ),
                          Expanded(child: Text(option.text))
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(8),
              value: _selectedOption,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              items: _options
                  .map((option) => option.text)
                  .map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  _selectedOption = value;
                  setState(() {});
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class Option {
  final String text;
  bool isChecked;

  Option({required this.text, this.isChecked = false});
}
