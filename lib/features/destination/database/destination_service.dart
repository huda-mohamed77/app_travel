import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';

class DestinationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _firestore = FirebaseFirestore.instance.collection(
    'places',
  );

  Future<void> addDestination(DestinationModel destination) async {
    await _firestore.add(destination.toJson());
  }

  Future<List<DestinationModel>> getDestinations() async {
    final snapshot = await _firestore.get();
    return snapshot.docs
        .map(
          (doc) => DestinationModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();
  }

  // Update
  Future<void> updateDestination(
    String id,
    DestinationModel destination,
  ) async {
    await _firestore.doc(id).update(destination.toJson());
  }

  // Delete
  Future<void> deleteDestination(String id) async {
    await _firestore.doc(id).delete();
  }

  Future<void> addToFavorites(Map<String, dynamic> placeData) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favourites')
    .doc(placeData['id']) 
    .set(placeData);

    print("✅ Place added to favourites");
  }

  // ✅ Remove from Favorites
  Future<void> removeFromFavorites(String docId) async {
    final user = _auth.currentUser;
    if (user == null) return;

  await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favourites')
    .doc(docId)
    .delete();


    print("🗑️ Place removed from favourites");
  }

  // ✅ Get User Favorites
  Future<List<Map<String, dynamic>>> getUserFavorites() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favourites')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'name': data['title'],
        'location': data['location'],
        'image': data['imageUrl'],
      };
    }).toList();
  }

  // ✅ Update user profile (name/email)
  Future<void> updateProfile({String? name, String? email}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    Map<String, dynamic> updates = {};
    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;

    if (updates.isNotEmpty) {
      await _firestore.doc(user.uid).update(updates);
      print("📝 Profile updated");
    }
  }

  Future<bool> isPlaceFavourite(String placeName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return false;
final snapshot = await FirebaseFirestore.instance
    .collection('users')
    .doc(user.uid)
    .collection('favourites')
    .where('title', isEqualTo: placeName)
    .get();


    return snapshot.docs.isNotEmpty;
  }
}
