//: Playground - noun: a place where people can play

import Cocoa
import Foundation

func capturedGroups(on string : String, withRegex pattern: String) -> [String] {
		var results = [String]()

		var regex: NSRegularExpression
		do {
		    regex = try NSRegularExpression(pattern: pattern, options: [])
		} catch {
		    return results
		}
		let matches = regex.matches(in: string, options: [], range: NSRange(location:0, length: string.count))

		guard let match = matches.first else { return results }

		let lastRangeIndex = match.numberOfRanges - 1
		guard lastRangeIndex >= 1 else { return results }

		for i in 1...lastRangeIndex {
		    let capturedGroupIndex = match.range(at: i)
		    let matchedString = (string as NSString).substring(with: capturedGroupIndex)
		    results.append(matchedString)
		}

		return results
}

do {
    let colors = try String(contentsOf: URL(fileURLWithPath : "colors.xml"))
    let pattern = "<color name=\"(\\w+)\">#([\\w+]{6})<\\/color>"
    for i in colors.split(separator : "\n"){
    	//static func red500() -> UIColor {return ColorUtils.UIColorFromRGB(rgbValue: 0x9C27B0)}
    	let colorNameAndColor = capturedGroups(on : String(i), withRegex : pattern)
    	print("static func \(colorNameAndColor[0])() -> UIColor {return ColorUtils.UIColorFromRGB(rgbValue: 0x\(colorNameAndColor[1]))}")
    }
}catch{
    print("Error \(error)")
}


