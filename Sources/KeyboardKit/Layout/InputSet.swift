//
//  InputSet.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-03.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 An input set defines the input keys on a keyboard.
 
 Input sets can be used to create a ``KeyboardLayout`` which
 defines the full set of keys, that often include extra keys
 around the input rows and a bottom row. Layout also specify
 the size, insets and properties of each key.
 
 KeyboardKit has a couple of pre-defined input sets, such as
 standard ``qwerty``, a ``standardNumeric(currency:)`` and a
 ``standardSymbolic(currencies:)``. KeyboardKit Pro provides
 even more input sets like `qwertz` and `azerty`, as well as
 alphabetic, numeric and symbolic input sets for all locales.
 
 > v8.0: This protocol will be converted to a `struct`, that
 will replace the various input set types with a single type.
 */
public protocol InputSet: Equatable {
    
    var rows: InputSetRows { get }
}

public extension InputSet {
    
    static var english: AlphabeticInputSet { .qwerty }
    
    static var englishNumeric: NumericInputSet {
        .englishNumeric()
    }
    
    static func englishNumeric(
        currency: String = "$"
    ) -> NumericInputSet {
        .standardNumeric(currency: currency)
    }
    
    static var englishSymbolic: SymbolicInputSet {
        .englishSymbolic()
    }
    
    static func englishSymbolic(
        currency: String = "£"
    ) -> SymbolicInputSet {
        .standardSymbolic(currencies: "€\(currency)¥".chars)
    }
    
    static var qwerty: AlphabeticInputSet {
        .init(rows: [
            .init(chars: "qwertyuiop"),
            .init(chars: "asdfghjkl"),
            .init(phone: "zxcvbnm", pad: "zxcvbnm,.")
        ])
    }
    
    static func standardNumeric(currency: String) -> NumericInputSet {
        NumericInputSet(rows: [
            .init(chars: "1234567890"),
            .init(phone: "-/:;()\(currency)&@”", pad: "@#\(currency)&*()’”"),
            .init(phone: ".,?!’", pad: "%-+=/;:!?")
        ])
    }
    
    static func standardSymbolic(currencies: [String]) -> SymbolicInputSet {
        SymbolicInputSet(rows: [
            .init(phone: "[]{}#%^*+=", pad: "1234567890"),
            .init(
                phone: "_\\|~<>\(currencies.joined())•",
                pad: "\(currencies.joined())_^[]{}"),
            .init(phone: ".,?!’", pad: "§|~…\\<>!?")
        ])
    }
}

/**
 This input set can be used in alphabetic keyboards.
 
 > v8.0: This will be replaced by the upcoming `InputSet`.
 */
public struct AlphabeticInputSet: InputSet {

    /// Create an alphabetic input set.
    public init(rows: InputSetRows) {
        self.rows = rows
    }

    /// The rows in the input set.
    public var rows: InputSetRows
}

/**
 This input set can used in numeric keyboards.
 
 > v8.0: This will be replaced by the upcoming `InputSet`.
 */
public struct NumericInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}

/**
 This input set can be used in symbolic keyboards.
 
 > v8.0: This will be replaced by the upcoming `InputSet`.
 */
public struct SymbolicInputSet: InputSet {

    public init(rows: InputSetRows) {
        self.rows = rows
    }

    public var rows: InputSetRows
}
