import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/database_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form values
  String? _currentName;
  String? _currentEmail;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null)
      return const Scaffold(body: Center(child: Text("Not logged in")));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic>? userData =
                snapshot.data!.data() as Map<String, dynamic>?;

            return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Update your profile settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData?['name'] ?? '',
                      decoration: const InputDecoration(hintText: 'Name'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData?['email'] ??
                          '', // Note: changing email here won't change Auth email unless we add that logic too.
                      decoration: const InputDecoration(
                          hintText: 'Email (Database Display Only)'),
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter an email' : null,
                      onChanged: (val) => setState(() => _currentEmail = val),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      child: const Text('Update'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData?['name'],
                            _currentEmail ?? userData?['email'],
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
