import Foundation
import CoreLocation
import Combine

class HeadingProvider: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var heading: CLLocationDirection = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.headingAvailable() {
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.startUpdatingHeading()
        } else {
            print("나침반 사용 불가")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        DispatchQueue.main.async {
            self.heading = newHeading.magneticHeading
        }
    }

    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func directionText(for heading: CLLocationDirection) -> Double {
        var direction = ""
        var headingDegree = heading.truncatingRemainder(dividingBy: 360.0)
        
        switch heading {
        case 0..<22.5, 337.5..<360.0:
            direction = "North"
        case 22.5..<67.5:
            direction = "NorthEast"
        case 67.5..<112.5:
            direction = "East"
        case 112.5..<157.5:
            direction = "SouthEast"
        case 157.5..<202.5:
            direction = "South"
        case 202.5..<247.5:
            direction = "SouthWest"
        case 247.5..<292.5:
            direction = "West"
        case 292.5..<337.5:
            direction = "NorthWest"
        default:
            direction = "?"
        }
        
        return headingDegree
    }
}
