//
//  ConverterPresenter.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import UIKit

protocol ConverterPresentationLogic {

    func firstSetup(_ response: ConverterModel.FirstSetup.Response)
    func presentResult(_ response: ConverterModel.ConvertNumberModel.Response)
    func presentIncorrectAlert(_ response: ConverterModel.AlertModel.Response)
    func presentIncorrectSystemAlert(_ response: ConverterModel.AlertModel.Response)
    func presentChangedNumber(_ response: ConverterModel.CorrectNumber.Response)
}

final class ConverterPresenter: ConverterPresentationLogic {

    weak var viewController: ConverterDisplayLogic?

    // MARK: - Presentation logic

    func firstSetup(_ response: ConverterModel.FirstSetup.Response) {

        let avaliableCharactersForNumberSystem = Set(Array(0...9).map { String($0) })

        viewController?.firstSetup(.init(displaySolutionButton: false,
                                         avaliableCountForNumber: Default.Constats.maximumCountNumber,
                                         avaliableCountForNumberSystem: 2,
                                         avaliableCharactersForNumberSystem: avaliableCharactersForNumberSystem))
    }

    func presentResult(_ response: ConverterModel.ConvertNumberModel.Response) {
        viewController?.displayResult(.init(result: response.result, displaySolutionButton: true))
    }

    func presentIncorrectAlert(_ response: ConverterModel.AlertModel.Response) {
        viewController?.displayIncorrectAlert(.init(title: NSLocalizedString("incorrect_symbols", comment: ""),
                                                    message: NSLocalizedString("incorrect_symbols_description", comment: "")))
    }

    func presentIncorrectSystemAlert(_ response: ConverterModel.AlertModel.Response) {
        viewController?.displayIncorrectAlert(.init(title: NSLocalizedString("incorrect_number_system", comment: ""),
                                                    message: NSLocalizedString("number_system_rule", comment: "")))
    }

    func presentChangedNumber(_ response: ConverterModel.CorrectNumber.Response) {
        viewController?.displayChangedNumber(.init(newNumber: response.newNumber))
    }
}
