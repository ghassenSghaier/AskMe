import UIKit


extension UIColor {
    
    static func random( ofCount: Int) -> [ UIColor] {
        
        let between =  {
            (from: Int, through: Int) -> CGFloat in
                let d = through - from
                return CGFloat(
                            Int(  arc4random_uniform( UInt32(d+1)))
                        )
        }
        
        var colors: [ UIColor] = []
        for _ in 0..<ofCount {
            let red: CGFloat = between( 0, 255)
            let green: CGFloat = between( 0, 255)
            let blue: CGFloat = between( 0, 255)
            
            let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
            colors.append( color)
        }
        
        return colors
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

