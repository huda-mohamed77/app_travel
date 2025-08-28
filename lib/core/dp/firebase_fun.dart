import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/features/auth/models/user_model.dart';

class FirebaseFunctions {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ Sign Up
  Future<AppUser> signUp(String name, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = result.user!;

    AppUser appUser = AppUser(
      id: user.uid,
      name: name,
      email: email,
      favorites: [],
    );

    try {
      await _firestore.collection('users').doc(user.uid).set(appUser.toJson());
      print("✅ Data saved to Firestore for user ${user.uid}");
    } catch (e) {
      print("❌ Firestore error: $e");
    }

    return appUser;
  }

  // ✅ Login
  Future<AppUser> login(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User user = result.user!;

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(user.uid).get();

    return AppUser.fromJson(doc.data() as Map<String, dynamic>);
  }

  // ✅ Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  
  // Bookings
  final CollectionReference bookingsCollection = FirebaseFirestore.instance.collection('bookings');

  Future<void> bookTrip(Booking booking) async {
    await bookingsCollection.doc(booking.id).set(booking.toJson());
  }

  Future<List<Booking>> getBookings() async {
    final snapshot = await bookingsCollection.get();
    return snapshot.docs.map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> deleteBooking(String id) async {
    await bookingsCollection.doc(id).delete();
  }

=======

  // ✅ Get Current User
  Future<AppUser?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    DocumentSnapshot doc =
        await _firestore.collection('users').doc(user.uid).get();

    return AppUser.fromJson(doc.data() as Map<String, dynamic>);
  }

  // ✅ Add to Favorites
  Future<void> addToFavorites(Map<String, dynamic> placeData) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favourites')
        .add(placeData);

    print("✅ Place added to favourites");
  }

  // ✅ Remove from Favorites
  Future<void> removeFromFavorites(String docId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _firestore
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

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favourites')
        .get();

    return snapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data()})
        .toList();
  }

  // ✅ Update user profile (name/email)
  Future<void> updateProfile({String? name, String? email}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    Map<String, dynamic> updates = {};
    if (name != null) updates['name'] = name;
    if (email != null) updates['email'] = email;

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(user.uid).update(updates);
      print("📝 Profile updated");
    }
  }
 


Future<bool> isPlaceFavourite(String placeName) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return false;

  final snapshot = await _firestore
      .collection('users')
      .doc(user.uid)
      .collection('favourites')
      .where('name', isEqualTo: placeName)
      .get();

  return snapshot.docs.isNotEmpty;

}


 
}


