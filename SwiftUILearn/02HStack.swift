import SwiftUI


struct HStackViewDemo: View {
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "person.crop.circle")
            Text("Hello, World!")
            Spacer()
            Text("SwiftUI")
            Image(systemName: "star")
        }
    }
}

struct HStackViewDemo1: View {
    
    var body: some View {
        HStack(spacing: 20) {
            hello
                .border(.blue)
            Spacer()
            bye
        }
    }
    @ViewBuilder var hello: some View {
        Group {
            Image(systemName: "person.crop.circle")
            Text("Hello, World!")
        }
    }
    
    @ViewBuilder var bye: some View {
        Text("SwiftUI")
        Image(systemName: "star")
    }
}

@Observable final class Model {
    var value = 0
    static let shared = Model()
}
struct HStackViewDemo2: View {
    @State private var model = Model()
    
    var body: some View {
        Button("Increment: \(model.value)") {
            model.value += 1
        }
    }
}
struct Counter: View {
    var model: Model
    var body: some View {
        Button("Increment: \(model.value)") {
            model.value += 1
        }
    }
}
struct HStackViewDemo21: View {
    var body: some View {
        Counter(model: Model.shared)
    }
}

#Preview {
//    HStackViewDemo()
//    HStackViewDemo1()
//    HStackViewDemo2()
    HStackViewDemo21()
}
