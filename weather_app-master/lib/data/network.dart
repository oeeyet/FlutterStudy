//fetchdata 메서드 리팩토링
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  // 1. 클래스에서 인스턴스를 생성 될 때, 생성자를 통해서 url을 입력받도록 해준다. (url은 당연히 String)
  final String url;
  final String url2;
  //1-1 . 생성자에 추가해준다!
  Network(this.url, this.url2);

  // 2. 새롭게 getJson file을 만듬
  Future<dynamic> getJsonData() async {
    // http 패키지에서 사용하는 get으로 Response
    //2-1 이 get메서드를 통해 가져온 데이터를 보관하려면 Respose변수의 타입을 지정후 담아놓아야한다. 근데 get메서드는 future타입이기에 async로 작동해야한다.(미래의 어느시점에 데이터를 다 가져와야하기 때문에 기다려야한다)
    http.Response response = await http.get(url);
//2-3 fechData()함수를 호출함! (위에서 인잇초기화하는 곳에서~) response을 출력하기위해서.
    if (response.statusCode == 200) {
      String jsonData = response.body;
      // 이 객체에 사용된 메서드는 최종호출 단계에서 decode메서드를 통해서 parsing 된 json 값을 return해줘야 한다.
      var parsingData = jsonDecode(jsonData);
      return parsingData; // ->return값이 있음 더이상 void가 아니라는 의미.(위에 수정)
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(url2);
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
}
