import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text("M  A  M U R A D"),
      const SizedBox(
        height: 20,
      ),
      //life time box
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade100,
              ),
              height: 200,
              width: 200,
              child: Column(children: [
                Text(
                  "Lifetime Use ",
                  style: GoogleFonts.lato(),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.red.shade100,
              ),
              height: 200,
              width: 200,
              child: Column(
                children: const [
                  Text(
                    "All Time lost ",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 40,
      ),
      ElevatedButton(
        onPressed: () {},
        child: const Text("Donate ! :) "),
      ),
    ]);
  }
}
