//
//  ConverterModels.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import UIKit

struct ConverterModel {

    struct ConvertNumbers {
        var firstNumber: String?
        var firstSystem: String?
        var secondSystem: String?
    }

    struct ConvertNumberModel {

        struct Request {
            var convertNumbers: ConvertNumbers
        }
        struct Response {
            var result: String
        }
        struct ViewModel {
            var result: String
            var displaySolutionButton: Bool
        }
    }

    struct FirstSetup {

        struct Request { }
        struct Response { }
        struct ViewModel {
            var displaySolutionButton: Bool
            var avaliableCountForNumber: Int
            var avaliableCountForNumberSystem: Int
            var avaliableCharactersForNumberSystem: Set<String>
        }
    }

    struct Solution {

        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    struct AlertModel {
        
        struct Request {}
        struct Response {}
        struct ViewModel {
            let title: String
            let message: String
        }
    }

    struct CorrectNumber {
        
        struct Request {}
        struct Response {
            let newNumber: String
        }
        struct ViewModel {
            let newNumber: String
        }
    }
}
