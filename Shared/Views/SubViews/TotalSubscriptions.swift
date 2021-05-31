//
//  TotalSubscriptions.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import SwiftUI

struct TotalSubscriptions: View {
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack{
                Text("€ EUR")
                    .font(.footnote)
                Spacer()
                Text("5 subscriptions")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Spacer()
                Text("215,99 €")
                    .font(.footnote)
                    .foregroundColor(.black.opacity(0.6))
            }
            .padding()

        }      
    }
}

struct TotalSubscriptions_Previews: PreviewProvider {
    static var previews: some View {
        TotalSubscriptions()
    }
}
