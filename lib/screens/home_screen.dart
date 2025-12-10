import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'upload_news_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // User can be null here (Guest mode)
    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Berita'),
        actions: [
          if (user != null) ...[
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ] else ...[
            TextButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              // Show welcome message only if logged in, otherwise generic
              child: user != null
                  ? StreamBuilder<DocumentSnapshot>(
                      stream: DatabaseService(uid: user.uid).userData,
                      builder: (context, snapshot) {
                        String userName = 'User';
                        if (snapshot.hasData && snapshot.data!.exists) {
                          Map<String, dynamic>? data =
                              snapshot.data!.data() as Map<String, dynamic>?;
                          userName = data?['name'] ?? 'User';
                        }
                        return Text('Welcome, $userName!',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold));
                      })
                  : const Text('Berita Terbaru',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<News>>(
              stream: DatabaseService().news,
              builder: (context, newsSnapshot) {
                if (newsSnapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (newsSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<News> newsList = newsSnapshot.data ?? [];
                if (newsList.isEmpty) {
                  return const Center(child: Text('Belum ada berita.'));
                }

                return ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: ListTile(
                        title: Text(newsList[index].title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(newsList[index].content),
                        trailing: Text(newsList[index].date),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (user == null) {
            // Redirect to Login if guest
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            // Go to Upload if logged in
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const UploadNewsScreen()),
            );
          }
        },
        child: const Icon(Icons.add),
        tooltip: 'Upload Berita',
      ),
    );
  }
}
