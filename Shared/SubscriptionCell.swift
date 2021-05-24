//
//  SubscriptionCell.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 23.05.21.
//

import SwiftUI

struct SubscriptionCell: View {
    var content: Subscription
    var body: some View {
        let color = Color(hex: content.color ?? "FF0000")

        HStack {
            Image(content.icon!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            VStack(alignment: .leading){
                Text(content.name)
                    .foregroundColor(.white)
                    .font(.subheadline)

                if let detail = content.detail {
                    Text(detail)
                        .foregroundColor(.white)
                        .font(.caption2)
                }
            }
            Spacer()

            VStack(alignment: .trailing) {
                if let amount = content.amount, let currency = Currency(rawValue: content.currency) {
                    let price = "\(currency) \(amount)"
                    Text(price)
                        .foregroundColor(.white)
                }
                Text("Today")
                    .foregroundColor(.white)
                    .font(.caption2)
            }
            .padding(.trailing)
        }
        .frame(height: 60)
        .background(color)
        
    }
}

struct SubscriptionCell_Previews: PreviewProvider {
    
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let sub = Subscription(context: context)
        sub.name = "Apple Arcade"
        sub.icon = "apple_logo"
        sub.amount = 7.99
        sub.currency = 0
        sub.color = UIColor.red.hexStringFromColor()
   
        return SubscriptionCell(content: sub)
    }
}
