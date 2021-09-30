import 'package:flutter/material.dart';

import 'drag_img_const.dart';

class DragImageView extends StatefulWidget {
  const DragImageView({Key? key}) : super(key: key);

  @override
  _DragImageViewState createState() => _DragImageViewState();
}

class _DragImageViewState extends State<DragImageView> {
  List lstImg1 = [];
  List lstImg2 = [];
  String imgDrop = '';

  @override
  void initState() {
    super.initState();
    lstImg1.addAll(DragImageConst.lstImg);
  }

  void onCompleteDrag() {
    setState(() {
      lstImg1.removeLast();
    });
  }

  void onReset(){
    setState(() {
      lstImg1.clear();
      lstImg1.addAll(DragImageConst.lstImg);
      imgDrop = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drag Image')),
      body: Column(
        children: [
          Row(),
          const SizedBox(height: 50),
          Stack(children: [
            Container(
              width: 150,
              height: 150,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text('No more image'),
            ),
            ...lstImg1.map((e) {
              return DragView(img: e, onComplete: onCompleteDrag);
            }).toList(),
          ]),
          const SizedBox(height: 200),
          DragTarget<String>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 150,
                height: 150,
                color: (candidateData.isEmpty)
                    ? Colors.lightBlue
                    : Colors.redAccent,
                alignment: Alignment.center,
                child: (imgDrop.isEmpty)
                    ? const Text('Drop Image')
                    : Image.network(imgDrop,
                        fit: BoxFit.cover, width: 150, height: 150),
              );
            },
            onWillAccept: (data) {
              return true;
            },
            onAccept: (data) {
              setState(() {
                imgDrop = data;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onReset,
        label: const Text('Reset'),
      ),
    );
  }
}

class DragView extends StatelessWidget {
  const DragView({Key? key, required this.img, required this.onComplete})
      : super(key: key);
  final String img;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      child: ContainerDrag(img: img),
      feedback: ContainerDrag(img: img),
      childWhenDragging: const SizedBox(width: 150, height: 150),
      data: img,
      onDragCompleted: () {
        onComplete();
      },
      onDraggableCanceled: (velocity, offset) {
        debugPrint('Fail');
      },
    );
  }
}

class ContainerDrag extends StatelessWidget {
  const ContainerDrag({Key? key, required this.img}) : super(key: key);
  final String img;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.network(img, fit: BoxFit.cover, width: 150, height: 150),
    );
  }
}
