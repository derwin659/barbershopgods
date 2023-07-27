

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget textoReceta(){
  return Column(
    children: [
      Container(
        alignment: AlignmentDirectional.topStart,
        margin:EdgeInsets.only(left: 30.0,top: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('El corte Mullet , tiene más tendencia', style: GoogleFonts.robotoMono(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black),),
            Text('Un corte originario de Colombia, que contiene un estilo único, hoy en día ha sido más popular', style: GoogleFonts.robotoMono(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black),),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(child: Row(children: [
                    Icon(Icons.timelapse,color:Colors.black),
                    Container(
                      child:    Text('45 min', style: GoogleFonts.robotoMono(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),),
                    )

                  ],)),
                  Expanded(child: Row(children: [
                    Icon(Icons.timelapse,color:Colors.black),
                    Container(
                      child:    Text('30 min', style: GoogleFonts.robotoMono(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),),
                    )

                  ],))
                ],
              ),
            )
          ],
        ),
      )
    ],
  );
}