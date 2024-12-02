//
//  07Transition.swift
//  SwiftUILearn
//
//  Created by Harlans on 2024/12/2.
//

import SwiftUI

struct CustomizedTransition: Transition {
    func body(content: Content, phase: TransitionPhase) -> some View {
        content
            .rotationEffect(Angle(degrees: phase.isIdentity ? 360 : 0))
            .scaleEffect(phase.isIdentity ? 1 : 0)
    }
}

struct CustomTransition: Transition {
    
    var index: Int
    var frameWidth: CGFloat
    var numberOfElements: Int
    
    func body(content: Content, phase: TransitionPhase) -> some View {
        
        let offsetValue: CGFloat = calculateOffset(index: index, frameWidth: frameWidth, phase: phase)
        
        return content
        // 2. The Opacity effect
            .opacity(phase.isIdentity ? 1 : phase == .didDisappear ? 0 : 0.2)
        
        // 3. The Rotation effect
            .rotationEffect(.degrees(phase.isIdentity ? 360*3 : 0))
        
        // 4. The Offset effect with an offset value not yet declared
            .offset(x: offsetValue)
    }
    
    // 1. The function to calculate the offset value
    private func calculateOffset(index: Int, frameWidth: CGFloat, phase: TransitionPhase) -> CGFloat {
        
        // The button frame width
        let buttonFrameWidth: CGFloat = 40.0
        
        // Spacing available in the frame containing the buttons
        let totalSpacing: CGFloat = frameWidth - buttonFrameWidth
        
        // 2. Spacing to distribute between the buttons
        let spacingPerCircle = totalSpacing / CGFloat(numberOfElements - 1)
        
        // 3. The offset to calculate
        var offSet: CGFloat
        
        // a. Not supposed to move when it's in the first position
        if index == 0 {
            offSet = 0
        } else {
            // b. Fully visible
            if phase.isIdentity {
                offSet = CGFloat(index) * spacingPerCircle
                // c. About to disappear or appear
            } else {
                offSet = CGFloat(index) * phase.value
            }
        }
        
        return offSet
    }
    
}

struct CircleButton: Identifiable {
    let id = UUID()
    let symbol: String
    let color: Color
    let action: () -> Void
}

struct MiView : View {
    var body: some View {
        Image(systemName: "doc.on.doc")
            .font(.system(size: 50))
    }
}

struct CircleButtonView: View {
    var button: CircleButton
    var body: some View {
        ZStack {
            Circle()
                .fill(button.color)
                .overlay{
                    Image(systemName:button.symbol)
                        .foregroundColor(.white)
                        .bold()
                }
        }
        .frame(width: 40)
        .shadow(color: .gray.opacity(0.5), radius: 2.0,x: 1.0, y: 1.0 )
    }
}

struct CustomTransitionView: View {

    @State var isOpen: Bool = false
    
    let buttons: [CircleButton] = [
        CircleButton(symbol: "heart.fill", color: .pink, action: { print("heart") }),
        CircleButton(symbol: "bookmark.fill", color: .purple, action: { print("bookmark") }),
        CircleButton(symbol: "moon.fill", color: .yellow, action: { print("moon") }),
        CircleButton(symbol: "message.fill", color: .blue, action: { print("message") }),
        CircleButton(symbol: "plus", color: .teal, action: { }),
    ]
    
    // The width of the frame of the container of all the views transitioning
    var frameWidth: CGFloat = UIScreen.main.bounds.width * 4/5
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    
                    ForEach(0..<buttons.count, id: \.self) { index in
                        if isOpen && (index != buttons.count - 1) {
                            CircleButtonView(button:  buttons[index])
                                // 1. Defines the custom transition for each button
                                .transition(CustomTransition(
                                    index: index,
                                    frameWidth: frameWidth,
                                    numberOfElements: buttons.count
                                ))
                                .onTapGesture {
                                    buttons[index].action()
                                }
                        }
                    }
                    
                }
                .frame(width: frameWidth, alignment: .leading)
                
                // Opening Button
                HStack {
                    if isOpen {
                        Spacer()
                    }
                    
                    CircleButtonView(button: buttons.last!)
                        .rotationEffect(.degrees(isOpen ? 405.0*3 : 0))
                        .onTapGesture {
                            isOpen.toggle()
                        }
                }
                .frame(maxWidth: frameWidth, alignment: .leading)
            }
        }
        .frame(maxWidth: frameWidth, alignment: .leading)
        
        // 2. Regulates the duration and the animation
        .animation(.spring(duration: 1.8), value: isOpen)
    }
    
}

struct _7Transition: View {
    @State private var isOpen = false
    
    var body: some View {
        VStack {
            Spacer() // 添加顶部空间
            
            if isOpen {
                MiView()
//                    .transition(.scale .combined(with: .slide))
//                    .transition(
//                        CustomizedTransition()
//                            .animation(.easeInOut(duration: 0.8))
//                    )
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading),  // 从左边进入
                        removal: .move(edge: .leading)    // 从右边退出
                    ))
                    .zIndex(1)  // 确保 View 在最上层，如果需要的话。
            }
            
            Spacer() // 添加中间空间
            
            Button("Toggle") {
                withAnimation {
                    isOpen.toggle()
                }
            }
            .padding(.bottom) // 可选：添加底部间距
        }
    }
}


#Preview {
//    _7Transition()
    CustomTransitionView()
}
