import 'package:flutter/material.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.navigateTo('/');
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              'This is the Help Page',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
