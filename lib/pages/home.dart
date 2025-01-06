import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the layout is more tall than wide
        final isMoreTallThanWide = constraints.maxHeight > constraints.maxWidth;

        if (isMoreTallThanWide) {
          // If the layout is more tall than wide, use a Column
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(
                "Welcome",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
              const SizedBox(height: 20),
              //animation
              // ImageAnimation(
              //   weather: _weather,
              // ),
              const SizedBox(height: 20),
              //temperature
              Text(
                "dummy text",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
              const SizedBox(height: 20),
              //weather condition
              Text(
                "dummy text",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
            ],
          );
        } else {
          // If the layout is more wide than tall, use a Row
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(
                "loading city..",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
              const SizedBox(width: 20),
              //animation
              // ImageAnimation(
              //   weather: _weather,
              // ),
              const SizedBox(width: 20),
              //temperature
              Text(
                "the data is waiting",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
              const SizedBox(width: 20),
              //weather condition
              Text(
                "here too",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
