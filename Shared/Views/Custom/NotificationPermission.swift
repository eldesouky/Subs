//
//  NotificationPermission.swift
//  Subs
//
//  Created by Mahmoud Eldesouky on 24.05.21.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct NotificationPermission: View {
    @Binding var presentationMode: Bool
    
    @State var animateBlur: Bool = false
    @State var animateAlertView: Bool = false
    @State var animateBellView: Angle = Angle(degrees: 0)

    let alertWidth = UIScreen.main.bounds.width * 0.7
    var alertHeight: CGFloat { alertWidth * 1.1 }
    
    var body: some View {
        ZStack {
            Blur(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .opacity(animateBlur ? 1 : 0)
            
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
                        presentationMode.toggle()
                    }
                    , label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    })
                }
                .padding()

                Image(systemName: "bell.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue)
                    .rotationEffect(animateBellView)
                HStack {
                   

                    Spacer()

                    VStack(alignment: .center) {
                        Text("Notifications")
                            .font(.subheadline)
                            .bold()
                        
                        Text("Allow to notify you on billing date")
                            .font(.system(size: 9, weight: .light))
                         .foregroundColor(.gray)
                    }
                    Spacer()

                }
                .padding(.bottom)
                Button(action: {
                    
                }
                , label: {
                    Text("ALLOW")
                        .font(.system(size: 9, weight: .bold))
                })
                .frame(width: alertWidth * 0.7, height: 30)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(20)

                Divider()
                Text("Notification permission is necessary to allow the app to notify about billings of subscriptions you wish to track")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 10)


            }
            .frame(width:  alertWidth)
            .background(Color.white)
            .cornerRadius(20)
            .offset(x: animateAlertView ? 0 : 500)
        }
        .onAppear(perform: {
            withAnimation(.easeIn(duration: 0.5)){
                animateBlur.toggle()
            }
            
            withAnimation( .interpolatingSpring(mass: 1, stiffness: 80, damping: 10, initialVelocity: 0)
                            .delay(0.2))
            {
                animateAlertView.toggle()
            }
            
            withAnimation(.easeIn(duration: 0.08).repeatCount(15)){
                if animateBellView.degrees > 0 {
                    animateBellView = Angle(degrees: -20)
                }
                else {
                    animateBellView = Angle(degrees: 20)
                }
            }
            animateBellView = Angle(degrees: 0)
        })
    }
}

struct NotificationPermission_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationPermission(presentationMode: .constant(true))
            NotificationPermission(presentationMode: .constant(true))
                .previewDevice("iPad (8th generation)")
        }
    }
}
