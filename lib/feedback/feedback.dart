import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

final nameController = TextEditingController();
final subjectController = TextEditingController();
final emailController = TextEditingController();
final messageController = TextEditingController();

Future sendEmail() async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_gyk50jn";
  const templateId = "template_8wava2t";
  const userId = "L8PRz_eoaNJ55ZXDv";

  final response = await http.post(url,
      headers: {'Content_Type': 'application/json'},
      body: json.encode({
        "service_id": serviceId,
        "template_id": templateId,
        "user_id": userId,
        "template_params": {
          "name": nameController.text,
          "subject": subjectController.text,
          "message": messageController.text,
          "user_email": emailController.text
        }
      }));
  return response.statusCode;
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.account_circle),
                          hintText: "Name",
                          labelText: "Name"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: subjectController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.subject_rounded),
                          hintText: "Subject",
                          labelText: "Subject"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.email_rounded),
                          hintText: "Email",
                          labelText: "Email"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: messageController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.message_rounded),
                          hintText: "Feedback",
                          labelText: "Feedback"),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          sendEmail();
                          final snackBar = SnackBar(
                            backgroundColor: Color.fromARGB(221, 128, 125, 125),
                            content: Container(
                              
                              child: const Text('Message Send Succssfully!',style: TextStyle(color: Colors.white),)),
                            
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text(
                          "SEND",
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
