//
//  Location .swift
//  SwiftfulMap
//
//  Created by Cansu Kahraman on 9.11.2022.
//

import Foundation
import MapKit

struct Location: Identifiable ,Equatable{
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    
    var id: String{
        name + cityName
    }
    
    //equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}


