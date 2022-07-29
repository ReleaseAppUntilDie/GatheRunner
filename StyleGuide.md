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
   
   정적 및 클래스 속성
   
                <details>
  <summary>예시</summary>
  
  <pre>
  <code>
public class UIColor {
  public class var red: UIColor {                // GOOD.
    // ...
  }
}

public class URLSession {
  public class var shared: URLSession {          // GOOD.
    // ...
  }
}
   </code>
      </pre>
         </details>  
        
        약식

                <details>
  <summary>예시</summary>
  
  <pre>
  <code>
func enumeratedDictionary<Element>(
  from values: [Element],
  start: Array<Element>.Index? = nil
) -> [Int: Element] {
  // ...
}
   </code>
      </pre>
         </details> 
         
typealias

 <details>
  <summary>예시</summary>
  
  <pre>
  <code>
func doSomething() {
  // ...
}

let callback: () -> Void

   </code>
      </pre>
    </details> 
         
Nesting and Namespacing

 <details>
  <summary>예시</summary>
  
  <pre>
  <code>
class Parser {
  enum Error: Swift.Error {
    case invalidToken(String)
    case unexpectedEOF
  }

  func parse(text: String) throws {
    // ...
  }
}
   </code>
      </pre>
    </details>
    
    for-where Loops
<details>
  <summary>예시</summary>
  
  <pre>
  <code>
for item in collection where item.hasProperty {
  // ...
}
   </code>
      </pre>
    </details>

## 코드 구성    
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

### 간격
시각적 명확성과 구성을 돕기 위해 메서드 사이에는 한 줄의 빈 줄이 있어야 하고 형식 선언 사이에는 최대 한 줄의 빈 줄이 있어야 합니다. 메서드 내의 공백은 기능을 분리해야 하지만 메서드에 너무 많은 섹션이 있으면 여러 메서드로 리팩토링해야 하는 경우가 많습니다.

여는 중괄호 뒤나 닫는 중괄호 앞에 빈 줄이 없어야 합니다.

닫는 괄호는 한 줄에 단독으로 나타나지 않아야 합니다.

  <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  
  // WRONG
if user.isHappy
{
  // Do something
}
else {
  // Do something else
}

   </code>
   
  <code>
  
  // RIGHT
if user.isHappy {
  // Do something
} else {
  // Do something else
}

   </code>
      </pre>
   </details>  

콜론은 항상 왼쪽에 공백이 없고 오른쪽에 하나의 공백이 있습니다. 삼항 연산자 ? :, 빈 사전 [:]및 #selector구문 은 예외 addTarget(_:action:)입니다.
  <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  
  // WRONG
class TestDatabase : Database {
  var data :[String:CGFloat] = ["A" : 1.2, "B":3.2]
}
   </code>
   
  <code>
  
  // RIGHT
class TestDatabase: Database {
  var data: [String: CGFloat] = ["A": 1.2, "B": 3.2]
}

   </code>
      </pre>

### 일반 서식

   한 줄에 하나의 명령문

   한 줄 에 최대 하나의 명령문 이 있으며 각 명령문 뒤에는 줄 바꿈이 옵니다. 단, 0개 또는 1개의 명령문이 포함된 블록으로 줄이 끝나는 경우는 예외입니다.

  <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  
guard let value = value else { return 0 }

defer { file.close() }

switch someEnum {
case .first: return 5
case .second: return 10
case .third: return 20
}

let squares = numbers.map { $0 * $0 }

var someProperty: Int {
  get { return otherObject.property }
  set { otherObject.property = newValue }
}

var someProperty: Int { return otherObject.somethingElse() }

required init?(coder aDecoder: NSCoder) { fatalError("no coder") }

   </code>
   

      </pre>
   </details>  

   줄바꿈

     <details>
  <summary>예시</summary>
  
  <pre>
  <code>
  public func performanceTrackingIndex<Elements: Collection, Element>(
  of element: Element,
  in collection: Elements
) -> (
  Element.Index?,
  PerformanceTrackingIndexStatistics.Timings,
  PerformanceTrackingIndexStatistics.SpaceUsed
) {
  // ...
}

   </code>
      </pre>
         </details>  

      
함수의 반환 유형 앞에 있는 화살표
   
     <details>
  <summary>예시</summary>
  
  <pre>
  <code>
func sum(_ numbers: [Int]) -> Int {
  // ...
}
   </code>
      </pre>
         </details>  
        
        쉼표
        
             <details>
  <summary>예시</summary>
  
  <pre>
  <code>
let numbers = [1, 2, 3]

   </code>
      </pre>
         </details>  
        
        
        
* * *

