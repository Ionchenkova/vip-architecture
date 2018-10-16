//
//  ConverterRouter.swift
//  NSystem
//
//  Created by Maria Ionchenkova.
//  Copyright (c) 2018 DevIon. All rights reserved.
//

import UIKit

protocol ConverterRoutingLogic {
    func routeToSomewhere(segue: UIStoryboardSegue)
    func displaySolution()
}

protocol ConverterDataPassing {
    var dataStore: ConverterDataStore? { get }
}

final class ConverterRouter: ConverterRoutingLogic, ConverterDataPassing {

    private let _solutionSegueName = "SolutionSegue"

    weak var viewController: ConverterViewController?
    var dataStore: ConverterDataStore?

    // MARK: - Routing

    func routeToSomewhere(segue: UIStoryboardSegue) {

        switch segue.identifier {
        case _solutionSegueName?:

            guard let destinationController = segue.destination as? MVCSolutionViewController else { return }

            destinationController.solution = dataStore?.solution
            destinationController.delegate = self

        default: break
        }
    }

    // MARK: - Navigation

    func displaySolution() {
        viewController?.performSegue(withIdentifier: _solutionSegueName, sender: nil)
    }
}

extension ConverterRouter: MVCSolutionViewControllerDelegate {

    func controllerWantsClose(_ controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
