import SwiftUI

struct NotchContainerView: View {
    var body: some View {
        ZStack {
            // Pitch black background matching hardware bezel
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 18,
                bottomTrailingRadius: 18,
                topTrailingRadius: 0
            )
            .fill(Color.black)

            // Temporary placeholder content for testing
            Text("MyNotch Active")
                .foregroundColor(.white)
                .font(.system(size: 12, weight: .semibold))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
