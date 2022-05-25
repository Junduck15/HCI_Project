import 'package:flutter/material.dart';
import 'before_pose_detector.dart';
import 'result.dart';
import 'sports_expert.dart';

class Home extends StatelessWidget {
  List<SportsExpert> home_sports_experts = [
    SportsExpert(name: 'Squat', image: 'assets/poses/squat.jpeg', postures: [
      Posture(
          posture: 'Start Position',
          postureComment:
              'Freely hold your hands\nWiden your feet to your shoulder-width\nStraighten your back\nTurn your toes out (between 5~15 degrees)',
          posetureImage: 'assets/poses/squat1.jpeg'),
      Posture(
          posture: 'Action Pose',
          postureComment:
              'Fully sit down\nPress your heels to the ground\nStraighten your back\nKeep lower back neutral',
          posetureImage: 'assets/poses/squat2.jpeg'),
    ]),
    SportsExpert(
        name: 'Shoulder Press',
        image: 'assets/poses/shoulder_press.jpeg',
        postures: [
          Posture(
              posture: 'Start Position',
              postureComment:
                  'Lift your arms and make and make 90 degrees with elbow\nStraighten your back',
              posetureImage: 'assets/poses/sp3.jpeg'),
          Posture(
              posture: 'Action Pose',
              postureComment:
                  'Lift your arms\nMake two arms parallel to each other\nRepeat the action',
              posetureImage: 'assets/poses/sp4.jpeg'),
        ]),
    SportsExpert(name: 'Push up', image: 'assets/poses/pushup.jpeg', postures: [
      Posture(
          posture: 'Start Position',
          postureComment:
              'First lay down on the ground\nWiden your hands to your shoulder-width\nStraighten your back',
          posetureImage: 'assets/poses/pushup1.jpeg'),
      Posture(
          posture: 'Action Pose',
          postureComment:
              'Push your hands to go up\nFully stretch your elbow\nStraighten your back and legs\nRepeat the action',
          posetureImage: 'assets/poses/pushup2.jpeg'),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
            onPressed: () {
             Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Result()));
            },
            child: Text('Result')),
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Pocket Trainer',
          style: TextStyle(color: Colors.black),
        ),
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
                    MaterialPageRoute(
                        builder: (context) => BeforePoseDetector(
                            sportsExpert: home_sports_experts[index])),
                  );
                },
                child: Card(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        width: 50,
                        height: 50,
                        child: Image(
                            image: AssetImage(home_sports_experts[index].image),
                            fit: BoxFit.fill),
                      ),
                      Expanded(
                          child: Center(
                              child: Text(home_sports_experts[index].name)))
                    ],
                  ),
                ),
              );
            }),
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
