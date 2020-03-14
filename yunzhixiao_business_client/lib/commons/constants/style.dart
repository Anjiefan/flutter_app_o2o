import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'gaps.dart';

class TextStyles {

  static const TextStyle textSize12 = const TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = const TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 = const TextStyle(
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = const TextStyle(
      fontSize: Dimens.font_sp16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = const TextStyle(
      fontSize: Dimens.font_sp18,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = const TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold
  );

  static const TextStyle textGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
  );
  static const TextStyle textDarkGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
  );

  static const TextStyle textWhite14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = const TextStyle(
      fontSize: Dimens.font_sp14,
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = const TextStyle(
      fontSize: Dimens.font_sp14,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = const TextStyle(
      fontSize: Dimens.font_sp12,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textHint14 = const TextStyle(
      fontSize: Dimens.font_sp14,
  );
}
