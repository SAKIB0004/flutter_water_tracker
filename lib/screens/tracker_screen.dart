import 'package:flutter/material.dart';

import '../widgets/add_water_button.dart';

class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  int currentWaterIntake = 0;
  final int goal = 5000;

  void addWater(int value) {
    currentWaterIntake = (currentWaterIntake + value).clamp(0, goal);

    final bool reachedGoal = currentWaterIntake >= goal;
    final String message = reachedGoal
        ? 'You have reached your daily goal!'
        : 'Added $value ml of water.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: reachedGoal ? 2 : 1),
      ),
    );
    setState(() {});
  }

  void resetTracker() {
    currentWaterIntake = 0;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Tracker reset to 0 ml."),
        duration: Duration(seconds: 1),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentWaterIntake / goal).clamp(0, 1);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Water Tracker',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade300,
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Today\'s InTank',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue.shade800,
                    ),
                  ),

                  Text(
                    '$currentWaterIntake ml',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    // This should be replaced with the actual progress value
                    strokeWidth: 8,
                    backgroundColor: Colors.blue.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade600,
                    ),
                  ),
                ),

                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            SizedBox(height: 20),

            Wrap(
              //spacing:20, //horizontal spacing between buttons
              //runSpacing: 20, //vertical spacing between buttons
              alignment: WrapAlignment.center,
              children: [
                AddWaterButton(
                  value: 100,
                  icon: Icons.local_drink,
                  onClicked: () => addWater(100),
                ),
                AddWaterButton(
                  value: 200,
                  icon: Icons.local_drink,
                  onClicked: () => addWater(200),
                ),
                AddWaterButton(value: 300, onClicked: () => addWater(300)),

                AddWaterButton(value: 500, onClicked: () => addWater(500)),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => resetTracker(),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                foregroundColor: Colors.black,
                backgroundColor: Colors.red.shade600,
              ),
              child: Text("Reset Tracker", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
