//
//  PageControlView.swift
//  WeatherApp
//
//  Created by Johnny Tam on 26/3/2024.
//

import Foundation
import SwiftUI

struct PageControlView: UIViewRepresentable {
    @Binding var currentPage: Int
    var numberOfPages: Int
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(currentPage: $currentPage)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = 1
        control.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
        control.pageIndicatorTintColor = UIColor(.primary)
        control.currentPageIndicatorTintColor = UIColor(.accentColor)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.setContentHuggingPriority(.required, for: .horizontal)
        control.addTarget(
            context.coordinator,
            action: #selector(Coordinator.pageControlDidFire(_:)),
            for: .valueChanged)
        return control
    }
    
    func updateUIView(_ control: UIPageControl, context: Context) {
        context.coordinator.currentPage = $currentPage
        control.numberOfPages = numberOfPages
        control.currentPage = currentPage
    }
    
    class Coordinator {
        var currentPage: Binding<Int>
        
        init(currentPage: Binding<Int>) {
            self.currentPage = currentPage
        }
        
        @objc
        func pageControlDidFire(_ control: UIPageControl) {
            currentPage.wrappedValue = control.currentPage
        }
    }
}
