//
//  4Stack.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/7/27.
//

import SwiftUI

struct _Stack: View {
    var body: some View {
        VStack {
            HeaderView()
            _ContentView()
            FooterView()
            Spacer()
        }
    }
}

#Preview {
    _Stack()
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("Choose")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
                Text("Your Plan")
                    .font(.system(.largeTitle, design: .rounded))
                    .fontWeight(.black)
            }
            Spacer()
        }
        .padding()
    }
}

struct PricingView: View {
    var title: String
    var price: String
    var textColor: Color
    var bgColor: Color
    
    var icon: String?
    
    
    var body: some View {
        VStack {
            if let icon = icon {
                Image(icon)
                    .font(.largeTitle)
                    .foregroundColor(textColor)
            }
            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(textColor)
            Text(price)
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundColor(textColor)
            Text("per month")
                .font(.headline)
                .foregroundColor(textColor)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 100)
        .padding(40)
        .background(bgColor)
        .cornerRadius(10)
    }
}

struct _ContentView: View {
    var body: some View {
        HStack(spacing: 15) {
            PricingView(title: "Basic", price: "$9", textColor: .white, bgColor: .purple)
            ZStack {
                PricingView(title: "Pro", price: "$19", textColor: .black, bgColor: Color(red: 240/255, green: 240/255, blue: 240/255))
                Text("Best for designer")
                    .font(.system(.caption, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                    .offset(x: 0, y: 84)
                
            }
        }
        .padding(.horizontal)
    }
}

struct FooterView: View {
    var body: some View {
        ZStack {
            PricingView(title: "Team", price: "$299", textColor: .white, bgColor:  Color(red: 62/255, green: 63/255, blue: 70/255), icon: "wand.and.rays")
                .padding()
            
            Text("Best for designer")
                .font(.system(.caption, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(5)
                .background(Color(red: 255/255, green: 183/255, blue: 37/255))
                .offset(x: 0, y: 100)
        }
        
    }
}
