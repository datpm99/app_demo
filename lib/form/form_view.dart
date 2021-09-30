import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final formStateKey = GlobalKey<FormState>();
  User user = User('', 0);

  String? validateName(String? name) {
    if (name!.isEmpty) return 'Tên không được trống';
    return null;
  }

  String? validateAge(String? age) {
    try {
      if (int.tryParse(age!)! < 18) {
        return 'Tuổi phải lớn hơn 18';
      }
      return null;
    } catch (e) {
      return 'Vui lòng nhập số';
    }
  }

  void saveName(String? name) {
    user.name = name!;
  }

  void saveAge(String? age) {
    user.age = int.parse(age!);
  }

  void submit() {
    //khi form gọi hàm validate => tất cả TextFormField sẽ gọi hàm validate.
    if (formStateKey.currentState!.validate()) {
      //Khi form gọi hàm save thì tất cả các TextFormField sẽ gọi hàm save.
      formStateKey.currentState!.save();
      debugPrint('save success!');
    } else {
      debugPrint('validate fail!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form GlobalKey')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Form(
              key: formStateKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Vui lòng nhập tên',
                      labelText: 'Tên',
                    ),
                    validator: validateName,
                    onSaved: saveName,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Vui lòng nhập tuổi',
                      labelText: 'Tuổi',
                    ),
                    validator: validateAge,
                    onSaved: saveAge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  int age;

  User(this.name, this.age);
}
