//
//  MomentEntryView.swift
//  GratefulMoments
//
//  Created by 백대성 on 2/3/26.
//

import SwiftUI

struct MomentEntryView: View {
    @State private var title: String = ""
    @State private var note: String = ""
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                contentStack
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Grateful For")
        }
    }
    
    var contentStack: some View {
        VStack(alignment: .leading) {
            TextField(text: $title) {
                Text("Title (Required)")
            }
            .font(.title.bold())
            .padding(.top, 48)
            Divider()
            
            
            
            TextField("Log your small wins", text: $note, axis: .vertical)
                .multilineTextAlignment(.leading)
                .lineLimit(5...Int.max)
        }
        .padding()
    }
}


#Preview {
    MomentEntryView()
}
