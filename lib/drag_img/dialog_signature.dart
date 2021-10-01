import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DialogSignature extends StatefulWidget {
  const DialogSignature({Key? key}) : super(key: key);

  @override
  _DialogSignatureState createState() => _DialogSignatureState();
}

class _DialogSignatureState extends State<DialogSignature> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  bool isSign = false;
  bool isSignImg = false;
  ByteData? bytes;
  late File file;
  bool isPick = false;

  void onDoneSign() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    isSignImg = true;
    setState(() {});
  }

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      isPick = true;
      setState(() {});
    } else {
      isPick = false;
      debugPrint('Picker Image Fail!');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              const Text(
                'Thông tin chữ ký',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.clear, color: Colors.grey),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          SizedBox(
            width: width,
            height: 200,
            child: (!isSignImg)
                ? const SizedBox.shrink()
                : Image.memory(bytes!.buffer.asUint8List()),
          ),
          const Divider(height: 1),
          Row(
            children: [
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  pickImage();
                },
                child: const Text('Chọn File'),
              ),
              const SizedBox(width: 20),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    isSign = true;
                  });
                },
                child: const Text('Ký điện tử'),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: const Color(0xFFD6D6D6)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: (isPick)
                ? Image.file(file)
                : Visibility(
                    visible: isSign,
                    child: SfSignaturePad(
                      key: signatureGlobalKey,
                      minimumStrokeWidth: 1,
                      maximumStrokeWidth: 3,
                      strokeColor: Colors.black,
                      backgroundColor: Colors.white,
                    ),
                  ),
          ),
          Visibility(
            visible: isSign,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    signatureGlobalKey.currentState!.clear();
                  },
                  child: const Text('Xóa'),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFD6D6D6)),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: onDoneSign,
                  child: const Text('OK'),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (isPick) {
                      Navigator.pop(context, file);
                    } else {
                      Navigator.pop(context, bytes);
                    }
                  },
                  child: const Text('Đồng ý'),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}
