import 'package:flutter/material.dart';

class NumberPicker extends StatefulWidget {
  final int? min, max, initialNumber, interval;
  final ValueChanged<int>? onChanged;
  final String? title;
  final TextStyle? titleStyle;
  const NumberPicker(
      {super.key,
      this.min,      
      this.max,
      this.interval,
      this.initialNumber,
      this.onChanged,
      this.title,
      this.titleStyle});

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  int selectedNumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    selectedNumber = widget.initialNumber ?? 0;
    super.initState();
  }

  void _incrementNumber() {
    if (selectedNumber == widget.max) return;

    setState(() {
      if(widget.interval!=null){
        selectedNumber = selectedNumber + widget.interval!;
      }else{
      selectedNumber++;
      }
    });
    if (widget.onChanged == null) return;
    widget.onChanged!(selectedNumber);
  }

  void _decrementNumber() {
    if (selectedNumber == widget.min) return;
    setState(() {
      if(widget.interval!=null){
        selectedNumber = selectedNumber - widget.interval!;
      }else{
      selectedNumber--;
      }
    });
    if (widget.onChanged == null) return;
    widget.onChanged!(selectedNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.title!=null ? Text(
            widget.title!,
            style: widget.titleStyle ??
                const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ) : const SizedBox(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: _decrementNumber,
                  child: const Icon(Icons.remove),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 75,
                  child: Center(
                    child: Text(
                      selectedNumber.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: _incrementNumber,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
