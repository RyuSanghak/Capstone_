import Foundation
    
    
let connectNodes: [edges] = [
    edges(from: "f1n1", to: "Stair C1010a"),
    edges(from: "f1n1", to: "Stair C1010b"),
    edges(from: "f1n1", to: "f1n41"),
    edges(from: "f1n1", to: "f1n2"),
    edges(from: "f1n2", to: "Room 1140"),
    edges(from: "f1n2", to: "f1n3"),
    edges(from: "f1n2", to: "Door 3"),
    edges(from: "f1n3", to: "Room 1090"),
    edges(from: "f1n3", to: "Room 1100"),
    edges(from: "f1n3", to: "f1n4"),
    edges(from: "f1n4", to: "Room 1080"),
    edges(from: "f1n4", to: "Room 1090"),
    edges(from: "f1n4", to: "Room 1110"),
    edges(from: "f1n4", to: "Room 1120"),
    edges(from: "f1n4", to: "f1n5"),
    edges(from: "f1n5", to: "Room 1030"),
    edges(from: "f1n5", to: "Room 1040"),
    edges(from: "f1n5", to: "Room 1050"),
    edges(from: "f1n5", to: "Room 1060"),
    edges(from: "f1n5", to: "Room 1080"),
    edges(from: "f1n5", to: "f1n6"),
    edges(from: "f1n5", to: "f1n18"),
    edges(from: "f1n6", to: "Stair C1005"),
    edges(from: "f1n6", to: "Restroom 1020"),
    edges(from: "f1n6", to: "f1n7"),
    edges(from: "f1n7", to: "Door 4"),
    edges(from: "f1n7", to: "Door 5"),
    edges(from: "f1n7", to: "Door 6"),
    edges(from: "f1n7", to: "Door 7"),
    edges(from: "f1n7", to: "f1n8"),
    edges(from: "f1n8", to: "Door 4"),
    edges(from: "f1n8", to: "Door 5"),
    edges(from: "f1n8", to: "Door 6"),
    edges(from: "f1n8", to: "Door 7"),
    edges(from: "f1n8", to: "Stair C1029"),
    edges(from: "f1n8", to: "f1n9"),
    edges(from: "f1n9", to: "Stair C1029"),
    edges(from: "f1n9", to: "Room 1880"),
    edges(from: "f1n9", to: "f1n10"),
    edges(from: "f1n10", to: "Room 1860"),
    edges(from: "f1n10", to: "Room 1870"),
    edges(from: "f1n10", to: "Room 1900"),
    edges(from: "f1n10", to: "Room 1910"),
    edges(from: "f1n10", to: "Room 1920"),
    edges(from: "f1n10", to: "f1n11"),
    edges(from: "f1n11", to: "Room 1840"),
    edges(from: "f1n11", to: "Room 1850"),
    edges(from: "f1n11", to: "f1n12"),
    edges(from: "f1n12", to: "Room 1820"),
    edges(from: "f1n12", to: "Room 1830"),
    edges(from: "f1n12", to: "f1n13"),
    edges(from: "f1n13", to: "Room 1810"),
    edges(from: "f1n13", to: "f1n15"),
    edges(from: "f1n14", to: "Room 1240"),
    edges(from: "f1n14", to: "Room 1250"),
    edges(from: "f1n14", to: "Room 1260"),
    edges(from: "f1n14", to: "Room 1270"),
    edges(from: "f1n14", to: "f1n19"),
    edges(from: "f1n14", to: "f1n20"),
    edges(from: "f1n14", to: "Elevator C2019"),
    edges(from: "f1n15", to: "Room 1200"),
    edges(from: "f1n15", to: "Room 1210"),
    edges(from: "f1n15", to: "Room 1220"),
    edges(from: "f1n15", to: "Room 1230"),
    edges(from: "f1n15", to: "Stair C1020"),
    edges(from: "f1n15", to: "f1n16"),
    edges(from: "f1n16", to: "Room 1200"),
    edges(from: "f1n16", to: "Room 1210"),
    edges(from: "f1n16", to: "Room 1220"),
    edges(from: "f1n16", to: "Room 1230"),
    edges(from: "f1n16", to: "f1n17"),
    edges(from: "f1n16", to: "f1n19"),
    edges(from: "f1n17", to: "f1n18"),
    edges(from: "f1n17", to: "Room 1180b"),
    edges(from: "f1n18", to: "Room 1060"),
    edges(from: "f1n18", to: "Room 1150"),
    edges(from: "f1n19", to: "Room 1180a"),
    edges(from: "f1n19", to: "Room 1190"),
    edges(from: "f1n19", to: "Room 1240"),
    edges(from: "f1n19", to: "Room 1250"),
    edges(from: "f1n19", to: "Room 1260"),
    edges(from: "f1n19", to: "Room 1270"),
    edges(from: "f1n19", to: "Room 1280"),
    edges(from: "f1n19", to: "f1n37"),
    edges(from: "f1n20", to: "Room 1680"),
    edges(from: "f1n20", to: "Room 1700"),
    edges(from: "f1n20", to: "f1n21"),
    edges(from: "f1n21", to: "Room 1660"),
    edges(from: "f1n21", to: "Room 1670"),
    edges(from: "f1n21", to: "f1n22"),
    edges(from: "f1n22", to: "Room 1640"),
    edges(from: "f1n22", to: "Room 1650"),
    edges(from: "f1n22", to: "f1n23"),
    edges(from: "f1n23", to: "Room 1620"),
    edges(from: "f1n23", to: "Room 1630"),
    edges(from: "f1n23", to: "f1n24"),
    edges(from: "f1n24", to: "Room 1610"),
    edges(from: "f1n24", to: "f1n25"),
    edges(from: "f1n25", to: "Room 1480"),
    edges(from: "f1n25", to: "Stair C1024"),
    edges(from: "f1n25", to: "f1n26"),
    edges(from: "f1n26", to: "Room 1500A"),
    edges(from: "f1n26", to: "Room 1500B"),
    edges(from: "f1n26", to: "Room 1500C"),
    edges(from: "f1n26", to: "Room 1500D"),
    edges(from: "f1n26", to: "Room 1500E"),
    edges(from: "f1n26", to: "Stiar C1024"),
    edges(from: "f1n26", to: "f1n27"),
    edges(from: "f1n27", to: "Room 1500F"),
    edges(from: "f1n27", to: "Room 1500G"),
    edges(from: "f1n28", to: "Room 1500H"),
    edges(from: "f1n28", to: "Room 1500J"),
    edges(from: "f1n29", to: "Room 1500M"),
    edges(from: "f1n29", to: "Room 1500K"),
    edges(from: "f1n29", to: "Room 1500L"),
    edges(from: "f1n29", to: "Room 1500N"),
    edges(from: "f1n29", to: "Room 1500P"),
    edges(from: "f1n29", to: "f1n30"),
    edges(from: "f1n30", to: "Room 1430"),
    edges(from: "f1n30", to: "Room 1440"),
    edges(from: "f1n30", to: "f1n31"),
    edges(from: "f1n30", to: "Door 11"),
    edges(from: "f1n31", to: "Room 1430"),
    edges(from: "f1n31", to: "Room 1400A"),
    edges(from: "f1n31", to: "Room 1400B"),
    edges(from: "f1n31", to: "Room 1400C"),
    edges(from: "f1n31", to: "Room 1400D"),
    edges(from: "f1n31", to: "Room 1400E"),
    edges(from: "f1n31", to: "Room 1400F"),
    edges(from: "f1n31", to: "f1n32"),
    edges(from: "f1n31", to: "f1n34"),
    edges(from: "f1n32", to: "Room 1400G"),
    edges(from: "f1n32", to: "Room 1400H"),
    edges(from: "f1n32", to: "f1n33"),
    edges(from: "f1n33", to: "Room 1400J"),
    edges(from: "f1n33", to: "Room 1400K"),
    edges(from: "f1n34", to: "Room 1400L"),
    edges(from: "f1n34", to: "Room 1400M"),
    edges(from: "f1n34", to: "Room 1400N"),
    edges(from: "f1n34", to: "Room 1400P"),
    edges(from: "f1n34", to: "Room 1400Q"),
    edges(from: "f1n34", to: "Room 1400R"),
    edges(from: "f1n34", to: "Room 1420"),
    edges(from: "f1n34", to: "f1n35"),
    edges(from: "f1n35", to: "Restroom 1360"),
    edges(from: "f1n35", to: "f1n36"),
    edges(from: "f1n36", to: "f1n37"),
    edges(from: "f1n36", to: "f1n38"),
    edges(from: "f1n37", to: "Room 1290"),
    edges(from: "f1n37", to: "Room 1295"),
    edges(from: "f1n37", to: "Room 1300a"),
    edges(from: "f1n38", to: "Room 1300b"),
    edges(from: "f1n38", to: "Room 1340"),
    edges(from: "f1n38", to: "Room 1350"),
    edges(from: "f1n38", to: "f1n39"),
    edges(from: "f1n39", to: "f1n40"),
    edges(from: "f1n39", to: "1300c"),
    edges(from: "f1n40", to: "Room 1350"),
    edges(from: "f1n40", to: "Room 1310"),
    edges(from: "f1n40", to: "Door 1"),
    edges(from: "f1n40", to: "f1n41"),
    edges(from: "f1n41", to: "Stair C1010a"),
    edges(from: "f1n41", to: "Stair C1010b"),
    edges(from: "Door 1", to: "Room 1310"),
    edges(from: "Door 2", to: "Stair C1010a"),
    edges(from: "Door 2", to: "Stair C1010b"),
    edges(from: "Door 3", to: "Room 1140"),
    edges(from: "Door 8", to: "Stair C1029"),
    edges(from: "Door 9", to: "Room 1480"),
    edges(from: "Door 10", to: "Stair C1024"),

    //Stairs
    edges(from: "Stair C1005", to: "Stair C2001"),
    edges(from: "Stair C1029", to: "Stair C2017"),
    edges(from: "Stair C1024", to: "Stair C2012"),
    edges(from: "Stair C1010a", to: "f2n13"),
    edges(from: "Stair C1010b", to: "f2n1"),
    
    //2nd Floor
    edges(from: "f2n1", to: "f2n2"),
    edges(from: "f2n1", to: "f2n14"),
    edges(from: "f2n2", to: "f2n3"),
    edges(from: "f2n2", to: "f2n13"),
    edges(from: "f2n2", to: "f2n14"),
    edges(from: "f2n2", to: "Room 2150"),
    edges(from: "f2n3", to: "f2n40"),
    edges(from: "f2n3", to: "Room 2100"),
    edges(from: "f2n3", to: "Room 2150"),
    edges(from: "f2n3", to: "Room 2160"),
    edges(from: "f2n4", to: "f2n5"),
    edges(from: "f2n4", to: "f2n6"),
    edges(from: "f2n4", to: "f2n40"),
    edges(from: "f2n4", to: "Room 2060"),
    edges(from: "f2n4", to: "Room 2100"),
    edges(from: "f2n4", to: "Room 2160"),
    edges(from: "f2n5", to: "f2n11"),
    edges(from: "f2n5", to: "Room 2020"),
    edges(from: "f2n5", to: "Room 2030"),
    edges(from: "f2n5", to: "Room 2040"),
    edges(from: "f2n5", to: "Room 2050"),
    edges(from: "f2n5", to: "Room 2060"),
    edges(from: "f2n6", to: "f2n7"),
    edges(from: "f2n6", to: "Restroom 2170"),
    edges(from: "f2n7", to: "f2n8"),
    edges(from: "f2n7", to: "f2n23"),
    edges(from: "f2n7", to: "Room 2200"),
    edges(from: "f2n7", to: "Room 2210"),
    edges(from: "f2n7", to: "Room 2220"),
    edges(from: "f2n7", to: "Room 2230"),
    edges(from: "f2n7", to: "Stair C2009"),
    edges(from: "f2n8", to: "f2n10"),
    edges(from: "f2n8", to: "f2n24"),
    edges(from: "f2n8", to: "Room 2200"),
    edges(from: "f2n8", to: "Room 2210"),
    edges(from: "f2n8", to: "Room 2220"),
    edges(from: "f2n8", to: "Room 2230"),
    edges(from: "f2n8", to: "Room 2820"),
    edges(from: "f2n8", to: "Room 2840"),
    edges(from: "f2n8", to: "Room 2860"),
    edges(from: "f2n8", to: "Room 2880"),
    edges(from: "f2n8", to: "Room 2910"),
    edges(from: "f2n8", to: "Room 2920"),
    edges(from: "f2n8", to: "Stair C2009"),
    edges(from: "f2n10", to: "f2n12"),
    edges(from: "f2n10", to: "Stair C2017"),
    edges(from: "f2n10", to: "Room 2820"),
    edges(from: "f2n10", to: "Room 2840"),
    edges(from: "f2n10", to: "Room 2860"),
    edges(from: "f2n10", to: "Room 2880"),
    edges(from: "f2n10", to: "Room 2910"),
    edges(from: "f2n10", to: "Room 2920"),
    edges(from: "f2n11", to: "f2n12"),
    edges(from: "f2n11", to: "Stair C2001"),
    edges(from: "f2n11", to: "Restroom 2010"),
    edges(from: "f2n11", to: "Room 2030"),
    edges(from: "f2n12", to: "Restroom 2010"),
    edges(from: "f2n13", to: "f2n14"),
    edges(from: "f2n14", to: "f2n15"),
    edges(from: "f2n14", to: "Room 2320"),
    edges(from: "f2n14", to: "Room 2330b"),
    edges(from: "f2n15", to: "f2n16"),
    edges(from: "f2n15", to: "Room 2310"),
    edges(from: "f2n15", to: "Room 2320"),
    edges(from: "f2n15", to: "Room 2330b"),
    edges(from: "f2n16", to: "f2n17"),
    edges(from: "f2n16", to: "Room 2300"),
    edges(from: "f2n16", to: "Room 2330a"),
    edges(from: "f2n16", to: "Room 2310"),
    edges(from: "f2n17", to: "f2n18"),
    edges(from: "Room 2300", to: "f2n17"),
    edges(from: "Room 2330a", to: "f2n17"),
    edges(from: "f2n18", to: "f2n19"),
    edges(from: "f2n18", to: "Room 2340"),
    edges(from: "f2n19", to: "f2n20"),
    edges(from: "f2n19", to: "Room 2340"),
    edges(from: "f2n20", to: "f2n21"),
    edges(from: "f2n20", to: "f2n39"),
    edges(from: "f2n20", to: "Room 2290"),
    edges(from: "f2n20", to: "Room 2295"),
    edges(from: "f2n20", to: "Room 2350"),
    edges(from: "f2n21", to: "f2n22"),
    edges(from: "f2n21", to: "Room 2285"),
    edges(from: "f2n21", to: "Room 2290"),
    edges(from: "f2n22", to: "f2n23"),
    edges(from: "f2n22", to: "Room 2280"),
    edges(from: "f2n23", to: "f2n24"),
    edges(from: "f2n23", to: "Room 2240"),
    edges(from: "f2n23", to: "Room 2250"),
    edges(from: "f2n23", to: "Room 2260"),
    edges(from: "f2n23", to: "Room 2270"),
    edges(from: "f2n23", to: "Elevator C2008"),
    edges(from: "f2n24", to: "f2n25"),
    edges(from: "f2n24", to: "Room 2240"),
    edges(from: "f2n24", to: "Room 2250"),
    edges(from: "f2n24", to: "Room 2260"),
    edges(from: "f2n24", to: "Room 2270"),
    edges(from: "f2n24", to: "Room 2480"),
    edges(from: "f2n24", to: "Room 2620"),
    edges(from: "f2n24", to: "Room 2640"),
    edges(from: "f2n24", to: "Room 2660"),
    edges(from: "f2n24", to: "Room 2680"),
    edges(from: "f2n24", to: "Elevator C2008"),
    edges(from: "f2n25", to: "f2n26"),
    edges(from: "f2n25", to: "Stair C2012"),
    edges(from: "f2n25", to: "Room 2460"),
    edges(from: "f2n25", to: "Room 2480"),
    edges(from: "f2n25", to: "Room 2620"),
    edges(from: "f2n25", to: "Room 2640"),
    edges(from: "f2n25", to: "Room 2660"),
    edges(from: "f2n25", to: "Room 2680"),
    edges(from: "f2n26", to: "f2n27"),
    edges(from: "f2n26", to: "Room 2460"),
    edges(from: "f2n26", to: "Room 2480"),
    edges(from: "f2n26", to: "Room 2620"),
    edges(from: "f2n26", to: "Stair C2012"),
    edges(from: "f2n27", to: "f2n28"),
    edges(from: "f2n27", to: "f2n30"),
    edges(from: "f2n27", to: "Room 2440"),
    edges(from: "f2n27", to: "Room 2500A"),
    edges(from: "f2n27", to: "Room 2500B"),
    edges(from: "f2n27", to: "Room 2500C"),
    edges(from: "f2n27", to: "Room 2500D"),
    edges(from: "f2n27", to: "Room 2500N"),
    edges(from: "f2n27", to: "Room 2500M"),
    edges(from: "f2n28", to: "f2n29"),
    edges(from: "f2n28", to: "Room 2500E"),
    edges(from: "f2n28", to: "Room 2500F"),
    edges(from: "f2n28", to: "Room 2500G"),
    edges(from: "f2n28", to: "Room 2500H"),
    edges(from: "f2n29", to: "f2n30"),
    edges(from: "f2n29", to: "Room 2500E"),
    edges(from: "f2n29", to: "Room 2500F"),
    edges(from: "f2n29", to: "Room 2500G"),
    edges(from: "f2n29", to: "Room 2500H"),
    edges(from: "f2n29", to: "Room 2500J"),
    edges(from: "f2n29", to: "Room 2500K"),
    edges(from: "f2n30", to: "f2n31"),
    edges(from: "f2n30", to: "Room 2430"),
    edges(from: "f2n30", to: "Room 2440"),
    edges(from: "f2n30", to: "Room 2500A"),
    edges(from: "f2n30", to: "Room 2500B"),
    edges(from: "f2n30", to: "Room 2500H"),
    edges(from: "f2n30", to: "Room 2500J"),
    edges(from: "f2n30", to: "Room 2500K"),
    edges(from: "f2n30", to: "Room 2500L"),
    edges(from: "f2n30", to: "Room 2500M"),
    edges(from: "f2n30", to: "Room 2500N"),
    edges(from: "f2n31", to: "f2n32"),
    edges(from: "f2n31", to: "Room 2430"),
    edges(from: "f2n32", to: "f2n34"),
    edges(from: "f2n32", to: "f2n37"),
    edges(from: "f2n32", to: "f2n38"),
    edges(from: "f2n32", to: "Room 2400A"),
    edges(from: "f2n32", to: "Room 2400B"),
    edges(from: "f2n32", to: "Room 2400C"),
    edges(from: "f2n32", to: "Room 2400D"),
    edges(from: "f2n32", to: "Room 2400E"),
    edges(from: "f2n32", to: "Room 2420"),
    edges(from: "f2n32", to: "Room 2430"),
    edges(from: "f2n32", to: "Room 2400N"),
    edges(from: "f2n32", to: "Room 2400P"),
    edges(from: "f2n33", to: "f2n38"),
    edges(from: "f2n33", to: "Room 2400C"),
    edges(from: "f2n33", to: "Room 2400D"),
    edges(from: "f2n33", to: "Room 2400E"),
    edges(from: "f2n34", to: "f2n35"),
    edges(from: "f2n34", to: "Room 2400E"),
    edges(from: "f2n34", to: "Room 2400F"),
    edges(from: "f2n34", to: "Room 2400G"),
    edges(from: "f2n35", to: "f2n36"),
    edges(from: "f2n35", to: "Room 2400G"),
    edges(from: "f2n35", to: "Room 2400H"),
    edges(from: "f2n35", to: "Room 2400J"),
    edges(from: "f2n35", to: "Room 2400K"),
    edges(from: "f2n36", to: "f2n37"),
    edges(from: "f2n36", to: "Room 2400L"),
    edges(from: "f2n36", to: "Room 2400M"),
    edges(from: "f2n37", to: "f2n38"),
    edges(from: "f2n37", to: "Room 2400L"),
    edges(from: "f2n37", to: "Room 2400M"),
    edges(from: "f2n37", to: "Room 2400N"),
    edges(from: "f2n37", to: "Room 2400P"),
    edges(from: "f2n38", to: "f2n39"),
    edges(from: "f2n38", to: "Room 2420"),
    edges(from: "f2n38", to: "Restroom 2360"),
    edges(from: "f2n38", to: "Restroom 2370"),
    edges(from: "f2n38", to: "Room 2400A"),
    edges(from: "f2n38", to: "Room 2400B"),
    edges(from: "f2n38", to: "Room 2400N"),
    edges(from: "f2n38", to: "Room 2400P"),
    edges(from: "f2n39", to: "Room 2350"),
    edges(from: "f2n40", to: "Room 2100"),
    edges(from: "Room 2310", to: "Room 2320"),
    edges(from: "Room 2320", to: "Room 2330b"),
    edges(from: "Room 2320", to: "Room 2310"),
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



