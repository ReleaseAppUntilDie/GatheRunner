GatheRunner Swift Style Guide 
=============

# 목적
스타일 가이드를 준수해야하는 이유:

인지 부하(cognitive load)는 학습이나 과제 해결 과정에서의 인지적 요구량을 말한다. 
어떤 정보가 학습되기 위해서는 작동기억 안에서 정보가 처리되어야 하는데, 작동기억이 처리해 낼 수 있는 정보의 양보다 처리해야 할 정보가 많으면 문제가 생기며 인지부하가 생기게 된다.

+ 코드의 가독성은 이해를 돕는다.
+ 유지보수가 용이해진다.
+ 자잘한 실수가 줄어든다.   

## 목차

[1.네이밍](#네이밍)
   + [대소문자](#대소문자)
   + [프로토콜](#함수)
   + [함수](#함수)
   + [유형추론](#유형추론)  
 
[2.코드레이아웃](#코드레이아웃)
   + [글자수제한](#글자수제한)
   + [줄바꿈](#줄바꿈)
   + [수평정렬](#수평정렬)
   + [주석](#주석)


[참고문헌](#참고문헌)

## 네이밍    

### 대소문자

  + 타입 및 프로토콜의 이름에는 UpperCamelCase 사용하고, 그 외 변수,함수등 다른 모든 이름에는 lowerCamelCase를 사용한다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>

     protocol SpaceThing {
     // ...
   }

   class SpaceFleet: SpaceThing {

     enum Formation {
       // ...
     }

     class Spaceship {
       // ...
     }

     var ships: [Spaceship] = []
     static let worldName: String = "Earth"

     func addShip(_ ship: Spaceship) {
       // ...
     }
   }

let myFleet = SpaceFleet()


  </code>
  </pre>
  </details>
  
  ### 프로토콜
  
  + 기능 을 설명하는 프로토콜 은 접미사 able, ible, 또는ing (예: Equatable, ProgressReporting)를 사용하여 이름을 지정해야 한다.
  
  ### 함수 
  
  + 이벤트 처리 함수의 이름은 과거형 문장처럼 지정해야 한다.
  
  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED
   class ExperiencesViewController {

     private func handleBookButtonTap() {
       // ...
     }

     private func modelChanged() {
       // ...
     }
   }

    // PREFERRED
   class ExperiencesViewController {

     private func didTapBookButton() {
       // ...
     }

     private func modelDidChange() {
       // ...
     }
}

  </code>
  </pre>
  </details>
  
  + 사용 사이트가 문법적 영어 구문을 형성하도록 하는 메서드 및 기능 이름을 선호.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   x.insert(y, position: z)
   x.subViews(color: y)
   x.nounCapitalize()


   // PREFERRED
 
   x.insert(y, at: z)          “x, insert y at z”
   x.subViews(havingColor: y)  “x's subviews having color y”
   x.capitalizingNouns()       “x, capitalizing nouns”

  </code>
  </pre>
  </details>
  
  
  ### 유형추론
  
  + 컴파일러 추론 컨텍스트를 사용하여 더 짧고 명확한 코드를 작성한다.
  
  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   view.backgroundColor = UIColor.red
   let toView = context.view(forKey: UITransitionContextViewKey.to)
   let view = UIView(frame: CGRect.zero)


   // PREFERRED
 
   view.backgroundColor = .red
   let toView = context.view(forKey: .to)
   let view = UIView(frame: .zero)

  </code>
  </pre>
  </details>
  
 ## 코드레이아웃    

   ### 글자수제한
   
   + 한 줄은 최대 100자를 넘지 않는다.
   
   Xcode의 Preferences → Text Editing → Display의 'Page guide at column' 옵션을 활성화하고 99자로 설정
  
   ### 줄바꿈
   
   + 연속적인 공백을 하나의 빈 줄이나 공백으로 제한한다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   struct Planet {

     let mass:          Double
     let hasAtmosphere: Bool


     func distance(to: Planet) { }

   }

   // PREFERRED
 
   struct Planet {

     let mass: Double
     let hasAtmosphere: Bool

     func distance(to: Planet) { }

   }

  </code>
  </pre>
  </details>
   
   + 여러 줄에 걸쳐 있는 범위를 포함하는 선언은 같은 범위에 있는 인접한 선언과 줄 바꿈으로 구분한다.
   범위가 지정된 선언을 동일한 범위에 있는 다른 선언과 분리하면 시각적으로 구분되므로 인접한 선언을 범위가 지정된 선언과 쉽게 구분할 수 있다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

struct SolarSystem {
  var numberOfPlanets: Int {
    …
  }
  func distance(to: SolarSystem) -> AstronomicalUnit {
    …
  }
}
struct Galaxy {
  func distance(to: Galaxy) -> AstronomicalUnit {
    …
  }
  func contains(_ solarSystem: SolarSystem) -> Bool {
    …
  }
}

   // PREFERRED
 
struct SolarSystem {
  var numberOfPlanets: Int {
    …
  }

  func distance(to: SolarSystem) -> AstronomicalUnit {
    …
  }
}

struct Galaxy {
  func distance(to: Galaxy) -> AstronomicalUnit {
    …
  }

  func contains(_ solarSystem: SolarSystem) -> Bool {
    …
  }
}

  </code>
  </pre>
  </details>
  
  + 선택적으로 빈 줄을 포함할 수 있는 유형 본문을 제외하고 범위의 상단과 하단에서 빈 줄을 제거한다.
   범위가 지정된 선언을 동일한 범위에 있는 다른 선언과 분리하면 시각적으로 구분되므로 인접한 선언을 범위가 지정된 선언과 쉽게 구분할 수 있다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

class Planet {
  func terraform() {

    generateAtmosphere()
    generateOceans()

  }
}

   // PREFERRED
 
class Planet {
  func terraform() {
    generateAtmosphere()
    generateOceans()
  } 
}

class Planet {

  func terraform() {
    generateAtmosphere()
    generateOceans()
  }

}

  </code>
  </pre>
  </details>
  
  + 다른 종류의 속성 선언 사이에 빈 줄을 추가한다.
   범위가 지정된 선언을 동일한 범위에 있는 다른 선언과 분리하면 시각적으로 구분되므로 인접한 선언을 범위가 지정된 선언과 쉽게 구분할 수 있다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   static let gravityEarth: CGFloat = 9.8
   static let gravityMoon: CGFloat = 1.6
   var gravity: CGFloat

   // PREFERRED
 
   static let gravityEarth: CGFloat = 9.8
   static let gravityMoon: CGFloat = 1.6

   var gravity: CGFloat

  </code>
  </pre>
  </details>

   + 다른 종류의 속성 선언 사이에 빈 줄을 추가한다.
   범위가 지정된 선언을 동일한 범위에 있는 다른 선언과 분리하면 시각적으로 구분되므로 인접한 선언을 범위가 지정된 선언과 쉽게 구분할 수 있다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   static let gravityEarth: CGFloat = 9.8
   static let gravityMoon: CGFloat = 1.6
   var gravity: CGFloat

   // PREFERRED
 
   static let gravityEarth: CGFloat = 9.8
   static let gravityMoon: CGFloat = 1.6

   var gravity: CGFloat

  </code>
  </pre>
  </details>

   + 한 줄에 하나의 명령문
   한 줄 에 최대 하나의 명령문 이 있으며 각 명령문 뒤에는 줄 바꿈을 한다.
   
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
   
   var someProperty: Int { return otherObject.somethingElse() }
  
  </code>
  </pre>
  </details>

### 수평정렬

   + 콜론(:)을 쓸 때에는 콜론의 오른쪽에만 공백을 추가한다.(삼항연산자 제외)

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   struct HashTable : Collection {
     // ...
   }

   struct AnyEquatable<Wrapped : Equatable> : Equatable {
     // ...
   }
   
   let tuple: (x:Int, y:Int)
   let tuple: (x : Int, y : Int)

   func sum(_ numbers:[Int]) {
     // ...
   }

   func sum(_ numbers : [Int]) {
     // ...
   }

   // PREFERRED
 
   struct HashTable: Collection {
     // ...
   }

   struct AnyEquatable<Wrapped: Equatable>: Equatable {
     // ...
   }
   
   let tuple: (x: Int, y: Int)

   func sum(_ numbers: [Int]) {
     // ...
   }

  </code>
  </pre>
  </details>
  
   + 매개변수 또는 배열의 쉼표 뒤는 한칸 띄어쓴다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   let numbers = [1,2,3]
   let numbers = [1 ,2 ,3]
   let numbers = [1 , 2 , 3]

   // PREFERRED
 
   let numbers = [1, 2, 3]

  </code>
  </pre>
  </details>

   + 배열의 괄호외부는 띄어주고, 내부는 띄어주지 않는다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   let numbers = [ 1, 2, 3 ]

   // PREFERRED
 
   let numbers = [1, 2, 3]

  </code>
  </pre>
  </details>
  
  + 괄호의 앞뒤에는 항상 한칸의 공백을 둔다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   let nonNegativeCubes = numbers.map{$0 * $0 * $0}.filter{$0 >= 0}

   // PREFERRED
 
   let nonNegativeCubes = numbers.map { $0 * $0 * $0 }.filter { $0 >= 0 }

  </code>
  </pre>
  </details>

  + 함수의 반환 유형을 나타내는 화살표 역시 앞뒤로 공백을 둔다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   func sum(_ numbers: [Int])->Int {
     // ...
   }
   // PREFERRED
 
   func sum(_ numbers: [Int]) -> Int {
     // ...
   }
  </code>
  </pre>
  </details>
  
  +범위 표현식에 사용되는 ..<또는 연산자 의 양쪽에는 공백을 두지 않는다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   for number in 1 ... 5 {
     // ...
   }

   let substring = string[index ..< string.endIndex]

   // PREFERRED
 
   for number in 1...5 {
     // ...
   }

   let substring = string[index..<string.endIndex]

  </code>
  </pre>
  </details>
   
   + 중위 연산자는 양쪽에 공백이 하나씩 있어야 한다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   let capacity = 1+2
   let capacity = currentCapacity   ?? 0
   let mask = (UIAccessibilityTraitButton|UIAccessibilityTraitSelected)
   let capacity=newCapacity
   let latitude = region.center.latitude - region.span.latitudeDelta/2.0

   // PREFERRED
 
   let capacity = 1 + 2
   let capacity = currentCapacity ?? 0
   let mask = (UIAccessibilityTraitButton | UIAccessibilityTraitSelected)
   let capacity = newCapacity
   let latitude = region.center.latitude - (region.span.latitudeDelta / 2.0)

  </code>
  </pre>
  </details>
   
   ### 주석
