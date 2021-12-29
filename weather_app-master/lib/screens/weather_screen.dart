import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  //2. 생성자 생성
  WeatherScreen({this.parseWeatherData});
  //1. 변수 생성
  final dynamic parseWeatherData;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // !@
  String cityName;
  int temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData);
  }

  // !@ 이제 이 속성(변수)들을 사용하기 위해서 위에서 weatherScreen내에 변수를 추가함!
  void updateData(dynamic weatherData) {
    // 기온을 소수점까지 안나오게 만들기 위해 temp 타입을 int로 변환하고 temp를 double tmep2로 바꾸고 2가지 방법이  있다.
    // 첫번째) temp = temp2.toint();로 변환 또는 소수점 반올림 하기 temp = temp2.round();
    double temp2 = weatherData['main']['temp'];
    temp = temp2.toInt();
    cityName = weatherData['name'];

    print(temp);
    print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //생성자를 통해서 객체가 생성 될 때, 데이터 전달
            Text(
              '$cityName',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '$temp',
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
      )),
    );
  }
}
