import 'package:flutter/material.dart';

class ZodiacInfo {
  final String sign;
  final String symbol;

  ZodiacInfo({required this.sign, required this.symbol});
}

class GirlsNamesScreen extends StatelessWidget {
  final List<ZodiacInfo> zodiacInfoList = [
    ZodiacInfo(sign: 'Aries', symbol: '♈'),
    ZodiacInfo(sign: 'Taurus', symbol: '♉'),
    ZodiacInfo(sign: 'Gemini', symbol: '♊'),
    ZodiacInfo(sign: 'Cancer', symbol: '♋'),
    ZodiacInfo(sign: 'Leo', symbol: '♌'),
    ZodiacInfo(sign: 'Virgo', symbol: '♍'),
    ZodiacInfo(sign: 'Libra', symbol: '♎'),
    ZodiacInfo(sign: 'Scorpio', symbol: '♏'),
    ZodiacInfo(sign: 'Sagittarius', symbol: '♐'),
    ZodiacInfo(sign: 'Capricorn', symbol: '♑'),
    ZodiacInfo(sign: 'Aquarius', symbol: '♒'),
    ZodiacInfo(sign: 'Pisces', symbol: '♓'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Zodiac sign for Girls' Names"),
        backgroundColor: Color.fromARGB(255, 253, 1, 211),
      ),
      body: Container(
        color: Colors.pink[100],
        child: ListView.builder(
          itemCount: zodiacInfoList.length,
          itemBuilder: (context, index) {
            final zodiacInfo = zodiacInfoList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 253, 71, 211),
                      Color.fromARGB(255, 74, 20, 140)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Card(
                  elevation: 2.0,
                  color: Colors.transparent,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          '${zodiacInfo.sign}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${zodiacInfo.symbol}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.of(context).pushNamed('/gaeries');
                          break;
                        case 1:
                          Navigator.of(context).pushNamed('/gtaurus');
                          break;
                        case 2:
                          Navigator.of(context).pushNamed('/ggemini');
                          break;
                        case 3:
                          Navigator.of(context).pushNamed('/gcancer');
                          break;
                        case 4:
                          Navigator.of(context).pushNamed('/gleo');
                          break;
                        case 5:
                          Navigator.of(context).pushNamed('/gvirgo');
                          break;
                        case 6:
                          Navigator.of(context).pushNamed('/glibra');
                          break;
                        case 7:
                          Navigator.of(context).pushNamed('/gscorpio');
                          break;
                        case 8:
                          Navigator.of(context).pushNamed('/gsagittarius');
                          break;
                        case 9:
                          Navigator.of(context).pushNamed('/gcapricorn');
                          break;
                        case 10:
                          Navigator.of(context).pushNamed('/gaquarius');
                          break;
                        case 11:
                          Navigator.of(context).pushNamed('/gpisces');
                          break;
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
