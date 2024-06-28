//
//  ExampleView.swift
//  ParallaxCarousel
//
//  Created by shiyanjun on 2024/6/29.
//

import SwiftUI

/// - 图片视差轮播组件使用示例
struct ExampleView: View {
    let images: [Location] = [
        .init(image: "SF"),
        .init(image: "NYC"),
        .init(image: "Seattle"),
        .init(image: "Chicago"),
    ]
    
    struct Location: Identifiable {
        var id = UUID().uuidString
        var image: String
    }
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ParallaxCarouselView(width: screenWidth - 30, height: 500, spacing: 20, items: images) { image in
            Image(image.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

#Preview {
    ExampleView()
        .preferredColorScheme(.dark)
}
