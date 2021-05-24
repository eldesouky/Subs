//
//  AverageExpenses.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import SwiftUI

struct AverageExpenses: View {
    var body: some View {
        VStack(spacing: 5) {
            Divider()
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Average Expenses")
                        .bold()
                        .font(.headline)
                    Text("PER YEAR")
                        .foregroundColor(.gray)
                        .bold()
                        .font(.caption2)
                }
                Spacer()
                Text("215,99 €")
                    .font(.callout)
                    .bold()
                    .foregroundColor(.black.opacity(0.6))
            }
            .padding(.top, 5)
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color.white)

        }
    }
}

struct AverageExpenses_Previews: PreviewProvider {
    static var previews: some View {
        AverageExpenses()
    }
}
