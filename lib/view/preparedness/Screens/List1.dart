import 'package:WeCare/view/preparedness/protectiontips.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class List1 extends StatefulWidget {
  @override
  _List1State createState() => _List1State();
}

class _List1State extends State<List1> {
  List<String> titles = [
    "Hand Washing",
    "Earthquake",
    "Landslide",
    "flood",
    "fire",
    "Thunderstrom",
    "Windstrom",
    "Snakebite",
    "epidemic",
    "Drought",
    "Avalanche",
    "Hailstrom",
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: titles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: MediaQuery.of(context).size.height * 0.001,
          crossAxisCount: 3),
      itemBuilder: (context, index) {
        return InkWell(
            child: SizedBox(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.purple[300],
                    child: CircleAvatar(
                        radius: 26,
                        child: ClipRRect(
                          child: SvgPicture.asset(
                            "images/${titles[index]}.svg",
                          ),
                          borderRadius: BorderRadius.circular(25),
                        )),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    titles[index].toUpperCase(),
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'georgia',
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurpleAccent[300]),
                  ),
                ],
              ),
            ),
            onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Tips(apptitle: titles[index]);
                })));
      },
    );
  }
}
