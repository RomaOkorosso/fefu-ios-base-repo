//
//  ActivityDetail.swift
//  fefuactivity
//
//  Created by RomaOkorosso on 25.01.2022.
//

import SwiftUI

struct ActivityDetail: View {
    let item: ActivityTableCellModel
    @State private var comment = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(item.distance)
                    .font(.system(size: 24))
                    .bold()
//                Text(DateComponentsFormatter().string(from: Calendar.current.dateComponents([.day, .month, .year], from: item.startDate))!)
                Text(formatStringDate(date: item.startDate))
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                Text(item.duration)
                    .font(.system(size: 24))
                    .bold()
                    .padding(.top, 16)
                Text("Старт 15:32 - Финиш 18:67")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)

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
                    Text(item.type)
                    Spacer()
//                    Text(DateComponentsFormatter().string(from: Calendar.current.dateComponents([.day, .month, .year], from: item.startDate))!)
                    Text(formatStringDate(date: item.startDate))
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                }
                .padding(.top, 24)

                TextField("Комментарий", text: $comment)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(
                        Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(8)
                .padding(.top, 32)


            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 32)
            .padding(.horizontal, 32)

        }
        .navigationTitle(item.type)
        .toolbar {
            Button {
                print(123)
            } label: {
                Image(systemName: "square.and.arrow.up")
            }

        }
        .navigationBarTitleDisplayMode(.inline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(item: .init(id: UUID(), distance: "123 km", duration: "30 min",
                                           type: "Велосипед", startDate: Date(), endDate: Date()))
    }
}

func formatStringDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMM d, yyyy")
        return dateFormatter.string(from: date)
}
