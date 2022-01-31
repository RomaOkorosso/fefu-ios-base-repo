//
//  ActivityView.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 13.01.2022.
//

import SwiftUI
import CoreData
import Foundation

struct Activity: Identifiable {
    let id = UUID()
    let distance: String
    let duration: String
    let type: String
    let startDate: Date
    let endDate: Date
    // let comment: String?
}

struct ActivityView: View {

    let activity: ActivityTableCellModel

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

//                Text(DateComponentsFormatter().string(from: Calendar.current.dateComponents([.day, .month, .year], from: activity.startDate)))
                Text(formatStringDate(date: activity.startDate))
            }
        }
    }
}

func getCurrDate() -> Date {
    return Calendar.current.dateComponents([.day, .month, .year], from: Date()).date ?? Date()
}

struct ActivityTab: View, ActivityRecorderDelegate {

    @State private var tableData: [ActivitiesTableModel] = fetchLocalActivities()

    internal var body: some View {

        ZStack(alignment: .bottom) {
            if tableData.isEmpty {
                VStack(spacing: 12) {
                    Text("Время потренить")
                        .font(.title3.bold())
                    Text("Нажимай на кнопку ниже и начинаем трекать активность")
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
            } else {
                List {
                    ForEach(tableData) { section in
                        Section(header: Text(section.date.callendarDisplay())) {
                            ForEach(section.activities) { activity in
                                NavigationLink(destination: ActivityDetail(item: activity)) {
                                    ActivityView(activity: activity)
                                }
                            }
                        }
                    }

                }
                .listStyle(.insetGrouped)
            }

            NavigationLink(destination: ActivityRecorderView(delegate: self)) {
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
        .navigationTitle("Активности")
        .navigationBarTitleDisplayMode(.inline)
    }

    func startActivity() {

    }

    func activityDidCreate() {
        print("delegate works")
        tableData = fetchLocalActivities()
    }

}


struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityTab()
    }
}

private func fetchLocalActivities() -> [ActivitiesTableModel] {
        let context = FEFUCoreDataContainer.instance.context
        let request = CDActivity.fetchRequest()

        do {
            let rawActivities = try context.fetch(request)
            let activities: [ActivityTableCellModel] = rawActivities.map { activity in
                return ActivityTableCellModel(id: activity.id,
                                              distance: activity.distance,
                                              duration: activity.duration,
                                              type: activity.type,
                                              startDate: activity.startDate,
                                              endDate: activity.endDate)
            }
            let sortedActivities = activities.sorted { $0.startDate > $1.startDate }
            let grouppedActivities = Dictionary(grouping: sortedActivities, by: { $0.startDate.callendarDate() }).sorted(by: {
                $0.key > $1.key
            })
            return grouppedActivities.map { (date, activities) in
                return .init(id: UUID(), date: date, activities: activities)
            }
        } catch {
            print(error)
            return []
        }
    }

