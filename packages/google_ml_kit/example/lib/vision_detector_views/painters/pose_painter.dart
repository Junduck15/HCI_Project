import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import 'coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(this.samplePoses, this.poses, this.absoluteImageSize, this.rotation);

  final List<Pose> samplePoses;
  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    // final paint = Paint()
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 4.0
    //   ..color = Colors.green;

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
      void paintCircle(
          PoseLandmarkType type) {
        final PoseLandmark joint1 = pose.landmarks[type]!;
        canvas.drawCircle(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            20,
            samePaint);
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
      //Draw arms
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, afterPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, afterPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, afterPaint);

      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, afterPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          afterPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, afterPaint);

      //Draw Body
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, afterPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          afterPaint);

      //Draw legs
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.leftAnkle, afterPaint);
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightAnkle, afterPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses || oldDelegate.samplePoses != samplePoses;
  }
}
