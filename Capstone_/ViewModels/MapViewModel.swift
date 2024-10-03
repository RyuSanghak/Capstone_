// ViewModels/MapViewModel.swift
import Foundation
import SceneKit
import Combine

class MapViewModel: ObservableObject {
    @Published var maps: [IndoorMap] = []
    @Published var selectedMap: IndoorMap? {
        didSet {  //
            loadScene()
        }
    }
    @Published var scene: SCNScene?
    
    
    init() {
        loadMaps()
    }
    
    private func loadMaps() {
        maps = [
            IndoorMap(name: "MFH_1", filename: "MFH_1.usdz"),
            
        ]
        selectedMap = maps.first // init selectedMap
    }

    
    func createMapScene(mapName: String) -> SCNScene {
        guard let selectedMap = selectedMap else {
            scene = nil
            return SCNScene() // return empty scene
        }

        let scene = SCNScene()
        
        if let mapNode = loadUSDZModel(named: selectedMap.name){
            scene.rootNode.addChildNode(mapNode)
            

            //room node
            let room_1610 = createSphereNode(position: SCNVector3(x: -341.305194, y: 404.539474, z: 1))
            let room_1620 = createSphereNode(position: SCNVector3(x: -279.904235, y: 404.393037, z: 1))
            let room_1630 = createSphereNode(position: SCNVector3(x: -260.845713, y: 404.50388, z: 1))
            let room_1640 = createSphereNode(position: SCNVector3(x: -199.521141, y: 404.785501, z: 1))
            let room_1650 = createSphereNode(position: SCNVector3(x: -180.332407, y: 404.768063, z: 1))
            let room_1660 = createSphereNode(position: SCNVector3(x: -119.190331, y: 404.786586, z: 1))
            let room_1670 = createSphereNode(position: SCNVector3(x: -100.24975, y: 404.812659, z: 1))
            let room_1690 = createSphereNode(position: SCNVector3(x: -39.176082, y: 404.93938, z: 1))
            let room_1700 = createSphereNode(position: SCNVector3(x: -20.025, y: 367.47582, z: 1))
            let room_1480 = createSphereNode(position: SCNVector3(x: -375.795887, y: 348.19191, z: 1))
            let room_C1026 = createSphereNode(position: SCNVector3(x: -320.97023, y: 246.672305, z: 1))
            let room_1460 = createSphereNode(position: SCNVector3(x: -351.253174, y: 252.050378, z: 1))
            let room_1440 = createSphereNode(position: SCNVector3(x: -378.023755, y: 177.165184, z: 1))
            let room_1430 = createSphereNode(position: SCNVector3(x: -369.161965, y: 163.18738, z: 1))
            let room_1400A = createSphereNode(position: SCNVector3(x: -294.938185, y: 165.815691, z: 1))
            let room_1400B = createSphereNode(position: SCNVector3(x: -280.188304, y: 165.815691, z: 1))
            let room_1400C = createSphereNode(position: SCNVector3(x: -262.90988, y: 149.67942, z: 1))
            let room_1400D = createSphereNode(position: SCNVector3(x: -248.26479, y: 149.67942, z: 1))
            let room_1400E = createSphereNode(position: SCNVector3(x: -231.13199, y: 165.81569, z: 1))
            let room_1400F = createSphereNode(position: SCNVector3(x: -216.24074, y: 165.81569, z: 1))
            let room_1400G = createSphereNode(position: SCNVector3(x: -190.30178, y: 156.84073, z: 1))
            let room_1400J = createSphereNode(position: SCNVector3(x: -190.30178, y: 94.73169, z: 1))
            let room_1400K = createSphereNode(position: SCNVector3(x: -190.30178, y: 80.45295, z: 1))
            let room_1400M = createSphereNode(position: SCNVector3(x: -231.03346, y: 71.97578, z: 1))
            let room_1400N = createSphereNode(position: SCNVector3(x: -248.1811, y: 87.98989, z: 1))
            let room_1400P = createSphereNode(position: SCNVector3(x: -263.16094, y: 87.98989, z: 1))
            let room_1400Q = createSphereNode(position: SCNVector3(x: -280.2729, y: 71.97578, z: 1))
            let room_1400R = createSphereNode(position: SCNVector3(x: -294.79681, y: 71.97578, z: 1))
            let room_1240 = createSphereNode(position: SCNVector3(x: -52.98612, y: 290.66061, z: 1))
            let room_1250 = createSphereNode(position: SCNVector3(x: -52.98612, y: 275.06695, z: 1))
            let room_1260 = createSphereNode(position: SCNVector3(x: -52.98612, y: 134.08363, z: 1))
            let room_1270 = createSphereNode(position: SCNVector3(x: -52.98612, y: 118.79499, z: 1))
            let room_1295 = createSphereNode(position: SCNVector3(x: -234.07867, y: 2.55614, z: 1))
            let room_1290 = createSphereNode(position: SCNVector3(x: -207.62604, y: 3.01312, z: 1))
            let room_1340 = createSphereNode(position: SCNVector3(x: -350.01721, y: -116.67171, z: 1))
            let room_1350 = createSphereNode(position: SCNVector3(x: -332.48687, y: -216.17751, z: 1))
            let room_1300A = createSphereNode(position: SCNVector3(x: -332.48687, y: -216.17751, z: 1))
            let room_1300B = createSphereNode(position: SCNVector3(x: -235.5261, y: -195.87845, z: 1))
            let room_1280 = createSphereNode(position: SCNVector3(x: -53.23181, y: -8.34234, z: 1))
            let room_1310 = createSphereNode(position: SCNVector3(x: -142.56011, y: -219.80507, z: 1))
            let room_1200 = createSphereNode(position: SCNVector3(x: 72.31326, y: 118.55619, z: 1))
            let room_1210 = createSphereNode(position: SCNVector3(x: 72.31326, y: 134.1267, z: 1))
            let room_1220 = createSphereNode(position: SCNVector3(x: 72.31326, y: 275.18577, z: 1))
            let room_1230 = createSphereNode(position: SCNVector3(x: 72.31326, y: 290.5731, z: 1))
            let room_1810 = createSphereNode(position: SCNVector3(x: 57.40268, y: 404.5119, z: 1))
            let room_1820 = createSphereNode(position: SCNVector3(x: 124.85633, y: 404.70553, z: 1))
            let room_1830 = createSphereNode(position: SCNVector3(x: 138.04066, y: 404.70553, z: 1))
            let room_1840 = createSphereNode(position: SCNVector3(x: 205.43362, y: 404.60989, z: 1))
            let room_1850 = createSphereNode(position: SCNVector3(x: 218.51956, y: 404.95215, z: 1))
            let room_1860 = createSphereNode(position: SCNVector3(x: 285.37164, y: 404.95215, z: 1))
            let room_1870 = createSphereNode(position: SCNVector3(x: 298.94953, y: 404.72528, z: 1))
            let room_1880 = createSphereNode(position: SCNVector3(x: 368.36679, y: 404.72528, z: 1))
            let room_1890 = createSphereNode(position: SCNVector3(x: 387.99377, y: 402.7584, z: 1))
            let room_1900 = createSphereNode(position: SCNVector3(x: 260.33434, y: 368.20045, z: 1))
            let room_1910 = createSphereNode(position: SCNVector3(x: 270.85362, y: 317.64313, z: 1))
            let room_1920 = createSphereNode(position: SCNVector3(x: 287.89814, y: 343.86501, z: 1))
            let room_1030 = createSphereNode(position: SCNVector3(x: 271.3167, y: 129.66895, z: 1))
            let room_1040 = createSphereNode(position: SCNVector3(x: 269.95011, y: 145.18802, z: 1))
            let room_1050 = createSphereNode(position: SCNVector3(x: 262.89098, y: 151.34184, z: 1))
            let room_1060 = createSphereNode(position: SCNVector3(x: 239.995, y: 66.37097, z: 1))
            let room_Restroom1 = createSphereNode(position: SCNVector3(x: -389.76987, y: 44.43691, z: 1))
            let room_Restroom2 = createSphereNode(position: SCNVector3(x: 389, y: -5, z: 1))
            let room_1080 = createSphereNode(position: SCNVector3(x: 289.17802, y: -89.20259, z: 1))
            let room_1090 = createSphereNode(position: SCNVector3(x: 294.19671, y: -150.68874, z: 1))
            let room_1120 = createSphereNode(position: SCNVector3(x: 241.51911, y: -138.42886, z: 1))
            let room_1140 = createSphereNode(position: SCNVector3(x: 167.84185, y: -236.7777, z: 1))

            scene.rootNode.addChildNode(room_1610)
            scene.rootNode.addChildNode(room_1620)
            scene.rootNode.addChildNode(room_1630)
            scene.rootNode.addChildNode(room_1640)
            scene.rootNode.addChildNode(room_1650)
            scene.rootNode.addChildNode(room_1660)
            scene.rootNode.addChildNode(room_1670)
            scene.rootNode.addChildNode(room_1690)
            scene.rootNode.addChildNode(room_1700)
            scene.rootNode.addChildNode(room_1480)
            scene.rootNode.addChildNode(room_C1026)
            scene.rootNode.addChildNode(room_1460)
            scene.rootNode.addChildNode(room_1440)
            scene.rootNode.addChildNode(room_1430)
            scene.rootNode.addChildNode(room_1400A)
            scene.rootNode.addChildNode(room_1400B)
            scene.rootNode.addChildNode(room_1400C)
            scene.rootNode.addChildNode(room_1400D)
            scene.rootNode.addChildNode(room_1400E)
            scene.rootNode.addChildNode(room_1400F)
            scene.rootNode.addChildNode(room_1400G)
            scene.rootNode.addChildNode(room_1400J)
            scene.rootNode.addChildNode(room_1400K)
            scene.rootNode.addChildNode(room_1400M)
            scene.rootNode.addChildNode(room_1400N)
            scene.rootNode.addChildNode(room_1400P)
            scene.rootNode.addChildNode(room_1400Q)
            scene.rootNode.addChildNode(room_1400R)
            scene.rootNode.addChildNode(room_1240)
            scene.rootNode.addChildNode(room_1250)
            scene.rootNode.addChildNode(room_1260)
            scene.rootNode.addChildNode(room_1270)
            scene.rootNode.addChildNode(room_1295)
            scene.rootNode.addChildNode(room_1290)
            scene.rootNode.addChildNode(room_1340)
            scene.rootNode.addChildNode(room_1350)
            scene.rootNode.addChildNode(room_1300A)
            scene.rootNode.addChildNode(room_1300B)
            scene.rootNode.addChildNode(room_1280)
            scene.rootNode.addChildNode(room_1310)
            scene.rootNode.addChildNode(room_1200)
            scene.rootNode.addChildNode(room_1210)
            scene.rootNode.addChildNode(room_1220)
            scene.rootNode.addChildNode(room_1230)
            scene.rootNode.addChildNode(room_1810)
            scene.rootNode.addChildNode(room_1820)
            scene.rootNode.addChildNode(room_1830)
            scene.rootNode.addChildNode(room_1840)
            scene.rootNode.addChildNode(room_1850)
            scene.rootNode.addChildNode(room_1860)
            scene.rootNode.addChildNode(room_1870)
            scene.rootNode.addChildNode(room_1880)
            scene.rootNode.addChildNode(room_1890)
            scene.rootNode.addChildNode(room_1900)
            scene.rootNode.addChildNode(room_1910)
            scene.rootNode.addChildNode(room_1920)
            scene.rootNode.addChildNode(room_1030)
            scene.rootNode.addChildNode(room_1040)
            scene.rootNode.addChildNode(room_1050)
            scene.rootNode.addChildNode(room_1060)
            scene.rootNode.addChildNode(room_Restroom1)
            scene.rootNode.addChildNode(room_Restroom2)
            scene.rootNode.addChildNode(room_1080)
            scene.rootNode.addChildNode(room_1090)
            scene.rootNode.addChildNode(room_1120)
            scene.rootNode.addChildNode(room_1140)
            
            
            //hallway node
            let hallway_node_1 = createSphereNode(position: SCNVector3(x: -316.88682, y: -207.79708, z: 1))
            let hallway_node_2 = createSphereNode(position: SCNVector3(x: -326.44094, y: -119.81823, z: 1))
            let hallway_node_3 = createSphereNode(position: SCNVector3(x: -332.21573, y: 17.67194, z: 1))
            let hallway_node_4 = createSphereNode(position: SCNVector3(x: -336.39678, y: 57.01179, z: 1))
            let hallway_node_5 = createSphereNode(position: SCNVector3(x: -374.92085, y: 57.01115, z: 1))
            let hallway_node_6 = createSphereNode(position: SCNVector3(x: -336.41508, y: 80.01565, z: 1))
            let hallway_node_7 = createSphereNode(position: SCNVector3(x: -255.83996, y: 80.07974, z: 1))
            let hallway_node_8 = createSphereNode(position: SCNVector3(x: -204.65950, y: 80.07974, z: 1))
            let hallway_node_9 = createSphereNode(position: SCNVector3(x: -204.65950, y: 156.09364, z: 1))
            let hallway_node_10 = createSphereNode(position: SCNVector3(x: 156.09364, y: 156.09364, z: 1))
            let hallway_node_11 = createSphereNode(position: SCNVector3(x: -336.39678, y: 156.09364, z: 1))
            let hallway_node_12 = createSphereNode(position: SCNVector3(x: -336.37420, y: 249.97607, z: 1))
            let hallway_node_13 = createSphereNode(position: SCNVector3(x: -336.41508, y: 335.61034, z: 1))
            let hallway_node_14 = createSphereNode(position: SCNVector3(x: -336.39678, y: 382.72495, z: 1))
            let hallway_node_15 = createSphereNode(position: SCNVector3(x: -350.00000, y: 390.00000, z: 1))
            let hallway_node_16 = createSphereNode(position: SCNVector3(x: -270.26898, y: 382.69360, z: 1))
            let hallway_node_17 = createSphereNode(position: SCNVector3(x: -190.46448, y: 382.65575, z: 1))
            let hallway_node_18 = createSphereNode(position: SCNVector3(x: -109.67011, y: 382.65575, z: 1))
            let hallway_node_19 = createSphereNode(position: SCNVector3(x: -29.93861, y: 382.65575, z: 1))
            let hallway_node_20 = createSphereNode(position: SCNVector3(x: -37.66262, y: 355.10710, z: 1))
            let hallway_node_21 = createSphereNode(position: SCNVector3(x: -37.69696, y: 289.54443, z: 1))
            let hallway_node_22 = createSphereNode(position: SCNVector3(x: -37.70485, y: 274.48047, z: 1))
            let hallway_node_23 = createSphereNode(position: SCNVector3(x: -37.77841, y: 134.03087, z: 1))
            let hallway_node_24 = createSphereNode(position: SCNVector3(x: -37.67979, y: 118.07604, z: 1))
            let hallway_node_25 = createSphereNode(position: SCNVector3(x: -41.39681, y: 17.67194, z: 1))
            let hallway_node_26 = createSphereNode(position: SCNVector3(x: -222.04513, y: 17.67194, z: 1))
            let hallway_node_27 = createSphereNode(position: SCNVector3(x: 60.00000, y: 17.67194, z: 1))
            let hallway_node_28 = createSphereNode(position: SCNVector3(x: 60.00000, y: 117.62914, z: 1))
            let hallway_node_29 = createSphereNode(position: SCNVector3(x: 60.00000, y: 133.57898, z: 1))
            let hallway_node_30 = createSphereNode(position: SCNVector3(x: 60.00000, y: 275.00000, z: 1))
            let hallway_node_31 = createSphereNode(position: SCNVector3(x: 60.00000, y: 290.00000, z: 1))
            let hallway_node_32 = createSphereNode(position: SCNVector3(x: 60.00000, y: 355.00000, z: 1))
            let hallway_node_33 = createSphereNode(position: SCNVector3(x: 60.00000, y: 385.00000, z: 1))
            let hallway_node_34 = createSphereNode(position: SCNVector3(x: 50.16113, y: 398.15617, z: 1))
            let hallway_node_35 = createSphereNode(position: SCNVector3(x: 132.03713, y: 385.00000, z: 1))
            let hallway_node_36 = createSphereNode(position: SCNVector3(x: 211.78631, y: 385.00000, z: 1))
            let hallway_node_37 = createSphereNode(position: SCNVector3(x: 270.00000, y: 385.00000, z: 1))
            let hallway_node_38 = createSphereNode(position: SCNVector3(x: 292.18104, y: 385.00000, z: 1))
            let hallway_node_39 = createSphereNode(position: SCNVector3(x: 377.01630, y: 378.80193, z: 1))
            let hallway_node_40 = createSphereNode(position: SCNVector3(x: 413.37644, y: 305.37785, z: 1))
            let hallway_node_41 = createSphereNode(position: SCNVector3(x: 413.37644, y: 250.00000, z: 1))
            let hallway_node_42 = createSphereNode(position: SCNVector3(x: 413.37644, y: 150.00000, z: 1))
            let hallway_node_43 = createSphereNode(position: SCNVector3(x: 413.37644, y: 96.28097, z: 1))
            let hallway_node_44 = createSphereNode(position: SCNVector3(x: 413.37644, y: 46.09639, z: 1))
            let hallway_node_45 = createSphereNode(position: SCNVector3(x: 370.17192, y: 41.93531, z: 1))
            let hallway_node_46 = createSphereNode(position: SCNVector3(x: 260.91728, y: 33.65788, z: 1))
            let hallway_node_47 = createSphereNode(position: SCNVector3(x: 253.23519, y: 135.05455, z: 1))
            let hallway_node_48 = createSphereNode(position: SCNVector3(x: 203.81004, y: 29.33128, z: 1))
            let hallway_node_49 = createSphereNode(position: SCNVector3(x: 101.53258, y: 14.42112, z: 1))
            let hallway_node_50 = createSphereNode(position: SCNVector3(x: 269.43618, y: -78.78393, z: 1))
            let hallway_node_51 = createSphereNode(position: SCNVector3(x: 269.43618, y: -130.00000, z: 1))
            let hallway_node_52 = createSphereNode(position: SCNVector3(x: 269.43618, y: -206.08893, z: 1))
            let hallway_node_53 = createSphereNode(position: SCNVector3(x: 176.81055, y: -203.90124, z: 1))
            let hallway_node_54 = createSphereNode(position: SCNVector3(x: 176.02258, y: -237.26336, z: 1))
            let hallway_node_55 = createSphereNode(position: SCNVector3(x: 135.75024, y: -204.99509, z: 1))
            let hallway_node_56 = createSphereNode(position: SCNVector3(x: 10.00000, y: -204.99509, z: 1))
            let hallway_node_57 = createSphereNode(position: SCNVector3(x: -155.40329, y: -203.90124, z: 1))
            let hallway_node_58 = createSphereNode(position: SCNVector3(x: -155.40329, y: -271.64637, z: 1))
            let hallway_node_59 = createSphereNode(position: SCNVector3(x: -235.04113, y: -212.58353, z: 1))

            scene.rootNode.addChildNode(hallway_node_1)
            scene.rootNode.addChildNode(hallway_node_2)
            scene.rootNode.addChildNode(hallway_node_3)
            scene.rootNode.addChildNode(hallway_node_4)
            scene.rootNode.addChildNode(hallway_node_5)
            scene.rootNode.addChildNode(hallway_node_6)
            scene.rootNode.addChildNode(hallway_node_7)
            scene.rootNode.addChildNode(hallway_node_8)
            scene.rootNode.addChildNode(hallway_node_9)
            scene.rootNode.addChildNode(hallway_node_10)
            scene.rootNode.addChildNode(hallway_node_11)
            scene.rootNode.addChildNode(hallway_node_12)
            scene.rootNode.addChildNode(hallway_node_13)
            scene.rootNode.addChildNode(hallway_node_14)
            scene.rootNode.addChildNode(hallway_node_15)
            scene.rootNode.addChildNode(hallway_node_16)
            scene.rootNode.addChildNode(hallway_node_17)
            scene.rootNode.addChildNode(hallway_node_18)
            scene.rootNode.addChildNode(hallway_node_19)
            scene.rootNode.addChildNode(hallway_node_20)
            scene.rootNode.addChildNode(hallway_node_21)
            scene.rootNode.addChildNode(hallway_node_22)
            scene.rootNode.addChildNode(hallway_node_23)
            scene.rootNode.addChildNode(hallway_node_24)
            scene.rootNode.addChildNode(hallway_node_25)
            scene.rootNode.addChildNode(hallway_node_26)
            scene.rootNode.addChildNode(hallway_node_27)
            scene.rootNode.addChildNode(hallway_node_28)
            scene.rootNode.addChildNode(hallway_node_29)
            scene.rootNode.addChildNode(hallway_node_30)
            scene.rootNode.addChildNode(hallway_node_31)
            scene.rootNode.addChildNode(hallway_node_32)
            scene.rootNode.addChildNode(hallway_node_33)
            scene.rootNode.addChildNode(hallway_node_34)
            scene.rootNode.addChildNode(hallway_node_35)
            scene.rootNode.addChildNode(hallway_node_36)
            scene.rootNode.addChildNode(hallway_node_37)
            scene.rootNode.addChildNode(hallway_node_38)
            scene.rootNode.addChildNode(hallway_node_39)
            scene.rootNode.addChildNode(hallway_node_40)
            scene.rootNode.addChildNode(hallway_node_41)
            scene.rootNode.addChildNode(hallway_node_42)
            scene.rootNode.addChildNode(hallway_node_43)
            scene.rootNode.addChildNode(hallway_node_44)
            scene.rootNode.addChildNode(hallway_node_45)
            scene.rootNode.addChildNode(hallway_node_46)
            scene.rootNode.addChildNode(hallway_node_47)
            scene.rootNode.addChildNode(hallway_node_48)
            scene.rootNode.addChildNode(hallway_node_49)
            scene.rootNode.addChildNode(hallway_node_50)
            scene.rootNode.addChildNode(hallway_node_51)
            scene.rootNode.addChildNode(hallway_node_52)
            scene.rootNode.addChildNode(hallway_node_53)
            scene.rootNode.addChildNode(hallway_node_54)
            scene.rootNode.addChildNode(hallway_node_55)
            scene.rootNode.addChildNode(hallway_node_56)
            scene.rootNode.addChildNode(hallway_node_57)
            scene.rootNode.addChildNode(hallway_node_58)
            scene.rootNode.addChildNode(hallway_node_59)
            
            
            /* 노드 간 선 그리기
            let line1 = createLine(from: node1.position, to: node2.position)
            let line2 = createLine(from: node2.position, to: node3.position)
            
            scene.rootNode.addChildNode(line1)
            scene.rootNode.addChildNode(line2)
            */
                
            /*
            let overViewCamNode = SCNNode()
            overViewCamNode.camera = SCNCamera()
            overViewCamNode.position = SCNVector3(x: 0, y: 4000, z: 0)
            overViewCamNode.eulerAngles = SCNVector3(x: -.pi / 2, y: 0, z: 0)
            overViewCamNode.look(at: SCNVector3(x: 0, y: 0, z: 0))
            overViewCamNode.camera?.usesOrthographicProjection = true
            //mapNode.addChildNode(overViewCamNode)
             */
        }

        print(scene.rootNode.scale)
        print(scene.rootNode.boundingBox)
        
        

        return scene
    }
    
