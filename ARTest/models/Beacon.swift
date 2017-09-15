//
//  Beacon.swift
//  ARTest
//
//  Created by Joshua Auriemma on 9/15/17.
//  Copyright © 2017 Joshua Auriemma. All rights reserved.
//

import UIKit
import CoreLocation

class Beacon: NSObject {
    
    let name: String
    let icon: Int
    let uuid: UUID
    let majorValue: CLBeaconMajorValue
    let minorValue: CLBeaconMinorValue
    
    init(name: String, icon: Int, uuid: UUID, majorValue: CLBeaconMajorValue, minorValue: CLBeaconMinorValue) {
        self.name = name
        self.icon = icon
        self.uuid = uuid
        self.majorValue = majorValue
        self.minorValue = minorValue
    }
    
    func asBeaconRegion() -> CLBeaconRegion {
        return CLBeaconRegion(proximityUUID: uuid,
                              major: majorValue,
                              minor: minorValue,
                              identifier: name)
    }
    
}
