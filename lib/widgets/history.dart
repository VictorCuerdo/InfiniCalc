import 'package:flutter/material.dart';
import 'package:infinicalc/controllers/navigation_utils.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
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
              'This is the History Page',
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
