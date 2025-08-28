import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = 'jana';
    final email = 'jana@gmail.com';

    return Scaffold(
      appBar: AppBar(
         backgroundColor: ColorsStyle.thrtineeColor,
        title: Text('👤 Profile',style: TextStyle(color: ColorsStyle.primaryColor),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
             CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(''), 
              backgroundColor: ColorsStyle.thrtineeColor,// صورة مؤقتة
            ),
           SizedBox(height: 10),
            Text(userName, style:  TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: ColorsStyle.secondColor)),
            Text(email, style:  TextStyle(color: ColorsStyle.secondColor)),

            SizedBox(height: 20),
            ElevatedButton.icon(
              
              
              onPressed: () {
                // edit profile action
              },
              
              icon: Icon(Icons.edit,color: ColorsStyle.primaryColor,),
              label: Text('Edit Profile',style: TextStyle(color: ColorsStyle.primaryColor),),
              style: ElevatedButton.styleFrom(backgroundColor: ColorsStyle.thrtineeColor),
            ),

           SizedBox(height: 30),

            ListTile(
              leading: Icon(Icons.flight_takeoff),
              title:Text('Booked Trips',style:  TextStyle(color: ColorsStyle.sevenColor)),
              trailing: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title:Text('Favourites',style:  TextStyle(color: ColorsStyle.sevenColor)),
              trailing: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title:  Text('Countries Visited',style:  TextStyle(color: ColorsStyle.sevenColor)),
              trailing:  Text(''),
            ),

            Spacer(),

            ElevatedButton.icon(
              onPressed: () {
                // logout logic
              },
              icon:Icon(Icons.logout),
              label: Text('Log Out',style: TextStyle(color: ColorsStyle.primaryColor),),
              style: ElevatedButton.styleFrom(backgroundColor: ColorsStyle.thrtineeColor),
            ),
          ],
        ),
      ),
    );
  }
}
