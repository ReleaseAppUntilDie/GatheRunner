import Foundation
import MapKit
import SwiftUI

// 에러 예외처리 필요 -> 구현 예정
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion()
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        // CLLocationManagerDelegate는 대리인의 메서드를 호출하여 위치 관련 이벤트를 앱에 보고합니다. 객체에 이 프로토콜을 구현하여 위치정보를 업데이트 할 수 있다. 예를 들어, 현재 위치를 사용하여 지도에서 사용자의 위치를 업데이트하거나 사용자의 현재 위치와 관련된 검색 결과를 반환할 수 있다.
        // CLLocationManagerDelegate 프로토콜을 사용할때 CLLocationManager() 객체를 담을 변수 하나를 선언하고 이 변수를 통해 각종 설정을 진행하면 된다.
        manager.delegate = self
        // 정밀한 위치 사용을 위해 kCLLocationAccuracyBest 값을 대입
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // 앱 사용중에만 위치 정보 권한 요청창 띄우기 및 설정
        manager.requestWhenInUseAuthorization()
        // 위치정보 수신 기능을 시작하는 메서드
        manager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate 프로토콜에 정의된 locationManager 구현
    // didUpdateLocations는 현재 위치를 반영한 배열을 반환한다. 이 배열은 시간 순서대로 기록되어 있고 마지막값이 현재값이다.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            // CLLocationCoordinate2D을 사용하여 현재 위치의 위도, 경도를 wgs84 좌표계 값으로 변환해 반환한다
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            // span은 지도의 확대에 관한 설정값이고 값이 작을수록 확대된다.
            let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
            // 위에서 설정된 center, span값을 이용해 region 변수에 할당한다
            // MKCoordinateRegion은 struct로 특정 경도와 위도를 중심으로 둘러싼 사각형 모양의 지역범위를 표시한다.
            // region은 ObservableObject 프로토콜을 준수하는 ViewModel 객체에서 View에 데이터를 바인딩 하기 위해 @Published 프로퍼티 래퍼를 사용한 변수이다.
            // @Published 어노테이션은 속성이 변경되면 속성의 willSet 블록에서 게시가 발생하며, 이는 구독자가 실제로 프로퍼티에 값이 설정되기 전에 새 값을 전달 받는다는 것을 의미한다.
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
}
