//
//  View+ToVc.swift
//  GatheRunnerTests
//
//  Created by 김동현 on 2022/10/07.
//

import SwiftUI

extension View {
    public var toVC: UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
