//
//  ConverterInteractor.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import Foundation

protocol ConverterBusinessLogic {

    func convertNumber(_ request: ConverterModel.ConvertNumberModel.Request)
    func getAvailableLetters(for numberSystem: String) -> [String]
    func firstSetup(_ request: ConverterModel.FirstSetup.Request)
}

protocol ConverterDataStore {
    var solution: SolutionProtocol? { get }
}

final class ConverterInteractor: ConverterBusinessLogic, ConverterDataStore {

    var presenter: ConverterPresentationLogic?
    private let _worker = ConverterWorker()

    var solution: SolutionProtocol? {
        return _worker.getSolution()
    }

    // MARK: - Business logic

    func firstSetup(_ request: ConverterModel.FirstSetup.Request) {
        presenter?.firstSetup(.init())
    }

    func convertNumber(_ request: ConverterModel.ConvertNumberModel.Request) {

        _resetLastSolution()

        let convertNumbers = request.convertNumbers

        guard let firstNumber = convertNumbers.firstNumber,
            let firstSystem = convertNumbers.firstSystem,
            let firstIntSystem = Int(firstSystem),
            let secondSystem = convertNumbers.secondSystem,
            let secondIntSystem = Int(secondSystem) else { return }

        if let firstCorrectNumber = _worker.correctingSymbols(firstNumber: firstNumber) {
            presenter?.presentChangedNumber(.init(newNumber: firstCorrectNumber))
            return
        }

        guard _worker.isRightSystem(firstIntSystem), _worker.isRightSystem(secondIntSystem) else {
            presenter?.presentIncorrectSystemAlert(.init())
            return
        }

        guard _worker.isRightNumber(firstNumber, system: firstIntSystem) else {
            presenter?.presentIncorrectAlert(.init())
            return
        }

        let result = _worker.convert(firstNumber: firstNumber, firstSystem: firstIntSystem, secondSystem: secondIntSystem)
        presenter?.presentResult(.init(result: result))
    }

    func getAvailableLetters(for numberSystem: String) -> [String] {

        guard let system = Int(numberSystem) else { return [] }
        return _worker.getAvailableSymbols(for: system)
    }

    private func _resetLastSolution() {
        solution?.reset()
    }
}

