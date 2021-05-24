//
//  NotificationPermission.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import SwiftUI

struct NotificationPermission: View {
    let alertWidth = UIScreen.main.bounds.width * 0.65
    var alertHeight: CGFloat { alertWidth * 1 }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 20)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                       Text("Permission Request")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        Text("Needs Permission")
                         .font(.headline)
                    }
                    Spacer()

                    Button(action: {
                        
                    }
                    , label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    })
                }
                .padding([.horizontal, .top])

                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Notifications")
                            .font(.subheadline)
                            .bold()
                        
                        Text("Allow to notify you on billing date")
                            .font(.system(size: 9, weight: .light))
                         .foregroundColor(.gray)
                    }
                    Spacer()

                }
                .padding()
                Button(action: {
                    
                }
                , label: {
                    Text("ALLOW")
                        .font(.system(size: 9, weight: .bold))
                })
                .frame(width: alertWidth * 0.7, height: 30)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20)
                                Spacer()

                Divider()
                Text("Notification permission is necessary to allow the app to notify about billings of subscriptions you wish to track")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                Spacer()

            }
            .frame(width:  alertWidth, height: alertHeight)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPermission()
    }
}
