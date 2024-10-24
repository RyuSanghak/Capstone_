//
//  EdgesData.swift
//  Capstone_
//
//  Created by Seokhyun Hong on 10/3/24.
//
import SwiftUI
import SceneKit
import Foundation
    
    
let connectNodes: [edges] = [
    edges(from: "1", to: "2"),
    edges(from: "1", to: "59"),
    edges(from: "2", to: "3"),
    edges(from: "3", to: "4"),
    edges(from: "3", to: "26"),
    edges(from: "4", to: "5"),
    edges(from: "4", to: "6"),
    edges(from: "6", to: "11"),
    edges(from: "7", to: "8"),
    edges(from: "8", to: "9"),
    edges(from: "9", to: "10"),
    edges(from: "10", to: "11"),
    edges(from: "11", to: "12"),
    edges(from: "12", to: "13"),
    edges(from: "13", to: "14"),
    edges(from: "14", to: "15"),
    edges(from: "14", to: "16"),
    edges(from: "16", to: "17"),
    edges(from: "17", to: "18"),
    edges(from: "18", to: "19"),
    edges(from: "19", to: "20"),
    edges(from: "20", to: "21"),
    edges(from: "20", to: "32"),
    edges(from: "21", to: "22"),
    edges(from: "22", to: "23"),
    edges(from: "23", to: "24"),
    edges(from: "24", to: "25"),
    edges(from: "25", to: "26"),
    edges(from: "25", to: "27"),
    edges(from: "27", to: "28"),
    edges(from: "27", to: "49"),
    edges(from: "28", to: "29"),
    edges(from: "29", to: "30"),
    edges(from: "30", to: "31"),
    edges(from: "31", to: "32"),
    edges(from: "32", to: "33"),
    edges(from: "33", to: "34"),
    edges(from: "33", to: "35"),
    edges(from: "35", to: "36"),
    edges(from: "36", to: "37"),
    edges(from: "37", to: "38"),
    edges(from: "38", to: "39"),
    edges(from: "39", to: "40"),
    edges(from: "40", to: "41"),
    edges(from: "41", to: "42"),
    edges(from: "42", to: "43"),
    edges(from: "43", to: "44"),
    edges(from: "44", to: "45"),
    edges(from: "45", to: "46"),
    edges(from: "46", to: "47"),
    edges(from: "46", to: "48"),
    edges(from: "46", to: "50"),
    edges(from: "48", to: "49"),
    edges(from: "50", to: "51"),
    edges(from: "51", to: "52"),
    edges(from: "52", to: "53"),
    edges(from: "53", to: "54"),
    edges(from: "53", to: "55"),
    edges(from: "55", to: "56"),
    edges(from: "56", to: "57"),
    edges(from: "57", to: "58"),
    edges(from: "57", to: "59")
]

/*
 


func calculateEdgeDistance() {
    for edge in connectNodes{
        var x1: Double? = nil
        var y1: Double? = nil
        var x2: Double? = nil
        var y2: Double? = nil
        
        for node in mapNodes {
            if node.name == edge.from {
                x1 = node.x
                y1 = node.y
                print("Node \(node.name): \(x1!), \(y1!)")
            } else if node.name == edge.to {
                x2 = node.x
                y2 = node.y
                print("Node \(node.name): \(x2!), \(y2!)")
            }
        }
        
        // Ensure both nodes were found before calculating the distance
        if let x1 = x1, let y1 = y1, let x2 = x2, let y2 = y2 {
            let distance = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
            print("Distance: \(distance)")
        } else {
            print("One or both nodes not found.")
        }
    }
}

*/