    func createSphereNode(position: SCNVector3) -> SCNNode {
        let sphere = SCNSphere(radius: 10)
        sphere.firstMaterial?.diffuse.contents = UIColor.red

        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.position = position

        return sphereNode
    }
    
    func createLine(from: SCNVector3, to: SCNVector3) -> SCNNode {
        let vertices = [from, to]
        
        let vertexSource = SCNGeometrySource(vertices: vertices)
        let indices: [Int32] = [0, 1]
        let indexData = Data(bytes: indices, count: indices.count * MemoryLayout<Int32>.size)
        let geometryElement = SCNGeometryElement(data: indexData,
                                                 primitiveType: .line,
                                                 primitiveCount: 1,
                                                 bytesPerIndex: MemoryLayout<Int32>.size)
        
        let lineGeometry = SCNGeometry(sources: [vertexSource], elements: [geometryElement])
        lineGeometry.firstMaterial?.diffuse.contents = UIColor.yellow
        lineGeometry.firstMaterial?.isDoubleSided = true
        
        let lineNode = SCNNode(geometry: lineGeometry)
        return lineNode
    }
    
    func loadUSDZModel(named name: String) -> SCNNode? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "usdz")
        else {
            print("Failed to find USDZ file: \(name).usdz")
            return nil
        }

        do {
            let mapScene = try SCNScene(url: url, options: nil)
        
            // Copy the rootNode of Scene to mapNode
            let mapNode = SCNNode()
            for child in mapScene.rootNode.childNodes {
                mapNode.addChildNode(child)
            }

            // set the position and scale for mapNode
            mapNode.position = SCNVector3(0, 0, 0)
            mapNode.scale = SCNVector3(0.01, 0.01, 0.01) // 1/100 scale

            // set name of mapNode
            mapNode.name = selectedMap?.name

            return mapNode
        } catch {
            print("Failed to load USDZ file: \(error)")
            return nil
        }
    }

    
    private func loadScene() {

        guard let selectedMap = selectedMap else {
            scene = nil
            return
        }
        
        let mapScene = createMapScene(mapName: selectedMap.name)
       
        DispatchQueue.main.async {
            self.scene = mapScene
        }
            
    }
}
