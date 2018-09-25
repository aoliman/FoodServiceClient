


//
//  SegmentioBuilder.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko on 11/14/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Segmentio
import UIKit

struct SegmentioBuilderHome {
    
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 4,
            color:.red
        )
    }
    
    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 4)) {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }
    
    private static func segmentioContent() -> [SegmentioItem] {
        return [
           
            SegmentioItem(title: "Party Cookerm".localize(), image: #imageLiteral(resourceName: "map_marker_party_cooker-1").tint(with: #colorLiteral(red: 0.6352391243, green: 0.6353304982, blue: 0.6352103949, alpha: 1)), selectedImage: #imageLiteral(resourceName: "map_marker_party_cooker-1").tint(with: #colorLiteral(red: 0.08737478405, green: 0.735198617, blue: 0.8322803378, alpha: 1))),
             SegmentioItem(title: "Home Cookerm".localize(), image: #imageLiteral(resourceName: "map_marker_home_cooker").tint(with: #colorLiteral(red: 0.6352391243, green: 0.6353304982, blue: 0.6352103949, alpha: 1)), selectedImage: #imageLiteral(resourceName: "map_marker_home_cooker").tint(with: #colorLiteral(red: 0.08737478405, green: 0.735198617, blue: 0.8322803378, alpha: 1))),
             SegmentioItem(title: "  Food Car ".localize(), image: #imageLiteral(resourceName: "map_marker_food_car").tint(with: #colorLiteral(red: 0.6352391243, green: 0.6353304982, blue: 0.6352103949, alpha: 1)), selectedImage: #imageLiteral(resourceName: "map_marker_food_car").tint(with: #colorLiteral(red: 0.08737478405, green: 0.735198617, blue: 0.8322803378, alpha: 1))),
             SegmentioItem(title: "Resturante".localize(), image: #imageLiteral(resourceName: "cutlery").tint(with: #colorLiteral(red: 0.5244676471, green: 0.5213527679, blue: 0.5268642902, alpha: 1)), selectedImage: #imageLiteral(resourceName: "cutlery").tint(with: #colorLiteral(red: 0.08737478405, green: 0.735198617, blue: 0.8322803378, alpha: 1)))
            
             
        ]
    }
    
    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition = .fixed(maxVisibleItems: 4)) -> SegmentioOptions {
        var imageContentMode = UIViewContentMode.center
        switch segmentioStyle {
        case .imageOverLabel, .imageAfterLabel:
            imageContentMode = .scaleAspectFit
        default:
            break
        }
        
        return SegmentioOptions(
            backgroundColor: .white,
            segmentPosition: segmentioPosition,
            scrollEnabled: false,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }
    
    private static func segmentioStates() -> SegmentioStates {
        
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: .appFont(ofSize:16) ,
                titleTextColor: .gray
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: .appFontBold(ofSize: 18),
                titleTextColor: #colorLiteral(red: 0, green: 0.7353979945, blue: 0.8323598504, alpha: 1)
            ),
            highlightedState: segmentioState(
                backgroundColor: .clear,
                titleFont: .appFont(ofSize: 16),
                titleTextColor: .gray
            )
        )
    }
    
    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: .clear,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }
    
    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: .clear
        )
    }
    
    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 0,
            color: .clear
        )
    }
    
    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 0,
            color: .clear
            
        )
    }
   
   
    

    
    
    
}

