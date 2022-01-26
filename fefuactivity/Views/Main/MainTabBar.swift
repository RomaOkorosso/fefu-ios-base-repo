//
//  MainTabBar.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 13.01.2022.
//

import SwiftUI

struct MainTabBar: View {
    var body: some View {
        TabView {
            ActivityTab()
                .tag(0)
                .tabItem {
                    Label("Активности", systemImage: "list.dash")
                }
            Text(verbatim: "Тут будет профиль")
                .tag(1)
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
        }
        .navigationBarHidden(true)
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
    }
}
