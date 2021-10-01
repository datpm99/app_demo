import 'package:app_demo/drag_img/drag_img_view.dart';
import 'package:app_demo/form/form_view.dart';
import 'package:app_demo/signature/signature_view.dart';
import 'package:app_demo/signature/signature_view_two.dart';
import 'package:flutter/material.dart';

import 'drag_img/drag_img_view_two.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Links link;

  @override
  void initState() {
    super.initState();
    link = Links(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Demo')),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          BtnLink(name: 'Drag Image', onTap: link.onDragImage),
          BtnLink(name: 'Signature', onTap: link.onSignature),
          BtnLink(name: 'Signature Two', onTap: link.onSignatureTwo),
          // BtnLink(name: 'Form', onTap: link.onFormView),
          BtnLink(name: 'Drag Image Two', onTap: link.onDragImgTwo),
        ],
      ),
    );
  }
}

class BtnLink extends StatelessWidget {
  const BtnLink({Key? key, required this.name, required this.onTap})
      : super(key: key);
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(name),
      ),
    );
  }
}

class Links {
  final BuildContext context;

  Links(this.context);

  static Future navigatePage(BuildContext context, Widget widget) async {
    return await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  void onDragImage() {
    navigatePage(context, const DragImageView());
  }

  void onSignature() {
    navigatePage(context, const SignatureView());
  }

  void onSignatureTwo() {
    navigatePage(context, const SignatureViewTwo());
  }

  void onFormView() {
    navigatePage(context, const FormView());
  }

  void onDragImgTwo() {
    navigatePage(context, const DragImgViewTwo());
  }
}
