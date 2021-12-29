import 'package:geolocator/geolocator.dart';

// getLocation()기능 옮겨오기!
// 1. 클래스 생성
class MyLocation {
  double latitude2; // 위도와 경도 받을거라 타입 더블로 지정
  double longitude2;

// 2. 메서드 생성
  Future<void> getMyCurrentLocation() async {
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
}
