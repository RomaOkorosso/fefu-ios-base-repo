//
//  MainTabBar.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 13.01.2022.
//

import SwiftUI

struct MainTabBar: View {

    @State var currentTab = Tab.activities

    enum Tab: String {
        case activities = "Активности"
        case profile = "Профиль"
    }

    var body: some View {
        // Hack to hide tabbar in child view
        NavigationView {
            TabView(selection: $currentTab) {
                ActivityTab()
                    .tabItem {
                        Label("Активности", systemImage: "list.dash")
                    }
                    .tag(Tab.activities)
                
                Text(verbatim: "Тут будет профиль")
                    .tabItem {
                        Label("Профиль", systemImage: "person.fill")
                    }
                    .tag(Tab.profile)
            }
            .navigationBarTitle(self.currentTab.rawValue)
        }
        .navigationBarHidden(true)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
    }
}
