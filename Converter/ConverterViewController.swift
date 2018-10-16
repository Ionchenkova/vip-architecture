//
//  ConverterViewController.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import UIKit

protocol ConverterDisplayLogic: class {

    func displayResult(_ viewModel: ConverterModel.ConvertNumberModel.ViewModel)
    func firstSetup(_ viewModel: ConverterModel.FirstSetup.ViewModel)
    func displayIncorrectAlert(_ viewModel: ConverterModel.AlertModel.ViewModel)
    func displayChangedNumber(_ response: ConverterModel.CorrectNumber.ViewModel)
}

final class ConverterViewController: BaseViewController, ConverterDisplayLogic {

    @IBOutlet var firstNumber: InputLabel!
    @IBOutlet var firstNumberSystem: InputLabel!
    @IBOutlet var secondNumberSystem: InputLabel!
    @IBOutlet var solutionButton: UIButton!
    @IBOutlet var answer: UILabel!
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var equalLabel: UILabel!

    var interactor: ConverterBusinessLogic?
    var router: (ConverterRoutingLogic & ConverterDataPassing)?

    // MARK: - Lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        _setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        _setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupColors()
        interactor?.firstSetup(.init())
    }

    private func _setupColors() {

        view.backgroundColor = Default.Colors.baseColor

        firstNumber.textColor = Default.Colors.lightColor
        answer.textColor = Default.Colors.lightColor
        solutionButton.tintColor = Default.Colors.lightColor

        firstNumberSystem.textColor = Default.Colors.secondaryColor
        secondNumberSystem.textColor = Default.Colors.secondaryColor
        equalLabel.textColor = Default.Colors.secondaryColor
        convertButton.tintColor = Default.Colors.secondaryColor
    }

    // MARK: - Setup

    private func _setup() {
        let interactor = ConverterInteractor()
        let presenter = ConverterPresenter()
        let router = ConverterRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
        router.dataStore = interactor
    }

    // MARK: - Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        router?.routeToSomewhere(segue: segue)
    }

    // MARK: - Display logic

    func displayResult(_ viewModel: ConverterModel.ConvertNumberModel.ViewModel) {

        answer.text = viewModel.result
    }

    func getAvailableLetters(for numberSystem: InputLabel) -> [String]? {

        guard let number = numberSystem.getNumber() else { return nil }
        return interactor?.getAvailableLetters(for: number)
    }

    func firstSetup(_ viewModel: ConverterModel.FirstSetup.ViewModel) {
        
        firstNumber.maxCharactersCount = viewModel.avaliableCountForNumber

        firstNumberSystem.maxCharactersCount = viewModel.avaliableCountForNumberSystem
        secondNumberSystem.maxCharactersCount = viewModel.avaliableCountForNumberSystem

        firstNumberSystem.avaliableLetters = viewModel.avaliableCharactersForNumberSystem
        secondNumberSystem.avaliableLetters = viewModel.avaliableCharactersForNumberSystem
    }

    func displayIncorrectAlert(_ viewModel: ConverterModel.AlertModel.ViewModel) {
        self.displayStandartAlert(title: viewModel.title, message: viewModel.message)
    }

    func displayChangedNumber(_ response: ConverterModel.CorrectNumber.ViewModel) {
        firstNumber.text = response.newNumber
        convert()
    }

    // MARK: - Actions

    @IBAction func convert() {
        let converterModel = ConverterModel.ConvertNumbers(firstNumber: firstNumber.getNumber(),
                                                           firstSystem: firstNumberSystem.getNumber(),
                                                           secondSystem: secondNumberSystem.getNumber())
        interactor?.convertNumber(.init(convertNumbers: converterModel))
    }

    @IBAction func showSolution() {
        router?.displaySolution()
    }
}

extension ConverterViewController: InputLabelDelegate {
    
    func wasTouched(_ label: InputLabel) {
        
    }
}
