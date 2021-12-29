import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_builder/timer_builder.dart';
// Date타입은 intl이 필요하다.
import 'package:intl/intl.dart';
import 'package:weather_app/model/model.dart';

class WeatherScreen extends StatefulWidget {
  //2. 생성자 생성
  WeatherScreen({this.parseWeatherData, this.parseAirPollution});
  //1. 변수 생성
  final dynamic parseWeatherData;
  final dynamic parseAirPollution;

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Model model = Model();
  // !@
  String cityName;
  int temp;
  Widget icon1;
  String des;
  Widget airIcon;
  Widget airState;
  double dust1;
  double dust2;

  // 변수 생성 후 나우 값을 준다.
  var date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }

  // !@ 이제 이 속성(변수)들을 사용하기 위해서 위에서 weatherScreen내에 변수를 추가함!
  void updateData(dynamic weatherData, dynamic airData) {
    // 기온을 소수점까지 안나오게 만들기 위해 temp 타입을 int로 변환하고 temp를 double tmep2로 바꾸고 2가지 방법이  있다.
    // 첫번째) temp = temp2.toint();로 변환 또는 소수점 반올림 하기 temp = temp2.round();
    double temp2 = weatherData['main']['temp'];
    temp = temp2.toInt();
    cityName = weatherData['name'];
    int condition = weatherData['weather'][0]['id'];
    icon1 = model.getWeatherIcon(condition);
    des = weatherData['weather'][0]['description'];
    int index = airData['list'][0]['main']['aqi'];
    airIcon = model.getAirIcon(index);
    airState = model.getAirCondition(index);
    dust1 = airData['list'][0]['components']['pm10'];
    dust2 = airData['list'][0]['components']['pm2_5'];

    print(temp);
    print(cityName);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.near_me),
          iconSize: 30,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.location_searching),
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                            ),
                            Text(
                              '$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                // 보여주고싶은 시간 단위를 설정(Duration)
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)),
                                  builder: (context) {
                                    print('${getSystemTime()}');
                                    return Text(
                                      '${getSystemTime()}',
                                      style: GoogleFonts.lato(
                                          fontSize: 16, color: Colors.white),
                                    );
                                  },
                                ),
                                // 요일 출력
                                Text(
                                  DateFormat(' - EEEE').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.white),
                                ),
                                // 날짜 출력
                                Text(
                                  DateFormat('d, MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                icon1,
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '$des',
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15,
                        thickness: 2,
                        color: Colors.white30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "AQI(대기질지수)",
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              airIcon,
                              SizedBox(
                                height: 10,
                              ),
                              airState,
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "미세먼지",
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$dust1",
                                style: GoogleFonts.lato(
                                    fontSize: 24, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "미세먼지 단위/m3",
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "초미세먼지",
                                style: GoogleFonts.lato(
                                    fontSize: 14, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$dust2",
                                style: GoogleFonts.lato(
                                    fontSize: 24, color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "미세먼지 단위/m3",
                                style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
