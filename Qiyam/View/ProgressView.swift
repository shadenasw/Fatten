//
//  ProgressViewScreen.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//


import SwiftUI

struct ProgressView: View {
    var body: some View {
        VStack(spacing: 30) {
            
            // الترحيب
            VStack(spacing: 8) {
                Text("مرحبًا، جوهرة 👋")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("نتبّع تقدمك في الذكاء العاطفي")
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 60)
            
            // كرت سيناريو العمل
            progressCard(
                title: "سيناريو العمل",
                progress: 0.7,
                message: "أحسنت، أداء ممتاز !",
                note: "أعد المحاولة في المستوى الخامس",
                noteColor: .red
            )
            
            // كرت سيناريو الصوت
            progressCard(
                title: "سيناريو الصوت",
                progress: 1.0,
                message: "أحسنت، أداء ممتاز !",
                note: "أكملت جميع المستويات",
                noteColor: .green
            )
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background").edgesIgnoringSafeArea(.all))
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    func progressCard(title: String, progress: Double, message: String, note: String, noteColor: Color) -> some View {
        // اللون الأزرق الموحد
        let progressColor = Color(red: 102/255, green: 204/255, blue: 204/255)
        
        return VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 58/255, green: 93/255, blue: 104/255))
            
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(message)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text(note)
                        .font(.subheadline)
                        .foregroundColor(noteColor)
                }
                
                Spacer()
                
                ZStack {
                    // الخلفية الرمادية
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                        .frame(width: 110, height: 110)
                    
                    // حلقة التقدم
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(progressColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 110, height: 110)
                        .animation(.easeOut(duration: 0.6), value: progress)
                    
                    // ✅ الدائرة خلف الرقم – بلون أزرق سماوي
                    Circle()
                        .fill(progressColor)
                        .frame(width: 90, height: 90)
                    
                    // الرقم
                    Text("\(Int(progress * 100))٪")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color.white)
        }
        .cornerRadius(16)
        .clipped()
    }
}

#Preview {
    ProgressView()
}
