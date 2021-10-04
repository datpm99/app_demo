import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';

class DeepLinkView extends StatefulWidget {
  const DeepLinkView({Key? key}) : super(key: key);

  @override
  _DeepLinkViewState createState() => _DeepLinkViewState();
}

class _DeepLinkViewState extends State<DeepLinkView> {
  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
    } on PlatformException {
      debugPrint('fail to get initial uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DeepLink')),
      body: Column(
        children: [],
      ),
    );
  }
}
