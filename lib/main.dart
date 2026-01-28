import 'package:flutter/material.dart';

void main() => runApp(LuminaApp());

class LuminaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.indigo),
      home: HomeScreen(),
    );
  }
}

// --- SCREEN 1: HOME ---
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black, Colors.indigo.shade900], begin: Alignment.topLeft),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(tag: 'logo', child: Icon(Icons.wb_sunny_rounded, size: 80, color: Colors.amber)),
              SizedBox(height: 20),
              Text("Welcome to Lumina", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                onPressed: () {
                  // Standard Push with a custom Fade Transition
                  Navigator.push(context, _createRoute(StatsScreen()));
                },
                child: Text("View Statistics"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SCREEN 2: STATS ---
class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stats"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _animatedCard("Daily Progress", "85%", Colors.greenAccent),
            _animatedCard("Sleep Quality", "7.5h", Colors.blueAccent),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Back")),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, _createRoute(ProfileScreen())),
                  child: Text("Go to Profile"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _animatedCard(String title, String val, Color color) {
    return Card(
      color: Colors.white10,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(title: Text(title), trailing: Text(val, style: TextStyle(color: color, fontWeight: FontWeight.bold))),
    );
  }
}

// --- SCREEN 3: PROFILE ---
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundColor: Colors.amber, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 20),
            Text("User Profile", style: TextStyle(fontSize: 22)),
            SizedBox(height: 30),
            // Double pop to go back to Home
            ElevatedButton(
              onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
              child: Text("Logout to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

// --- CUSTOM ANIMATION ROUTE ---
Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Slide from right
      const end = Offset.zero;
      const curve = Curves.easeInOutQuart;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}