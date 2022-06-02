import 'dart:ffi';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final ImagePicker _picker = ImagePicker();
  File imageFile;
  String _genderValue = '';
  DateTime _selectedDate = DateTime.now();
  Map<int, bool> answer = {};
  List<String> hobby = ['Cricket', 'Study', 'Football', 'Singing'];

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _name = TextEditingController();

  Future _fileImage() async {
    final XFile image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  Future _selectDate(BuildContext context) async {
    final DateTime seletedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));

    if (seletedDate != null) {
      _selectedDate = seletedDate;
      _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: ListView(
          children: [
            pickImage(),
            const SizedBox(
              height: 20,
            ),
            InputBox(
              controller: _name,
              hintText: 'Enter Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
             InputBox(
              hintText: 'Enter Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
             InputBox(
              hintText: 'Enter Phone',
              keyboardType: TextInputType.number,
               validator: (value) {
                 if (value == null || value.isEmpty) {
                   return 'Enter Phone';
                 }
                 return null;
               },
            ),
            const SizedBox(
              height: 20,
            ),
            radioButton(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _dateController,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: 'Select Date',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            boxCheck(),
            const SizedBox(
              height: 20,
            ),
            Button(
              callback: () {
                if (_formKey.currentState.validate()) {}
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget pickImage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Stack(children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: imageFile == null
                ? const AssetImage('assets/images/download.jpeg')
                : FileImage(imageFile),
          ),
          Positioned(
              bottom: 15,
              right: 15,
              child: GestureDetector(
                onTap: () => _fileImage(),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.blue,
                  size: 28,
                ),
              )),
        ]),
      ),
    );
  }

  Widget radioButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black)),
        child: Row(
          children: [
            Radio(
                value: 'Male',
                groupValue: _genderValue,
                onChanged: (val) {
                  _genderValue = val;
                  setState(() {});
                }),
            const Text('Male'),
            Radio(
                value: 'Female',
                groupValue: _genderValue,
                onChanged: (val) {
                  _genderValue = val;
                  setState(() {});
                }),
            const Text('FeMale'),
          ],
        ),
      ),
    );
  }

  Widget boxCheck() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: hobby.length,
              itemBuilder: (context, index) {
                final item = hobby[index];
                return CheckboxListTile(
                    title: Text(item),
                    value: answer[index] ?? false,
                    onChanged: (bool value) {
                      answer[index] = value;
                      setState(() {});
                    });
              }),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback callback;

  const Button({Key key, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
          height: 50,
          width: double.infinity,
          child: TextButton(
              onPressed: callback,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
              child: const Text(
                'Sign In',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ))),
    );
  }
}

class InputBox extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  const InputBox({Key key, this.hintText, this.keyboardType, this.validator,this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }
}
