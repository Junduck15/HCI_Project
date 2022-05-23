import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit_example/sports_expert.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'vision_detector_views/detector_views.dart';


class BeforePoseDetector extends StatefulWidget {
  final SportsExpert sportsExpert;
  BeforePoseDetector({required this.sportsExpert});

  @override
  State<BeforePoseDetector> createState() => _BeforePoseDetectorState();
}

class _BeforePoseDetectorState extends State<BeforePoseDetector> {
  int currentIndex = 0;
  List< List<Pose> > processedImage = [];
  final PoseDetector _imagePoseDetector = PoseDetector(options: PoseDetectorOptions());


  @override
  void initState() {
    // TODO: implement initState
    processImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(widget.sportsExpert.name, style: TextStyle(color: Colors.black),),
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCarouselSlider(),
            SizedBox(height: 20,),
            _buildButton()
          ],
        )
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Center(
      child: Container(
        // height: 500,
        width: 320,
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(
                    () {
                  currentIndex = index;
                },
              );
            },
            height: 550,
          ),
          items: widget.sportsExpert.postures!.map(
                  (item) => Card(
                    elevation: 2,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30,),
                        Center(
                          child: Container(
                            height: 270,
                            width: 190,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(35)
                            ),
                          ),
                        ), // image part
                        SizedBox(height: 25,),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(item.posture, style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: SizedBox(
                              height: 120,
                              child: Text(item.postureComment)),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.sportsExpert.postures!.map((urlOfItem) {
                              int index = widget.sportsExpert.postures!.indexOf(urlOfItem);
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == index
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                ),
                              );
                            }).toList()),
                      ],
                    ),
                  )).toList(),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: 320,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          minimumSize: Size.fromHeight(60),
        ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PoseDetectorView(sportsExpert: widget.sportsExpert, processedImage: processedImage,)),
            );
          },
          child: Text('Start', style: TextStyle(color: Colors.white),)
      ),
    );
  }
  Future<void> processImages() async{
    for(var p in widget.sportsExpert.postures!) {
      print('print poses: ' + p.posetureImage);
      String imagePath = p.posetureImage;

      var bytes = await rootBundle.load('assets/poses/$imagePath');
      // print(bytes);
      //
      String path = (await getTemporaryDirectory()).path;
      //
      File file = File('$path/$imagePath');
      print('file1: ' + file.path);
      //
      await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      print('file2: ' + file.path);

      final inputImage = InputImage.fromFile(file);
      List<Pose> _poses = await _imagePoseDetector.processImage(inputImage);

      processedImage.add(_poses);
    }
    print('Process Image done');
    print(processedImage.length);
  }
}
