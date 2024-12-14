import SwiftUI

struct TextPreview: View {
    
    var body: some View {
        ZStack {
            Color
                .brandPrimary
                .edgesIgnoringSafeArea(.all)
            VStack {
                Group {
                    Text.largeTitle("Large Title")
                    Text.title1("Title 1")
                    Text.title2("Title 2")
                    Text.title3("Title 3")
                    Text.headline("Headline")
                    Text.subheadline("Subheadline")
                }
                Group {
                    Text.body("Body")
                    Text.callout("Callout")
                    Text.footnote("Footnote")
                    Text.caption1("Caption 1")
                    Text.caption2("Caption 2")
                }
            }
        }
    }
    
}

#if DEBUG
struct TextPreview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextPreview()
                .environment(\.colorScheme, .light)
            
            TextPreview()
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
