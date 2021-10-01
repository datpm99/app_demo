import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dialog_signature.dart';

class DragImgViewTwo extends StatefulWidget {
  const DragImgViewTwo({Key? key}) : super(key: key);

  @override
  _DragImgViewTwoState createState() => _DragImgViewTwoState();
}

class _DragImgViewTwoState extends State<DragImgViewTwo> {
  ByteData? bytes;
  late File file;
  bool byteNull = true;
  bool fileNull = true;
  Offset position = const Offset(100, 100);
  double height = AppBar().preferredSize.height;

  void updatePosition(Offset newPos) {
    double height2 = MediaQuery.of(context).padding.top;
    position = Offset(newPos.dx, newPos.dy - height - height2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Drag Image')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                WidgetA(),
                Text('Đại Diện Bên B'),
              ],
            ),
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Draggable(
                maxSimultaneousDrags: 1,
                onDragEnd: (details) => updatePosition(details.offset),
                childWhenDragging: Opacity(opacity: .3, child: itemSign()),
                feedback: itemSign(),
                child: itemSign(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onShowDialog() async {
    var byteTerm = await showDialog(
      context: context,
      builder: (context) => const DialogSignature(),
      barrierDismissible: false,
    );
    if (byteTerm.runtimeType.toString() == '_File') {
      file = byteTerm;
      if (file.path.isEmpty) fileNull = true;
      if (file.path.isNotEmpty) fileNull = false;
      byteNull = true;
    } else if (byteTerm.runtimeType.toString() == '_ByteDataView') {
      bytes = byteTerm;
      if (bytes == null) byteNull = true;
      if (bytes != null) byteNull = false;
      fileNull = true;
    } else {}
    setState(() {});
  }

  Widget itemSign() {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: (byteNull)
          ? (fileNull)
              ? const SizedBox.shrink()
              : Image.file(file)
          : Image.memory(bytes!.buffer.asUint8List()),
    );
  }
}

class WidgetA extends StatelessWidget {
  const WidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Đại Diện Bên A'),
        SizedBox(height: 10),
        SizedBox(height: 80, width: 150),
      ],
    );
  }
}
