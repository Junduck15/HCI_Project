import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:provider/provider.dart';

import '../../check_provider.dart';
import 'coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(this.samplePoses, this.poses, this.absoluteImageSize, this.rotation, this.context);

  final List<Pose> samplePoses;
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  BuildContext context;


  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 4.0
    //   ..color = Colors.green;

    Pose sample = samplePoses[context.read<CheckPose>().sampleIdx];

    final afterPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.red;

    final samplePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.blueAccent;

    final samePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.green;

    for (final pose in samplePoses) {
      print('pose printing...');
      void paintCircle(
          PoseLandmarkType type) {
        final PoseLandmark joint1 = pose.landmarks[type]!;
        canvas.drawCircle(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            8,
            samplePaint);
      }

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      paintCircle(PoseLandmarkType.leftShoulder);
      paintCircle(PoseLandmarkType.rightShoulder);
      paintCircle(PoseLandmarkType.leftElbow);
      paintCircle(PoseLandmarkType.rightElbow);
      paintCircle(PoseLandmarkType.leftWrist);
      paintCircle(PoseLandmarkType.rightWrist);
      paintCircle(PoseLandmarkType.leftHip);
      paintCircle(PoseLandmarkType.rightHip);
      paintCircle(PoseLandmarkType.leftAnkle);
      paintCircle(PoseLandmarkType.rightAnkle);


      //Draw Sample arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, samplePaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, samplePaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, samplePaint);

      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, samplePaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          samplePaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, samplePaint);

      //Draw Sample Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, samplePaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          samplePaint);

      //Draw Sample legs
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.leftAnkle, samplePaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightAnkle, samplePaint);
    }
  
    
    for (final pose in poses) {
      bool isSame(PoseLandmark s, PoseLandmark j) {
        bool x = false;
        bool y = false;
        bool z = false;

        if(j.x + 10 >= s.x && j.x - 10 <= s.x){
          x = true;
        }
        if(j.y + 10 >= s.y && j.y - 10 <= s.y){
          y = true;
        }
        // if(j.z+6 >= s.z && j.z-6 <= s.z){
        //   z = true;
        // }

        if(x || y) {
          return true;
        } else {
          return false;
        }
      }

      void paintCircle(
          PoseLandmarkType type, int idx) {
        final PoseLandmark sample_joint1 = sample.landmarks[type]!;
        final PoseLandmark joint1 = pose.landmarks[type]!;
        // print(type.toString() + ": "+ sample_joint1.x.toString() + "= " + joint1.x.toString());
        if(type.toString() == 'PoseLandmarkType.rightElbow') {
          print(type.toString() + "x : "+ sample_joint1.x.toString() + "= " + joint1.x.toString());
          print(type.toString() + "y : "+ sample_joint1.y.toString() + "= " + joint1.y.toString());
          // print(type.toString() + "z : "+ sample_joint1.z.toString() + "= " + joint1.z.toString());
        }

        if(isSame(sample_joint1, joint1)) {
          context.watch<CheckPose>().checkAll[idx] = true;
          context.read<CheckPose>().isCheckAll();
          print(joint1.type);
        }

        canvas.drawCircle(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            8,
            isSame(sample_joint1, joint1) ? samePaint : afterPaint);
      }

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2) {
        final PoseLandmark sample_joint1 = sample.landmarks[type1]!;
        final PoseLandmark sample_joint2 = sample.landmarks[type2]!;
        final PoseLandmark joint1 = pose.landmarks[type1]!;
        final PoseLandmark joint2 = pose.landmarks[type2]!;

        bool isBothSame = false;
        if(isSame(sample_joint1, joint1) && isSame(sample_joint2, joint2)) {
          isBothSame = true;
        }
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            isBothSame ? samePaint : afterPaint);
      }

      paintCircle(PoseLandmarkType.leftShoulder, 0);
      paintCircle(PoseLandmarkType.rightShoulder, 1);
      paintCircle(PoseLandmarkType.leftElbow, 2);
      paintCircle(PoseLandmarkType.rightElbow, 3);
      paintCircle(PoseLandmarkType.leftWrist, 4);
      paintCircle(PoseLandmarkType.rightWrist, 5);
      paintCircle(PoseLandmarkType.leftHip, 6);
      paintCircle(PoseLandmarkType.rightHip, 7);
      paintCircle(PoseLandmarkType.leftAnkle, 8);
      paintCircle(PoseLandmarkType.rightAnkle,  9);


      //Draw arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder);

      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip);

      //Draw legs
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.leftAnkle);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightAnkle);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses || oldDelegate.samplePoses != samplePoses;
  }
}
