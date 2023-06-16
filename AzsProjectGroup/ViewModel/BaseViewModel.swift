//
//  BaseViewModel.swift
//  AzsTabBar
//
//  Created by geka231 on 19.12.2022.
//

import SwiftUI

class BaseViewModel: ObservableObject {

    @Published var currentTab: Tab = .Home
}

enum Tab: String{
    case Home = "home"
    case trends = "trends"
    case locat = "locat"
    case Person = "person"
}
