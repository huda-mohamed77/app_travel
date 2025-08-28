import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsStyle.thrtineeColor,
        title: Text('👤 Profile', style: TextStyle(color: ColorsStyle.primaryColor)),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthSuccess) {
            final user = state.user;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(''),
                    backgroundColor: ColorsStyle.thrtineeColor,
                  ),
                  const SizedBox(height: 10),
                  Text(user.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorsStyle.secondColor)),
                  Text(user.email, style: TextStyle(color: ColorsStyle.secondColor)),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showEditDialog(context, user.name, user.email);
                    },
                    icon: Icon(Icons.edit, color: ColorsStyle.primaryColor),
                    label: Text('Edit Profile', style: TextStyle(color: ColorsStyle.primaryColor)),
                    style: ElevatedButton.styleFrom(backgroundColor: ColorsStyle.thrtineeColor),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    icon: const Icon(Icons.logout),
                    label: Text('Log Out', style: TextStyle(color: ColorsStyle.primaryColor)),
                    style: ElevatedButton.styleFrom(backgroundColor: ColorsStyle.thrtineeColor),
                  ),
                ],
              ),
            );
          } else if (state is AuthFailure) {
            return Center(child: Text("❌ ${state.message}"));
          } else {
            return const Center(child: Text("No user data"));
          }
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, String currentName, String currentEmail) {
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController emailController = TextEditingController(text: currentEmail);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthCubit>().updateProfile(
                    name: nameController.text,
                    email: emailController.text,
                  );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}


