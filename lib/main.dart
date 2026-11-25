
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

// MAIN SCREEN

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EEFF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.casino,
                size: 100,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 25),
              const Text(
                'Number Guessing Game',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Test Your Luck!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                  child: const Text('Play Game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GAME SCREEN

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final TextEditingController controller =
      TextEditingController();

  int randomNumber = Random().nextInt(100) + 1;
  int attempts = 0;
  String message = 'Guess a number between 1 and 100';
  bool gameWon = false;

  void checkGuess() {
    int? guess = int.tryParse(controller.text);

    if (guess == null || guess < 1 || guess > 100) {
      setState(() {
        message = 'Please enter a number from 1 to 100';
      });
      return;
    }

    setState(() {
      attempts++;

      if (guess < randomNumber) {
        message = 'Too Low! Try Again';
      } else if (guess > randomNumber) {
        message = 'Too High! Try Again';
      } else {
        message = 'Congratulations! You Won!';
        gameWon = true;
      }

      controller.clear();
    });
  }

  void restartGame() {
    setState(() {
      randomNumber = Random().nextInt(100) + 1;
      attempts = 0;
      message = 'Guess a number between 1 and 100';
      gameWon = false;
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2EEFF),
      appBar: AppBar(
        title: const Text('Guess The Number'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb,
              size: 80,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 20),

            const Text(
              'Enter Your Guess',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter number (1-100)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: gameWon ? null : checkGuess,
                child: const Text('Submit Guess'),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Total Attempts: $attempts',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            if (gameWon)
              ElevatedButton(
                onPressed: restartGame,
                child: const Text('Play Again'),
              ),
          ],
        ),
      ),
    );
  }
}
