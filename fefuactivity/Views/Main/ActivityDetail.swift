//
//  ActivityDetail.swift
//  fefuactivity
//
//  Created by Roman Esin on 25.01.2022.
//

import SwiftUI

struct ActivityDetail: View {
    let item: Activity
    @State private var comment = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(item.distance)
                    .font(.system(size: 24))
                    .bold()
                Text(item.startDate)
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
                    Text(item.startDate)
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
        ActivityDetail(item: Activity.init(distance: "123 km", duration: "30 min", type: "Велосипед", startDate: "12.01.2022"))
    }
}
