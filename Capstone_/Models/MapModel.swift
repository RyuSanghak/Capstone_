//
//  MapModel.swift
//  Capstone_
//
//  Created by Sanghak Ryu on 9/25/24.
//

import Foundation

struct IndoorMap: Identifiable {
    let id = UUID()
    let name: String
    let filename: String
}

struct nodes {
    let name: String
    let x: Double
    let y: Double
    let z: Double
}

struct edges{
    let from: String
    let to: String
    //let x1: Double
    //let x2: Double
    //let y1: Double
    //  let y2: Double
    //let distance: Double
}
