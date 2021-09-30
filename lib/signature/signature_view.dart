import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureView extends StatefulWidget {
  const SignatureView({Key? key}) : super(key: key);

  @override
  _SignatureViewState createState() => _SignatureViewState();
}

class _SignatureViewState extends State<SignatureView> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  void onClearSign() {
    _controller.clear();
  }

  void onDoneSign() async {
    if (_controller.isNotEmpty) {
      final Uint8List? data = await _controller.toPngBytes();
      print(data);
      if (data != null) {
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Container(
                    color: Colors.grey[300],
                    child: Image.memory(data,
                        width: 100, height: 100, fit: BoxFit.contain),
                  ),
                ),
              );
            },
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signature')),
      body: Column(
        children: [
          Row(),
          const SizedBox(height: 50),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
            ),
            child: Signature(
              width: 300,
              height: 300,
              controller: _controller,
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
