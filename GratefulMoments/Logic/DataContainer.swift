//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by 백대성 on 2/10/26.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer { // 창고 제작, 문 연결, 샘플 데이터 넣어주는 관리자
    let modelContainer: ModelContainer // 앱의 데이터 창고
    
    var context: ModelContext { // 데이터 창고의 문(입,출고 통로)
        modelContainer.mainContext
    }
    
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments) // 메모리에만 저장(앱 종료시 데이터 소멸)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration]) // 위 설정값으로 진짜 데이터 창고 생성
            
            if includeSampleMoments {
                loadSampleMoments()
            }
            
            try context.save() // 앱 실행시 샘플로 채움, 종료시 초기화
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
        
    }
    
    private func loadSampleMoments() {
        for moment in Moment.sampleData {
            context.insert(moment)
        }
    }
}
    
private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}
