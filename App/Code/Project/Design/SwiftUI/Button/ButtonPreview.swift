import SwiftUI

struct ButtonPreview: View {
    var body: some View {
        ZStack {
            Color
                .brandPrimary
                .edgesIgnoringSafeArea(.all)
            VStack {
                Group {
                    Button(
                        action: { print("Tapped") },
                        label: {
                            Text("Primary")
                    })
                    .buttonStyle(ButtonPrimaryStyle())
                    
                    Button(
                        action: { print("Tapped") },
                        label: {
                            Text("Secondary")
                    })
                    .buttonStyle(ButtonSecondaryStyle())
                }
                
                Group {
                    Button(
                        action: { print("Tapped") },
                        label: {
                            Text("Action")
                    })
                    .buttonStyle(ButtonActionStyle())
                }
                
                Group {
                    Button(
                        action: { print("Tapped") },
                        label: {
                            Text("Round")
                    })
                    .buttonStyle(ButtonRoundStyle())
                }
                
            }
        }
    }
    
}

#if DEBUG
struct ButtonPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonPreview()
                .environment(\.colorScheme, .light)
            
            ButtonPreview()
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
