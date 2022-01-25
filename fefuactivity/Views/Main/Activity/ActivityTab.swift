//
//  ActivityView.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 13.01.2022.
//

import SwiftUI

struct Activity: Identifiable {
    let id = UUID()
    let distance: String
    let duration: String
    let type: String
    let startDate: String
    // let comment: String?
}

struct ActivityView: View {

    let activity: Activity

    var body: some View {
        VStack(alignment: .leading) {
            Text(activity.distance)
                .font(.title.bold())
            Text(activity.duration)

            HStack {
                HStack {
                    ZStack {
                        Circle()
                            .foregroundColor(.blue)

                        Image(systemName: "bicycle")
                            .resizable()
                            .aspectRatio(nil, contentMode: .fit)
                            .foregroundColor(.white)
                            .padding(2)
                    }
                    .frame(width: 15, height: 15)

                    Text("Велосипед")
                }

                Spacer()

                Text(activity.startDate)
            }
        }
    }
}

struct ActivityTab: View {

    var activities1: [Activity] = [
        .init(distance: "11 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "13 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "100 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
    ]

    var activities2: [Activity] = [
        .init(distance: "12 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "0.1 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "15 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "30 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "31 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
        .init(distance: "2 km", duration: "11 min", type: "Велосипед", startDate: "14 часов назад"),
    ]

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if activities1.isEmpty && activities2.isEmpty {
                    VStack(spacing: 12) {
                        if #available(iOS 14.0, *) {
                            Text("Время потренить")
                                .font(.title3.bold())
                        } else {
                            // Fallback on earlier versions
                        }
                        Text("Нажимай на кнопку ниже и начинаем трекать активность")
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                } else {
                    List {
                        Section(header: Text("Вчера").foregroundColor(.black)) {
                            ForEach(activities1) { activity in
                                NavigationLink(destination: ActivityDetail(item: activity)) {
                                    ActivityView(activity: activity)
                                }

                            }
                        }

                        Section(header: Text("Май 2022 года").foregroundColor(.black)) {
                            ForEach(activities2) { activity in
                                NavigationLink(destination: ActivityDetail(item: activity)) {
                                    ActivityView(activity: activity)
                                }
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }

                if !activities1.isEmpty && !activities2.isEmpty {
                    Button {
                        startActivity()
                    } label: {
                        Text("Старт")
                            .padding(.vertical, 16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 20)
                }
            }
//            .padding(.bottom, 64)
            .navigationTitle("Активности")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func startActivity() {

    }
}


struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTab()
    }
}
