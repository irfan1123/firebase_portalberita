import 'package:flutter/material.dart';
import '../services/database_service.dart';

class UploadNewsScreen extends StatefulWidget {
  const UploadNewsScreen({super.key});

  @override
  State<UploadNewsScreen> createState() => _UploadNewsScreenState();
}

class _UploadNewsScreenState extends State<UploadNewsScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String content = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Berita'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Judul Berita',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val!.isEmpty ? 'Masukkan judul' : null,
                onChanged: (val) => setState(() => title = val),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Isi Berita',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (val) => val!.isEmpty ? 'Masukkan isi berita' : null,
                onChanged: (val) => setState(() => content = val),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('Upload'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      await DatabaseService().addNews(title, content);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
