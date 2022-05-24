import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../check_provider.dart';
import '../sports_expert.dart';
import 'camera_view.dart';
import 'detector_views.dart';
import 'painters/pose_painter.dart';

class PoseDetectorView extends StatefulWidget {
  final SportsExpert sportsExpert;
  final List< List<Pose> > processedImage;

  PoseDetectorView({required this.sportsExpert, required this.processedImage});
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());

  final PoseDetector _imagePoseDetector = PoseDetector(options: PoseDetectorOptions());

  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  late List< List<Pose> > processedImage;

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Pose Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      print(context.read<CheckPose>().sampleIdx);

      final painter = PosePainter(widget.processedImage[context.read<CheckPose>().sampleIdx], poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation, context);
      _customPaint = CustomPaint(painter: painter);
      // context.read<CheckPose>().isCheckAll();
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
