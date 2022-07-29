GatheRunner Swift Style Guide 
=============
# 목적
스타일 가이드를 준수해야하는 이유:
+ 코드의 가독성은 이해를 돕는다.
+ 유지보수가 용이해진다.
+ 자잘한 실수가 줄어든다.   

## 목차
[1.환경설정](#환경설정) 

[2.네이밍](#네이밍)
   + [유형 추론 컨텍스트 사용](#유형 추론 컨텍스트 사용)  
   
     <details>
  <summary>선호:</summary>
  <pre>
  <code>
let selector = #selector(viewDidLoad)
view.backgroundColor = .red
let toView = context.view(forKey: .to)
let view = UIView(frame: .zero)
  </code>
  </pre>

  <summary>선호하지 않음 :</summary>
  
  <pre>
  <code>
let selector = #selector(ViewController.viewDidLoad)
view.backgroundColor = UIColor.red
let toView = context.view(forKey: UITransitionContextViewKey.to)
let view = UIView(frame: CGRect.zero)
   </pre>
   </code>
   </details>  

[3.스타일](#스타일)
   + [함수](#함수)   
   + [클로저](#클로저)   
   + [연산자](#연산자)
     
[4.패턴](#패턴)   
   + [StyleModifiers](#StyleModifiers)   


[5.파일 구성](#파일-구성)   

[6.코드 구성](#코드 구성)   


## 환경설정    
* * *

## 네이밍    
+ 타입 및 프로토콜의 이름에는 PascalCase를 사용하고, 그 외 변수,함수등 다른 모든 이름에는 lowerCamelCase를 사용한다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  protocol Item {
    // ...
  }

  class ChildItem: Item {

    enum ItemType {
      // ...
      }

    var target: [Members] = []
    static let worldName: String = "Earth"

    func addList(_ item: Spaceship) {
      // ...
     }
  }

  let myFleet = SpaceFleet()
  </code>
  </pre>
  </details>  
 
+ Bool타입 변수의 네이밍은 isTrue, hasItem 의 형태로만 선언한다.    
+ 두문자어(약어)는 모두 대문자이거나, 모두 소문자이어야 한다.

  <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  // WRONG
  class UrlValidator {
  func isValidUrl(_ URL: URL) -> Bool {
  // ...
    }
  }

  // RIGHT
  class URLValidator {
  func isValidURL(_ url: URL) -> Bool {
    // ...
     }
   }
   </pre>
   </code>
   </details>        


## 네이밍    
확장을 사용하여 코드를 기능의 논리적 블록으로 구성합니다. 각 확장은 // MARK: -잘 정리된 상태를 유지하기 위해 주석으로 시작해야 합니다.

### 미사용 코드 제거
Xcode 템플릿 코드 및 자리 표시자 주석을 포함하여 사용되지 않는(죽은) 코드는 제거해야 합니다. 튜토리얼이나 책에서 사용자에게 주석 처리된 코드를 사용하도록 지시하는 경우는 예외

### Import 최소화
소스 파일에 필요한 모듈만 가져옵니다.

  <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  
  // WRONG
import UIKit
import Foundation
var view: UIView
var deviceModels: [String]

  // RIGHT
import UIKit
var view: UIView
var deviceModels: [String]

  // WRONG
import UIKit
var deviceModels: [String]

  // RIGHT
import Foundation
var deviceModels: [String]
   </pre>
   </code>
   </details>    




* * *

