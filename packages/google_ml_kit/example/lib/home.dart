import 'package:flutter/material.dart';
import 'package:google_ml_kit_example/sports_expert.dart';
import 'cameraView.dart';
import 'vision_detector_views/detector_views.dart';
  List<SportsExpert> home_sports_experts = [
    SportsExpert(name: 'Squat', image: 'squat', video: ['first', 'second', 'third']),
    SportsExpert(name: 'Shoulder Press', image: ''),
    SportsExpert(name: 'Push up', image: ''),
  ];
class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text('Pocket Trainer', style: TextStyle(color: Colors.black),),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: GridView.builder(
          itemCount: 3,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
              childAspectRatio: 3 / 1, //item 의 가로 1, 세로 2 의 비율
              mainAxisSpacing: 10, //수평 Padding
              crossAxisSpacing: 10, //수직 Padding
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PoseDetectorView()),
  );
                },
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: 50,
                        height: 50,
                        color: Colors.blue,
                      ),
                      Expanded(
                          child: Center(child: Text(home_sports_experts[index].name))
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Colors.black,
      //   selectedLabelStyle: const TextStyle(fontSize: 12),
      //   items: const [
      //     BottomNavigationBarItem(
      //       label: 'Learn',
      //       icon: Icon(Icons.directions_run_outlined, size: 20,),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Video',
      //       icon: Icon(Icons.camera_alt_outlined, size: 20,),
      //     ),
      //     BottomNavigationBarItem(
      //       label: 'Profile',
      //       icon: Icon(Icons.person_outline, size: 20,),
      //     ),
      //   ],
      // ),
    );
  }
}
