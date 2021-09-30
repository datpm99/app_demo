import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class SignatureViewTwo extends StatefulWidget {
  const SignatureViewTwo({Key? key}) : super(key: key);

  @override
  _SignatureViewTwoState createState() => _SignatureViewTwoState();
}

class _SignatureViewTwoState extends State<SignatureViewTwo> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void onClearSign() {
    signatureGlobalKey.currentState!.clear();
  }

  void onDoneSign() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Signature Two')),
            body: Center(
              child: Container(
                width: 300,
                height: 300,
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signature Two')),
      body: Column(
        children: [
          Row(),
          const SizedBox(height: 50),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: SfSignaturePad(
              key: signatureGlobalKey,
              minimumStrokeWidth: 1,
              maximumStrokeWidth: 3,
              strokeColor: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
          ElevatedButton(
            onPressed: onDoneSign,
            child: const Text('Done'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onClearSign,
        label: const Text('Reset'),
      ),
    );
  }
}
