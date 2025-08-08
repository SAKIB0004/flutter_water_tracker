import 'package:flutter/material.dart';


class AddWaterButton extends StatelessWidget {
  final int? value;
  final IconData? icon;
  final VoidCallback? onClicked;



  const AddWaterButton({
    super.key, this.icon, this.onClicked, this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(

          onPressed: onClicked,
          label: Text("Add $value ml",
            style: TextStyle(fontSize: 16),
          ),
          icon: Icon( icon ?? Icons.water_drop, color: Colors.blue.shade300),
        ),
      ),
    );
  }
}