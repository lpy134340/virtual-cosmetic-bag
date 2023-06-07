// import 'dart:html';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';

// constants & helper wigets
const serviceId = "service_d8o5awc";
const publicKey = "haJy978dpN0KmV5QH";
const privateKey = "fGZX2yy_XTbPpMnRYuf2y";
const templateId = "template_dmm1dya";
const requriedHint = "*Required";
const emailHint = "Please enter a valid Email";
const Color formColor = Color.fromARGB(255, 229, 212, 239);
const SizedBox sizedBox = SizedBox(height: 15);
const SnackBar succeedSnackbar =
    SnackBar(content: Text('Message Sent!'), backgroundColor: Colors.green);
const failedSnackbar =
    SnackBar(content: Text('Failed, try again!'), backgroundColor: Colors.red);

// helper vlidator
class Validator {
  static String? nonNullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return requriedHint;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return requriedHint;
    } else if (!EmailValidator.validate(value)) {
      return emailHint;
    }
    return null;
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  void clearForm() {
    _name.clear();
    _email.clear();
    _message.clear();
  }

  Future<EmailJSResponseStatus> submitToUs() {
    var templateParams = <String, dynamic>{
      'from_name': _name.value.text,
      'from_email': _email.value.text,
      'message': _message.value.text
    };
    var response = EmailJS.send(
        serviceId,
        templateId,
        templateParams,
        const Options(
          publicKey: publicKey,
          privateKey: privateKey,
        ));
    return response;
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Contact Us",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "We will get back to you soon.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              sizedBox,
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: formColor,
                  hintText: "Name",
                  border: InputBorder.none,
                ),
                validator: (value) {
                  return Validator.nonNullValidator(value);
                },
              ),
              sizedBox,
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: formColor,
                  hintText: "Email",
                  border: InputBorder.none,
                ),
                validator: (value) => Validator.emailValidator(value),
              ),
              sizedBox,
              TextFormField(
                controller: _message,
                maxLines: 8,
                maxLength: 400,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: formColor,
                  hintText: "Message",
                  border: InputBorder.none,
                ),
                validator: (value) => Validator.nonNullValidator(value),
              ),
              sizedBox,
              MaterialButton(
                height: 40.0,
                color: Colors.green,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      submitToUs();
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(succeedSnackbar);
                    } catch (error) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(failedSnackbar);
                    }
                  }
                  clearForm();
                  setState(() {});
                },
                child: const Text("Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
              sizedBox,
            ],
          ),
        ),
      );
}
