import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sucial/utils/colors.dart';

TextStyle? kHeadingTextStyle = GoogleFonts.montserrat(
  color: primaryColor,
  fontWeight: FontWeight.w900,
  fontSize: 30.0,
  letterSpacing: -0.7,
);

final kButtonLightTextStyle = GoogleFonts.montserrat(
  color: primaryColor,
  fontSize: 20.0,
  letterSpacing: -0.7,
);

final kButtonDarkTextStyle = GoogleFonts.montserrat(
  color: thirdColor,
  fontSize: 20.0,
  letterSpacing: -0.7,
);

final kAppBarTitleTextStyle = GoogleFonts.montserrat(
  color: secondaryColor,
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.7,
);

final kBoldLabelStyle = GoogleFonts.montserrat(
  fontSize: 17.0,
  color: primaryColor,
  fontWeight: FontWeight.w600,
);

final kLabelStyle = GoogleFonts.montserrat(
  fontSize: 14.0,
  color: primaryColor,
);

final kOutlinedDarkButtonStyle = OutlinedButton.styleFrom(
  shape: StadiumBorder(),
  backgroundColor: secondaryColor,
);

final kOutlinedCircleDarkButtonStyle = OutlinedButton.styleFrom(
  shape: CircleBorder(),
  backgroundColor: primaryColor,
);

