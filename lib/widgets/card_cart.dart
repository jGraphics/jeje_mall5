import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class ListTileExample extends StatelessWidget {
  const ListTileExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('list tile samples reusable'),
      ),
      body: ListView(
        children: const <Widget>[
          Card(
            child: ListTile(
              leading: FlutterLogo(size: 72.0),
              title: Text('Three-line ListTile'),
              subtitle:
                  Text('A sufficiently long subtitle warrants three lines.'),
              trailing: Icon(IconsaxPlusBold.trash),
              isThreeLine: true,
            ),
          )
        ],
      ),
    );
  }
}
