//
//  ActivityModel.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 29.01.2022.
//

import Foundation


struct ActivityTableCellModel: Identifiable {
    let id: UUID
    let distance: String
    let duration: String
    let type: String
    let startDate: Date
    let endDate: Date
}

struct ActivitiesTableModel: Identifiable {
    let id: UUID
    let date: Date
    let activities: [ActivityTableCellModel]
}

func timeAgo(date: Date) -> String {
        return date.timeAgoDisplay()
    }
func startTime(date: Date) -> String {
        return date.clockDisplay()
    }
func stopTime(date: Date) -> String {
        return date.clockDisplay()
    }
