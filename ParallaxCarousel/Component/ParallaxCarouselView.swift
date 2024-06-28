//
//  ParallaxCarouselView.swift
//  ParallaxCarousel
//
//  Created by shiyanjun on 2024/6/28.
//

import SwiftUI

/// - 视差轮播视图组件
struct ParallaxCarouselView<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]
    var width: CGFloat?
    var height: CGFloat?
    var spacing: CGFloat?
    var cornerRadius: CGFloat?
    
    init(width: CGFloat? = nil, height: CGFloat? = nil, spacing: CGFloat? = 5, cornerRadius: CGFloat? = nil,
         items: [T], @ViewBuilder content: @escaping (T)->Content) {
        self.list = items
        self.content = content
        self.width = width
        self.height = height
        self.spacing = spacing
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach(list) { item in
                        GeometryReader { proxy in
                            let cardSize = proxy.size
                            
                            let minX = min((proxy.frame(in: .scrollView).minX) * 1.4, size.width * 1.4)
                            
                            content(item)
                                .offset(x: -minX)
                                .frame(width: cardSize.width, height: cardSize.height)
                                .clipShape(.rect(cornerRadius: cornerRadius ?? 15))
                        }
                        .frame(width: size.width, height: size.height)
                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                            view.scaleEffect(phase.isIdentity ? 1 : 0.95)
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(.all)
        .frame(width: width, height: height)
        
    }
}

struct ParallaxCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
