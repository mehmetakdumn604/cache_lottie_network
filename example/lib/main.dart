import 'package:flutter/material.dart';
import 'package:cached_lottie_network/cached_lottie_network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cached Lottie Network Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cached Lottie Network Example'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example 1: Basic usage
            SizedBox(
              width: 200,
              height: 200,
              child: CachedLottieNetwork(
                lottieUrl:
                    'https://assets9.lottiefiles.com/packages/lf20_KEahK5k9Jj.json',
                cacheKey: 'animation_1',
              ),
            ),
            SizedBox(height: 20),
            // Example 2: Another animation with different cache key
            SizedBox(
              width: 200,
              height: 200,
              child: CachedLottieNetwork(
                lottieUrl:
                    'https://assets5.lottiefiles.com/packages/lf20_v7gj8hk2.json',
                cacheKey: 'animation_2',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
