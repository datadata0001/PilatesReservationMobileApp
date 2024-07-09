import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplateLoginPages1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Stack(
      children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: 1440,
              height: 1024,
              child: SvgPicture.asset(
                'assets/vectors/vector_x2.svg',
              ),
            ),
          ),
    Container(
          width: 1440,
          child: Container(
            width: 1440,
            height: 1024,
            child: SizedBox(
              width: 1440,
              height: 1024,
              child: SvgPicture.asset(
                'assets/vectors/clip_path_group_x2.svg',
              ),
            ),
          ),
        ),
      ],
    );
  }
}