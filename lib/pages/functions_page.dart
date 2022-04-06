import 'package:flutter/material.dart';
import 'package:oscar/functions/math_function.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FunctionsPage extends StatefulWidget {
  @override
  _FunctionsPageState createState() => _FunctionsPageState();
}


class _FunctionsPageState extends State<FunctionsPage> {

  final List<Color> _gradient1 = [
    const Color(0xff06B782),
    const Color(0xffFC67A7),
    const Color(0xffFFD541),
    const Color(0xff441DFC),
  ];
  final List<Color> _gradient2 = [
    const Color(0xff06B782),
    const Color(0xffF6815B),
    const Color(0xffF0B31A),
    const Color(0xff4E81EB),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Center(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _functionContainer('Математика', Color(0xff441DFC), Color(0xff4E81EB), Icon(Icons.height, color: Colors.white,), MathFunction()),
                    _functionContainer('Математика', Color(0xffFC67A7), Color(0xffF6815B),  Icon(Icons.height, color: Colors.white,), MathFunction()),
              ],
            ),
          ),
        )
        )
      ],
    );
  }


  Widget _functionContainer(String text, Color gradient1, Color gradient2, Icon containerIcon, Widget functionWindow) {
    return GestureDetector(
      onTap: () {
        Navigator.push((context), MaterialPageRoute(builder: (context) => functionWindow));
      },
      child: Container(
        margin: EdgeInsets.only(left: 15),
        width: 165,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              gradient1,
              gradient2
            ],
          ),
          boxShadow: [BoxShadow(
            color: gradient1.withOpacity(0.3),
            blurRadius: 13,
            spreadRadius: 3,
            offset: Offset(3, 3)
          )]
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26)
                ),
                child: SvgPicture.asset('assets/svg/card_vector_one.svg', width: 165),
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(26)
                ),
                child: SvgPicture.asset('assets/svg/card_vector_two.svg', width: 165),
              ),
            ),
            Positioned(
              top: 28,
              left: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: TextStyle(fontSize: 22, color: Colors.white),),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}