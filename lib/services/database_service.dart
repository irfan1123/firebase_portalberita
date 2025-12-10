import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection references
  final CollectionReference newsCollection =
      FirebaseFirestore.instance.collection('news');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // --- USER DATA ---
  Future updateUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  // Get user doc stream
  Stream<DocumentSnapshot> get userData {
    return userCollection.doc(uid).snapshots();
  }

  // --- NEWS DATA ---
  // Add news
  Future<void> addNews(String title, String content) async {
    await newsCollection.add({
      'title': title,
      'content': content,
      'date': DateTime.now().toString().substring(0, 10), // Simple YYYY-MM-DD
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Get news stream
  Stream<List<News>> get news {
    return newsCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(_newsListFromSnapshot);
  }

  List<News> _newsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return News(
        title: data['title'] ?? '',
        content: data['content'] ?? '',
        date: data['date'] ?? '',
      );
    }).toList();
  }
}

class News {
  final String title;
  final String content;
  final String date;

  News({required this.title, required this.content, required this.date});
}
