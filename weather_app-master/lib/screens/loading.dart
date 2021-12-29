import 'package:flutter/material.dart';

import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apikey = '7554ce078e572d917bfb8ed345ce2c34';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  // 새로 생성하는 변수와 포지션 악규먼트와 같을 수 있어서 뒤에 2 붙여서 변수 생성하기.
  // double latitude2;
  // double longitude2;

  double latitude3;
  double longitude3;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    // 2-4 response을 출력하기위해서.(print(response.body))
  }

  //1. 메서드 만들기
  void getLocation() async {
    MyLocation myLocation = MyLocation();
    // getMyLocation메서드의 실행이 끝나서 위도,경도 값이 리턴될 때까지 기다려야하기에 await키워드를 붙여줌!
    // await는 반드시 future가 끝날때까지 기다려야한다는 의미 즉 my_location에서 void getLocation method에서 future<void> getLocation()메서드로 변경하기!
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apikey');
    //최종적으로 getJsond에서 parsing된 데이터를 출력하기 위해 var type의 weatherData 변수에 getJson데이터의 메서드 값을 할당
    // 또한 getJsonData는 Futrue dynamic타입으로 parsingData를 리턴해주고 있으므로 await 키워드가 붙는다.
    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      // 페이지 이동 시, WeatherScreen 인스턴스 위젯이 생성될 때 parse(argument)data를 불러와서 여기에 weather데이터를 전달해주면 된다.
      // weatherscreen 인스턴스가 생성될 때마다 필요한 데이터를 로딩에서부터 전달 받을 수 있다.
      return WeatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));

    /*
     // 실행에 실패할 수도 있는 코드
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position);
      // Position argument(latitue, nongitude 불러오기)
      latitude2 = position.latitude;
      longitude2 = position.longitude;
      print(latitude2);
      print(longitude2);
      //코드 실행에 실패할 경우 출력될 내용(예외처리 구문)
    } catch (e) {
      print('There was a problem with the internet connection.');
    }
  }
    */
  }

  // 2. 네트워크 요청하기(http.get메서드 불러오기!)
  // void fetchData() async {

  //     var myJson = parsingData['weather'][0]['description'];
  //     // var myJson = jsonDecode(jsonData)['weather'][0]['description'];
  //     var wind = parsingData['wind']['speed'];
  //     var id = parsingData['id'];
  //     print(myJson);
  //     print(wind);
  //     print(id);
  //   } else {
  //     print(response.statusCode);
  //   }
  //   //print(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: null,
          // () {
          //   // getLocation();
          // },
          child: Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
