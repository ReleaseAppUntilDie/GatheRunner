GatheRunner Swift Style Guide 
=============

# 목적
스타일 가이드를 준수해야하는 이유:

+ 코드의 가독성은 이해를 돕는다.
+ 유지보수가 용이해진다.
+ 자잘한 실수가 줄어든다.  
+ 코딩하는 동안 인지 부하를 줄인다. 

인지 부하(cognitive load)는 학습이나 과제 해결 과정에서의 인지적 요구량을 말한다. 
어떤 정보가 학습되기 위해서는 작동기억 안에서 정보가 처리되어야 하는데, 작동기억이 처리해 낼 수 있는 정보의 양보다 처리해야 할 정보가 많으면 문제가 생기며 인지부하가 생기게 된다.

행동 경제학에 따르면, 과잉 선택권은 선택할 수 있는 옵션이 너무 많아서 뇌가 결정하기 어려울 때 발생한다. 결과적으로, 뇌는 결정을 내리지 못하고 그에 대해 스트레스를 받게 된다.

## 목차

[0.폴더구조](#폴더구조)

[1.네이밍](#네이밍)
   + [대소문자](#대소문자)
   + [프로토콜](#함수)
   + [함수](#함수)
   + [유형추론](#유형추론)
   + [명확성](#명확성)  
   + [부울](#부울)
   + [약어](#약어)  
   
[2.코드레이아웃](#코드레이아웃)
   + [글자수제한](#글자수제한)
   + [줄바꿈](#줄바꿈)
   + [수평정렬](#수평정렬)
   + [주석](#주석)
   + [배치순서](#배치순서)

[3.클로저](#클로저)
   + [선언](#선언)
   + [매개변수미사용](#매개변수미사용)
   + [표현식](#표현식)
   
   
[4.Guard](#Guard)

[5.import](#import)

[6.enum](#enum)

[7.기타](#기타)
 + [완화](#완화)


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
  
   ### 명확성
  
  + 모호성을 피하기 위해 필요한 모든 단어를 포함한다.
  
  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   employees.remove(x) // x위치에 있는 요소삭제라는 기능과 달리 x라는 요소를 삭제하는 의도로 보임.


   // PREFERRED
 
   extension List {
     public mutating func remove(at position: Index) -> Element
   }
   employees.remove(at: x)

  </code>
  </pre>
  </details>
  
  ### 부울
  
  + 부울의 유형은 isSpaceship, hasSpacesuit 등과 같이 네이밍에 속성이 표현되어야 한다.
 
  
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
   
   + 적합성을 구현하는 각 유형 및 확장자 앞에 MARK주석이 있어야 한다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
// MARK: - GalaxyView

final class GalaxyView: UIView { … }

// MARK: ContentConfigurableView

extension GalaxyView: ContentConfigurableView { … }

// MARK: - Galaxy + SpaceThing, NamedObject

extension Galaxy: SpaceThing, NamedObject { … }

  </code>
  </pre>
  </details>

   + // 주석 앞으로 두 칸, 뒤로 한 칸의 공백을 둔다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   let initialFactor = 2 //    Warm up the modulator.

   // PREFERRED

   let initialFactor = 2  // Warm up the modulator.

  </code>
  </pre>
  </details>
   
   + C언어 스타일인 /* ... */ 주석이 아닌, // // 을 사용한다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // NOT PREFERRED

   /**
   * A planet that exists somewhere in the universe.
   *
   * Planets have many properties. For example, the best planets
   * have atmospheres and bodies of water to support life.
   */
   class Planet {
     /**
       Terraforms the planet, by adding an atmosphere and ocean that is hospitable for life.
     */
     func terraform() {
       /* 
       Generate the atmosphere first, before generating the ocean.
       Otherwise, the water will just boil off immediately.
       */
       generateAtmosphere()

       /* Now that we have an atmosphere, it's safe to generate the ocean */
       generateOceans()
     }
   }
   
   struct Spaceship {

     func travelFasterThanLight() {/*unimplemented*/}

     func travelBackInTime() { }//TODO: research whether or not this is possible

   }
   

   // PREFERRED

   /// A planet that exists somewhere in the universe.
   ///
   /// Planets have many properties. For example, the best planets
   /// have atmospheres and bodies of water to support life.
   class Planet {
     /// Terraforms the planet, by adding an atmosphere and ocean that is hospitable for life.
     func terraform() {
       // Generate the atmosphere first, before generating the ocean.
       // Otherwise, the water will just boil off immediately.
       generateAtmosphere()

       // Now that we have an atmosphere, it's safe to generate the ocean
       generateOceans()
     }
   }
   
   struct Spaceship {

     func travelFasterThanLight() { /* unimplemented */ }

     func travelBackInTime() { } // TODO: research whether or not this is possible

   }

  </code>
  </pre>
  </details>
   
   + MARK 구문 위와 아래에는 공백 둔다.

  <details>
  <summary>예시</summary>
  <pre>
  <code>
  
   // MARK: Layout

   override func layoutSubviews() {
     // doSomething()
   }

   // MARK: Actions

   override func menuButtonDidTap() {
     // doSomething()
   }

  </code>
  </pre>
  </details>

   ## 클로저    

   ### 선언
   
  + 클로저 선언에서 반환 유형을 명시한다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   func method(completion: () -> ()) {
     ...
   }
   
   // PREFERRED

   func method(completion: () -> Void) {
     ...
   }

  </code>
  </pre>
  </details>
   
   ### 매개변수미사용
   
  + 사용하지 않는 클로저 매개변수의 이름을 밑줄(_)로 지정한다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   someAsyncThing() { argument1, argument2, argument3 in
     print(argument3)
   }

   // PREFERRED

   someAsyncThing() { _, _, argument3 in
     print(argument3)
   }


  </code>
  </pre>
  </details>
 
   ### 표현식
   
  + 클로저 표현식에서 반환 유형을 생략한다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   someAsyncThing() { argument -> Void in
     ...
   }

   // PREFERRED
   someAsyncThing() { argument in
     ...
   }

  </code>
  </pre>
  </details>
  
   ## Guard
   
   + 코드의 가독성을 향상시기 위해, 명령문 대신 종종 사용할 것     

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED
   
   func eatDoughnut(at index: Int) {
       if index >= 0 && index < doughnuts.count {
           let doughnut = doughnuts[index]
           eat(doughnut)
       }
   }
   
   if let monkeyIsland = monkeyIsland {
       bookVacation(on: monkeyIsland)
       bragAboutVacation(at: monkeyIsland)
   }

   // PREFERRED
   
   func eatDoughnut(at index: Int) {
       guard index >= 0 && index < doughnuts.count else {
           // return early because the index is out of bounds
           return
       }

       let doughnut = doughnuts[index]
       eat(doughnut)
   }

   guard let monkeyIsland = monkeyIsland else {
       return
   }
   bookVacation(on: monkeyIsland)
   bragAboutVacation(at: monkeyIsland)

  </code>
  </pre>
  </details>

   + if-else문을 대체하진 말 것    

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED
   
   guard isFriendly else {
       print("You have the manners of a beggar.")
       return
   }

   print("Hello, nice to meet you!")

   // PREFERRED
   
   if isFriendly {
       print("Hello, nice to meet you!")
   } else {
       print("You have the manners of a beggar.")
   }

  </code>
  </pre>
  </details>
   
   + 반드시 return에 줄바꿈 할 것

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED
   
   guard let thingOne = thingOne else { return }
   
   // PREFERRED
   
   guard let thingOne = thingOne else {
       return
   }

  </code>
  </pre>
  </details>
  
  ## import
  
  + 소스 파일에 필요한 모듈만 가져온다.      

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   import UIKit
   import Foundation
   var view: UIView
   var deviceModels: [String]
   
   // PREFERRED
   
   import UIKit
   var view: UIView
   var deviceModels: [String]
   
   // NOT PREFERRED

   import UIKit
   var deviceModels: [String]

   
   // PREFERRED
   
   import Foundation
   var deviceModels: [String]


  </code>
  </pre>
  </details>
  
  + 헤더 주석 아래에 배치하고, 알파벳순으로 정렬하고, import 사이에 줄바꿈 하지않고, import 시작과 끝에 한칸씩 줄바꿈 해준다.    

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   //  Copyright © 2018 Airbnb. All rights reserved.
   //
   import DLSPrimitives
   import Constellation
   import Constellation
   import Epoxy

   import Foundation

   // PREFERRED
   
   //  Copyright © 2018 Airbnb. All rights reserved.
   //

   import Constellation
   import DLSPrimitives
   import Epoxy
   import Foundation

  </code>
  </pre>
  </details>
  
  ## enum    
   
  + 유형 간의 범위 및 계층 관계를 표현하기 위해 중첩타입으로 사용할 것.    

  <details>
  <summary>예시</summary>
  <pre>
  <code>

   // NOT PREFERRED

   class Parser {
     func parse(text: String) throws {
       // ...
     }
   }

   enum ParseError: Error {
     case invalidToken(String)
     case unexpectedEOF
   }
   
   // PREFERRED
   
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
   
 ## 참고문헌
   
   + 공식문서: https://www.swift.org/documentation/api-design-guidelines
   + 구글 스타일가이드: https://google.github.io/swift/#non-documentation-comments
   + 에어비앤비 스타일가이드: https://github.com/airbnb/swift#file-organization
   + 스타일쉐어 스타일가이드: https://github.com/StyleShare/swift-style-guide
   + 링크드인 스타일가이드: https://github.com/linkedin/swift-style-guide
   + raywenderlich 스타일가이드: https://github.com/raywenderlich/swift-style-guide
   
