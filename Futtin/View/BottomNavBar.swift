import SwiftUI

enum BottomNavTab {
    case map
    case award
    case customize
}

struct BottomNavBar: View {
    var currentTab: BottomNavTab
    @ObservedObject var progressVM: ProgressViewModel
    var onTabSelected: (BottomNavTab) -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // زر الجوائز
                Button(action: {
                    onTabSelected(.award)
                }) {
                    Image(systemName: "rosette")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(currentTab == .award ? Color(hex: "4EB9E6") : Color("TextBar"))
                }
                
                Spacer()
                
                // زر الخريطة
                Button(action: {
                    onTabSelected(.map)
                }) {
                    Image(systemName: "map")
                        .resizable()
                       // .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(currentTab == .map ? Color(hex: "4EB9E6") : Color("TextBar"))
                }
                
                Spacer()
                
                // زر الاستماع
                Button(action: {
                    onTabSelected(.customize)
                }) {
                    Image(systemName: "headphones")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(currentTab == .customize ? Color(hex: "4EB9E6") : Color("TextBar"))
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical, 12)
            //.frame(maxWidth: .infinity) // ✅ هذا يمدد البار
            .background(Color("TabBar"))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}
