import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SeconsPicker extends StatefulWidget {
  final String? labelText;
  final ValueChanged<int>? onChanged;
  final EdgeInsetsGeometry? padding;
  final int? initialValue;
  final double? width;
  final double? height;
  const SeconsPicker(
      {super.key,
      this.labelText,
      this.onChanged,
      this.padding,
      this.initialValue,
      this.width,
      this.height});

  @override
  State<SeconsPicker> createState() => _SeconsPickerState();
}

class _SeconsPickerState extends State<SeconsPicker> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.initialValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? 120,
      height: widget.height ?? 50,
      child: Center(
        child: Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: TextField(
            controller: _controller,
            onChanged: (val) {
              if (val.isEmpty) {
                widget.onChanged!(60);
                return;
              }
              ;
              int parseInt = int.parse(val);
              if (widget.onChanged == null) return;
              widget.onChanged!(parseInt);
            },

            keyboardType:
                TextInputType.number, // Configura el teclado para números.
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly, // Permite solo dígitos.
            ],
            decoration: InputDecoration(
              labelText: widget.labelText ?? '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              suffix: Text('s'),
            ),
          ),
        ),
      ),
    );
  }
}
