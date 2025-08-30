import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/models/user_model.dart';
import 'package:travel_app/features/auth/login/login_screan.dart';
import 'package:travel_app/features/destination/database/destination_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<AppUser?> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        return AppUser.fromJson(doc.data()!);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsStyle.thrtineeColor,
        title: Text(
          '👤 Profile',
          style: TextStyle(color: ColorsStyle.primaryColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<AppUser?>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text(
                "No user data",
                style: TextStyle(color: ColorsStyle.thrtineeColor),
              ),
            );
          }

          final user = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: ColorsStyle.thrtineeColor,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 30,
                      color: ColorsStyle.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorsStyle.secondColor,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(color: ColorsStyle.secondColor),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    _showEditDialog(context, user.name, user.email);
                  },
                  icon: Icon(Icons.edit, color: ColorsStyle.primaryColor),
                  label: Text(
                    'Edit Profile',
                    style: TextStyle(color: ColorsStyle.primaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsStyle.thrtineeColor,
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut(); // تسجيل خروج حقيقي
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                    );
                  },
                  icon: Icon(Icons.logout),
                  label: Text(
                    'Log Out',
                    style: TextStyle(color: ColorsStyle.primaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsStyle.thrtineeColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    String currentName,
    String currentEmail,
  ) {
    final TextEditingController nameController = TextEditingController(
      text: currentName,
    );
    final TextEditingController emailController = TextEditingController(
      text: currentEmail,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Edit Profile',
          style: TextStyle(color: ColorsStyle.thrtineeColor),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: ColorsStyle.thrtineeColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read()<DestinationService>().updateProfile(
                name: nameController.text,
                email: emailController.text,
              );
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(color: ColorsStyle.thrtineeColor),
            ),
          ),
        ],
      ),
    );
  }
}

