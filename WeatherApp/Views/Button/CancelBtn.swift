import SwiftUI

struct CancelBtn: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button{
            withAnimation{
                self.presentationMode.wrappedValue.dismiss()
            }
        }label: {
            Text("Cancel")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 60, height: 60)
        }
    }
}


