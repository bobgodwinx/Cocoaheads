import SwiftUI

struct RootView: View {
    var body: some View {
        HStack {
            VStack {
                Spacer()
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Enter Code")
                HStack {
                    Spacer()
                    TwoFactorTextFieldView()
                    Spacer()
                }
                Spacer()
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.yellow, .green, .blue]),
                    startPoint: .top, endPoint: .bottom
                )
            )
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

struct TwoFactorTextFieldView: View {
    @State private var twoFactorCode = ""
    @State private var isValid = false
    
    var body: some View {
        ZStack {
            TwoFactorTextField(bindable: $twoFactorCode)
                .onChange(of: twoFactorCode, perform: { isValid = $0 == "123456" })
                .frame(width: 245, height: 44)
                .padding(.leading, 30)
            
        }
        .sheet(isPresented: $isValid, content: {
            MainView()
        })
    }
}

struct MainView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("Welcome to SEN Payment Networks")
                Spacer()
            }
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white, .blue, .purple]),
                startPoint: .top, endPoint: .bottom
            )
        )
    }
}
