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

let connectNodes2: [edges] = [
    edges(from: "1", to: "2"),
    edges(from: "1", to: "14"),
    edges(from: "2", to: "3"),
    edges(from: "2", to: "13"),
    edges(from: "2", to: "14"),
    edges(from: "2", to: "Room 2150"),
    edges(from: "3", to: "40"),
    edges(from: "3", to: "Room 2100"),
    edges(from: "3", to: "Room 2150"),
    edges(from: "3", to: "Room 2160"),
    edges(from: "4", to: "5"),
    edges(from: "4", to: "6"),
    edges(from: "4", to: "40"),
    edges(from: "4", to: "Room 2060"),
    edges(from: "4", to: "Room 2100"),
    edges(from: "4", to: "Room 2160"),
    edges(from: "5", to: "11"),
    edges(from: "5", to: "Room 2020"),
    edges(from: "5", to: "Room 2030"),
    edges(from: "5", to: "Room 2040"),
    edges(from: "5", to: "Room 2050"),
    edges(from: "5", to: "Room 2060"),
    edges(from: "6", to: "7"),
    edges(from: "6", to: "Restroom 2170"),
    edges(from: "7", to: "8"),
    edges(from: "7", to: "23"),
    edges(from: "7", to: "Room 2200"),
    edges(from: "7", to: "Room 2210"),
    edges(from: "7", to: "Room 2220"),
    edges(from: "7", to: "Room 2230"),
    edges(from: "8", to: "10"),
    edges(from: "8", to: "24"),
    edges(from: "8", to: "Room 2200"),
    edges(from: "8", to: "Room 2210"),
    edges(from: "8", to: "Room 2220"),
    edges(from: "8", to: "Room 2230"),
    edges(from: "8", to: "Room 2820"),
    edges(from: "8", to: "Room 2840"),
    edges(from: "8", to: "Room 2860"),
    edges(from: "8", to: "Room 2880"),
    edges(from: "8", to: "Room 2910"),
    edges(from: "8", to: "Room 2920"),
    edges(from: "10", to: "12"),
    edges(from: "10", to: "Stair C2017"),
    edges(from: "10", to: "Room 2820"),
    edges(from: "10", to: "Room 2840"),
    edges(from: "10", to: "Room 2860"),
    edges(from: "10", to: "Room 2880"),
    edges(from: "10", to: "Room 2910"),
    edges(from: "10", to: "Room 2920"),
    edges(from: "11", to: "12"),
    edges(from: "11", to: "Stair C2001"),
    edges(from: "11", to: "Restroom 2010"),
    edges(from: "11", to: "Room 2030"),
    edges(from: "12", to: "Restroom 2010"),
    edges(from: "13", to: "14"),
    edges(from: "14", to: "15"),
    edges(from: "14", to: "Room 2320"),
    edges(from: "14", to: "Room 2330b"),
    edges(from: "15", to: "16"),
    edges(from: "15", to: " Room 2310"),
    edges(from: "15", to: "Room 2320"),
    edges(from: "15", to: "Room 2330b"),
    edges(from: "16", to: "17"),
    edges(from: "16", to: "Room 2300"),
    edges(from: "16", to: "Room 2330a"),
    edges(from: "16", to: "Room 2310"),
    edges(from: "17", to: "18"),
    edges(from: "Room 2300", to: "17"),
    edges(from: "Room 2330a", to: "17"),
    edges(from: "18", to: "19"),
    edges(from: "18", to: "Room 2340"),
    edges(from: "19", to: "20"),
    edges(from: "19", to: "Room 2340"),
    edges(from: "20", to: "21"),
    edges(from: "20", to: "39"),
    edges(from: "20", to: "Room 2290"),
    edges(from: "20", to: "Room 2295"),
    edges(from: "20", to: "Room 2350"),
    edges(from: "21", to: "22"),
    edges(from: "21", to: "Room 2285"),
    edges(from: "21", to: "Room 2290"),
    edges(from: "22", to: "23"),
    edges(from: "22", to: "Room 2280"),
    edges(from: "23", to: "24"),
    edges(from: "23", to: "Room 2240"),
    edges(from: "23", to: "Room 2250"),
    edges(from: "23", to: "Room 2260"),
    edges(from: "23", to: "Room 2270"),
    edges(from: "24", to: "25"),
    edges(from: "24", to: "Room 2240"),
    edges(from: "24", to: "Room 2250"),
    edges(from: "24", to: "Room 2260"),
    edges(from: "24", to: "Room 2270"),
    edges(from: "24", to: "Room 2480"),
    edges(from: "24", to: "Room 2620"),
    edges(from: "24", to: "Room 2640"),
    edges(from: "24", to: "Room 2660"),
    edges(from: "24", to: "Room 2680"),
    edges(from: "25", to: "26"),
    edges(from: "25", to: "Stair C2012"),
    edges(from: "25", to: "Room 2460"),
    edges(from: "25", to: "Room 2480"),
    edges(from: "25", to: "Room 2620"),
    edges(from: "25", to: "Room 2640"),
    edges(from: "25", to: "Room 2660"),
    edges(from: "25", to: "Room 2680"),
    edges(from: "26", to: "27"),
    edges(from: "26", to: "Room 2460"),
    edges(from: "26", to: "Room 2480"),
    edges(from: "26", to: "Room 2620"),
    edges(from: "26", to: "Stair C2012"),
    edges(from: "27", to: "28"),
    edges(from: "27", to: "30"),
    edges(from: "27", to: "Room 2440"),
    edges(from: "27", to: "Room 2500A"),
    edges(from: "27", to: "Room 2500B"),
    edges(from: "27", to: "Room 2500C"),
    edges(from: "27", to: "Room 2500D"),
    edges(from: "27", to: "Room 2500N"),
    edges(from: "27", to: "Room 2500M"),
    edges(from: "28", to: "29"),
    edges(from: "28", to: "Room 2500E"),
    edges(from: "28", to: "Room 2500F"),
    edges(from: "28", to: "Room 2500G"),
    edges(from: "28", to: "Room 2500H"),
    edges(from: "29", to: "30"),
    edges(from: "29", to: "Room 2500E"),
    edges(from: "29", to: "Room 2500F"),
    edges(from: "29", to: "Room 2500G"),
    edges(from: "29", to: "Room 2500H"),
    edges(from: "29", to: "Room 2500J"),
    edges(from: "29", to: "Room 2500K"),
    edges(from: "30", to: "31"),
    edges(from: "30", to: "Room 2430"),
    edges(from: "30", to: "Room 2440"),
    edges(from: "30", to: "Room 2500A"),
    edges(from: "30", to: "Room 2500B"),
    edges(from: "30", to: "Room 2500H"),
    edges(from: "30", to: "Room 2500J"),
    edges(from: "30", to: "Room 2500K"),
    edges(from: "30", to: "Room 2500L"),
    edges(from: "30", to: "Room 2500M"),
    edges(from: "30", to: "Room 2500N"),
    edges(from: "31", to: "32"),
    edges(from: "31", to: "Room 2430"),
    edges(from: "32", to: "34"),
    edges(from: "32", to: "37"),
    edges(from: "32", to: "38"),
    edges(from: "32", to: "Room 2400A"),
    edges(from: "32", to: "Room 2400B"),
    edges(from: "32", to: "Room 2400C"),
    edges(from: "32", to: "Room 2400D"),
    edges(from: "32", to: "Room 2400E"),
    edges(from: "32", to: "Room 2420"),
    edges(from: "32", to: "Room 2430"),
    edges(from: "32", to: "Room 2400N"),
    edges(from: "32", to: "Room 2400P"),
    edges(from: "33", to: "38"),
    edges(from: "33", to: "Room 2400C"),
    edges(from: "33", to: "Room 2400D"),
    edges(from: "33", to: "Room 2400E"),
    edges(from: "34", to: "35"),
    edges(from: "34", to: "Room 2400E"),
    edges(from: "34", to: "Room 2400F"),
    edges(from: "34", to: "Room 2400G"),
    edges(from: "35", to: "36"),
    edges(from: "35", to: "Room 2400G"),
    edges(from: "35", to: "Room 2400H"),
    edges(from: "35", to: "Room 2400J"),
    edges(from: "35", to: "Room 2400K"),
    edges(from: "36", to: "37"),
    edges(from: "36", to: "Room 2400L"),
    edges(from: "36", to: "Room 2400M"),
    edges(from: "37", to: "38"),
    edges(from: "37", to: "Room 2400L"),
    edges(from: "37", to: "Room 2400M"),
    edges(from: "37", to: "Room 2400N"),
    edges(from: "37", to: "Room 2400P"),
    edges(from: "38", to: "39"),
    edges(from: "38", to: "Room 2420"),
    edges(from: "38", to: "Restroom 2360"),
    edges(from: "38", to: "Restroom 2370"),
    edges(from: "38", to: "Room 2400A"),
    edges(from: "38", to: "Room 2400B"),
    edges(from: "38", to: "Room 2400N"),
    edges(from: "38", to: "Room 2400P"),
    edges(from: "39", to: "Room 2350"),
    edges(from: "40", to: "Room 2100"),
    edges(from: "Room 2310", to: "Room 2320"),
    edges(from: "Room 2320", to: "Room 2330b"),
    edges(from: "Room 2330", to: "Room 2330b"),
    edges(from: "Room 2880", to: "Stair C2017"),

]

//func testing() {
//    for edge in connectNodes{
//        var x1: Double? = nil
//        var y1: Double? = nil
//        var x2: Double? = nil
//        var y2: Double? = nil
//        
//        for node in mapNodes {
//            if node.name == edge.from {
//                x1 = node.x
//                y1 = node.y
//                print("Node \(node.name): \(x1!), \(y1!)")
//            } else if node.name == edge.to {
//                x2 = node.x
//                y2 = node.y
//                print("Node \(node.name): \(x2!), \(y2!)")
//            }
//        }
//        
//        // Ensure both nodes were found before calculating the distance
//        if let x1 = x1, let y1 = y1, let x2 = x2, let y2 = y2 {
//            let distance = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
//            print("Distance: \(distance)")
//        } else {
//            print("One or both nodes not found.")
//        }
//    }
//}
//
//
//
//
//
//struct testView: View {
//    var body: some View {
//        VStack {
//            Text("Calculating Distance...")
//                .onAppear {
//                    // Call the function when the view appears with the first edgec
//                    testing()
//                }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    testView()
//}

