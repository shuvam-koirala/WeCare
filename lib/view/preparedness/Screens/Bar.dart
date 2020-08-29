import 'package:WeCare/view/authentication/authservice.dart';
import 'package:WeCare/view/covidgraph/covidgraph.dart';
import 'package:WeCare/view/donation/plasma/plasmaDonationUI.dart';
import 'package:WeCare/view/firstAid/pages/aidhomepage.dart';
import 'package:WeCare/view/preparedness/Screens/Newsfeed.dart';
import 'package:flutter/material.dart';
import 'package:WeCare/view/authentication/phoneauthUI/continue_with_phone.dart';
import 'package:WeCare/view/donation/blood/bloodDonation.dart';
import 'package:WeCare/view/todo/myplans/my_plans.dart';
import 'package:WeCare/view/map/NearByHospitals/nearByHospital.dart';
import 'package:WeCare/view/map/disaster/distaster_Maptrack.dart';
import 'package:WeCare/view/map/foodAndShelter/foodAndShelter.dart';

class Bar extends StatefulWidget {
  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  Service obj = new Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        child: ListView(
          children: <Widget>[
            InkWell(
              child: UserAccountsDrawerHeader(
                accountName: Text("Amul Dhungel"),
                accountEmail: Text("applier1234@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://icons-for-free.com/iconfiles/png/512/facebook+profile+user+profile+icon-1320184041317225686.png"),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              ),
              // onTap: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => Profile(),
              //   ),
              // ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.deepPurple,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsFeed(),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.notifications_active,
                color: Colors.redAccent,
              ),
              title: Text(
                "Disaster Alert",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisasterMap()),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.person_pin_circle,
                color: Colors.green,
              ),
              title: Text(
                "Nearby Hospital",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NearHospital()),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.business_center,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Food & Shelter Distribution",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodAndShelter()),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.graphic_eq,
                color: Colors.teal,
              ),
              title: Text(
                "Covid Graph",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Covid()));
              },
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.redAccent,
              ),
              title: Text(
                "BloodDonor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => BloodDonation(true)),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.orange,
              ),
              title: Text(
                "PlasmaDonor",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PlasmaDonation(true)),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.assignment,
                color: Colors.black87,
              ),
              title: Text(
                "My Plans",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyPlans()),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.local_hospital,
                color: Colors.green,
              ),
              title: Text(
                "First Aid Package Online",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Homepage()),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                // color: Colors.blueGrey,
                color: Colors.pink,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              onTap: () async {
                await obj.signOut();
                await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContinueWithPhone()));
              },
            ),
            Divider(
              height: 2,
              color: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}
