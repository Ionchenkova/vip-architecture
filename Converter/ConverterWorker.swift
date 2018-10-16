//
//  ConverterWorker.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import Foundation

final class ConverterWorker {

    private let _converter: ConverterProtocol = Converter(with: Solution())

    func convert(firstNumber: String, firstSystem: Int, secondSystem: Int) -> String {

        let converterNumberModel = ConverterNumberModel(firstNumber: firstNumber,
                                                        firstSystem: firstSystem,
                                                        secondSystem: secondSystem)
        return _converter.convert(converterNumberModel)
    }

    func correctingSymbols(firstNumber: String) -> String? {
        return firstNumber.last == "." ? firstNumber + "0" : nil
    }

    func getAvailableSymbols(for numberSystem: Int) -> [String] {
        return _converter.getAvailableSymbols(for: numberSystem)
    }

    func getSolution() -> SolutionProtocol? {
        return _converter.getSolution()
    }

    func isRightNumber(_ number: String, system: Int) -> Bool {
        var availableSymbols = _converter.getAvailableSymbols(for: system)
        availableSymbols.append(".")
        let notAvailableSymbols = number.filter { !availableSymbols.contains(String($0)) }
        return notAvailableSymbols.isEmpty
    }

    func isRightSystem(_ system: Int) -> Bool {
        return 2...36 ~= system
    }
}
