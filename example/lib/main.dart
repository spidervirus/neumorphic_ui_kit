import 'package:flutter/material.dart';
import 'package:neumorphic_ui_kit/neumorphic_ui_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neumorphic UI Kit Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _switchValue = false;
  double _sliderValue = 0.5;
  double _progressValue = 0.7;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Neumorphic UI Kit Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Container
            const NeumorphicContainer(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Neumorphic Container',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Button
            NeumorphicButton(
              onPressed: () {},
              child: const Text('Neumorphic Button'),
            ),
            const SizedBox(height: 24),

            // Text Field
            NeumorphicTextField(
              controller: _textController,
              hintText: 'Neumorphic Text Field',
            ),
            const SizedBox(height: 24),

            // Switch
            Row(
              children: [
                const Text('Neumorphic Switch:'),
                const SizedBox(width: 16),
                NeumorphicSwitch(
                  value: _switchValue,
                  onChanged: (value) => setState(() => _switchValue = value),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Slider
            const Text('Neumorphic Slider:'),
            const SizedBox(height: 8),
            NeumorphicSlider(
              value: _sliderValue,
              onChanged: (value) => setState(() => _sliderValue = value),
            ),
            const SizedBox(height: 24),

            // Progress Bar
            const Text('Neumorphic Progress Bar:'),
            const SizedBox(height: 8),
            NeumorphicProgressBar(
              progress: _progressValue,
            ),
            const SizedBox(height: 24),

            // Card
            NeumorphicCard(
              onTap: () {},
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Neumorphic Card',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'This is a tappable card with neumorphic styling. It can contain any widget as its child.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Interactive Demo Section
            NeumorphicContainer(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Interactive Demo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: NeumorphicSlider(
                            value: _progressValue,
                            onChanged: (value) =>
                                setState(() => _progressValue = value),
                          ),
                        ),
                        const SizedBox(width: 16),
                        NeumorphicButton(
                          onPressed: () => setState(() => _progressValue = 0.0),
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    NeumorphicProgressBar(
                      progress: _progressValue,
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
