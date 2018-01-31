//: Playground - noun: a place where people can play

import UIKit

// Array - an ordered collection of elements
var numArray: Array<Int>
var boolArray: [Bool]

// Initializing an array
var intArray = [Int]()
var weatherArray = ["sunshine", "rain", "cloudy"]

// Accessing array elements.
print("The first element of weatherArray is \(weatherArray[0])")
print("weatherArray has \(weatherArray.count) elements")
print("The last element of weatherArray is \(weatherArray[weatherArray.count-1])")

// Cannot access out of bounds indices.
// weatherArray[4]

// Adding to an array
intArray.append(1)
intArray += [3, 6, 3, 6, 2]
intArray.insert(5, at: 3)

// Removing from an array
intArray.remove(at: 1)

// Iterating over an array - the for-in loop
for weather in weatherArray {
    if weather == "sunshine" {
        print("omg i miss norcal weather")
    } else {
        print("wtf i didn't come to LA for this")
    }
}
