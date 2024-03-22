import 'package:flutter/material.dart';
import 'package:touchable/touchable.dart';
import "dart:math" show pi;

class SectorsPainter extends CustomPainter {
  final BuildContext context;
  final Function onTap;
  SectorsPainter({required this.context, required this.onTap});

  @override
  void paint(Canvas canvas, Size size) {
    //final double mainCircleDiameter = size.width;
    //final double mainCircleDiameter = size.height / 12;

    List<String> segName = [
      'CP1',
      'CP2',
      'CP3',
      'CL',
      'TH',
      'LU',
      'PV',
      'SC',
      'HU',
      'CU',
      'CA',
      'DI',
      'CX',
      'GE',
      'TA',
      'PE',
    ];

    List<List<int>> subPoint = [
      [1, 2, 3, 1], // RE LA , RE ME, AN ME, AN LA  per segmento 'CP1',
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [1, 2, 3, 1],
      [2, 2, 2, 2],
      [1, 1, 1, 1],
    ];

    List<bool> attiviExt = [true, false, false, true, true, true];
    List<List<bool>> attiviInt = [
      [false, true, false],
      [false, true, false],
      [true, true, true],
      [true, true, true],
    ];

    final double mainCircleDiameter = size.width / 7;
    double xPos = size.width / 2 - mainCircleDiameter / 2;
    double yPos = 0;
    const double mezzoSpazio = 3;
    final double dx = mainCircleDiameter / 2 + mezzoSpazio;
    final double dy = mainCircleDiameter + 3;
    var myCanvas = TouchyCanvas(context, canvas);

    // testa + corpo
    var s = 0;
    for (int i = 0; i < 7; i++) {
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xPos - dx,
        yPos,
        segName[s],
        subPoint[s],
        attiviExt,
        attiviInt,
      );
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xPos + dx,
        yPos,
        segName[s],
        subPoint[s++],
        attiviExt,
        attiviInt,
      );
      yPos += dy;
    }

    // braccia
    yPos = dy * 3 + mainCircleDiameter / 2;
    double xxPos = xPos;
    double dxx = mainCircleDiameter;
    for (int i = 0; i < 5; i++) {
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xxPos - dx - dxx,
        yPos,
        segName[s],
        subPoint[s],
        attiviExt,
        attiviInt,
      );
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xxPos + dx + dxx,
        yPos,
        segName[s],
        subPoint[s++],
        attiviExt,
        attiviInt,
      );

      if (i == 0) {
        yPos += dy - 15;
        dxx += 40;
      } else {
        yPos += dy;
        dxx += 10;
      }
    }

    // gambe
    yPos = dy * 6 + mainCircleDiameter / 2 + 10;
    xxPos = xPos;
    dxx = mainCircleDiameter;
    for (int i = 0; i < 4; i++) {
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xxPos - dx - dxx + 8,
        yPos,
        segName[s],
        subPoint[s],
        attiviExt,
        attiviInt,
      );
      disegnaCorone(
        context,
        canvas,
        myCanvas,
        mainCircleDiameter,
        xxPos + dx + dxx - 8,
        yPos,
        segName[s],
        subPoint[s++],
        attiviExt,
        attiviInt,
      );
      yPos += dy;
      dxx += 12;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void disegnaCorone(
    BuildContext context,
    Canvas canvas,
    TouchyCanvas myCanvas,
    double mainCircleDiameter,
    double xPos,
    double yPos,
    String segName,
    List<int> subPoint,
    List<bool> attiviExt,
    List<List<bool>> attiviInt,
  ) {
    List<Color> sectorColors = [
      Colors.redAccent,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.amber
    ];

    List<String> colorsName = [
      'Rosso',
      'Arancio',
      'Giallo',
      'Verde',
      'Teal',
      'Blu',
      'Viola',
      'Purple',
      'Pink',
      'Ambra',
    ];

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    final arcsRect =
        Rect.fromLTWH(xPos, yPos, mainCircleDiameter, mainCircleDiameter);
    const useCenter = true;

    const double separatore = 0.0349066;
    double sweepAngle = pi / 3 - separatore;
    double startAngle = -pi / 2;

    // corona esterna
    for (int i = 0; i < 6; i++) {
      myCanvas.drawArc(
        arcsRect,
        startAngle,
        sweepAngle,
        useCenter,
        paint..color = attiviExt[i] ? sectorColors[i] : Colors.white,
      );
      startAngle = startAngle + sweepAngle + separatore;
    }

    // corona interna
    startAngle = 0.0;
    var mainCircleDiameter2 = mainCircleDiameter / 3 * 2;
    var arcsRect2 = Rect.fromLTWH(
        xPos + mainCircleDiameter / 6,
        yPos + mainCircleDiameter / 6,
        mainCircleDiameter2,
        mainCircleDiameter2);
    for (int i = 6; i < 10; i++) {
      sweepAngle = (pi / 2 - separatore * subPoint[i - 6]) / subPoint[i - 6];
      for (int m = 1; m <= subPoint[i - 6]; m++) {
        myCanvas.drawArc(
          arcsRect2,
          startAngle,
          sweepAngle, // 0,0349066
          useCenter,
          paint
            ..color = attiviInt[i - 6][m - 1] ? sectorColors[i] : Colors.white,
        );
        startAngle = startAngle + sweepAngle + separatore;
      }
    }

    // circonferenze nere
    final Paint paint1 = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    Offset circleOffset1 =
        Offset(mainCircleDiameter / 2 + xPos, mainCircleDiameter / 2 + yPos);
    double innerCircleRaw1 = mainCircleDiameter / 6;
    myCanvas.drawCircle(
        circleOffset1, innerCircleRaw1, paint1..color = Colors.black);
    innerCircleRaw1 = mainCircleDiameter / 3;
    myCanvas.drawCircle(
        circleOffset1, innerCircleRaw1, paint1..color = Colors.black);
    innerCircleRaw1 = mainCircleDiameter / 2;
    myCanvas.drawCircle(
        circleOffset1, innerCircleRaw1, paint1..color = Colors.black);

    // cerchio bianco
    final double innerCircleRaw = mainCircleDiameter / 6;
    Offset circleOffset =
        Offset(mainCircleDiameter / 2 + xPos, mainCircleDiameter / 2 + yPos);
    myCanvas.drawCircle(
      circleOffset,
      innerCircleRaw,
      paint..color = Colors.white,
      onTapUp: (tapDetail) {
        onTap(tapDetail);
      },
    );

    // testo nel cerchio interno
    double fSize;
    if (segName.length > 2) {
      fSize = 10;
    } else {
      fSize = 12;
    }
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: segName,
        style: TextStyle(
            color: Colors.black,
            fontSize: fSize,
            fontWeight: FontWeight.normal),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(
          xPos + mainCircleDiameter / 2 - 8, yPos + mainCircleDiameter / 2 - 7),
    );
  }
}
