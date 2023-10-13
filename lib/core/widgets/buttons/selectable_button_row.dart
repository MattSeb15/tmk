import 'package:flutter/material.dart';

class BOptions {
  final String text;
  final int value;

  BOptions({required this.text, required this.value});
}

class SelectableButtonRow extends StatefulWidget {
  final List<BOptions> options;
  final int? initialSelectedIndex;
  final ValueChanged<int>? onChanged;
  final String? title;

  const SelectableButtonRow(
      {super.key,
      required this.options,
      this.initialSelectedIndex,
      this.onChanged, this.title});

  @override
  State<SelectableButtonRow> createState() => _SelectableButtonRowState();
}

class _SelectableButtonRowState extends State<SelectableButtonRow> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialSelectedIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title?? '',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: widget.options
              .asMap()
              .map((index, option) => MapEntry(
                  index,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        if (widget.onChanged == null) return;
                        widget.onChanged!(option.value);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedIndex == index
                            ? Colors.indigo
                            : Colors.grey[300],
                      ),
                      child: Text(
                        option.text,
                        style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Theme.of(context)
                                    .buttonTheme
                                    .colorScheme
                                    ?.primary),
                      ),
                    ),
                  )))
              .values
              .toList(),
        ),
        
      ],
    );
  }
}
