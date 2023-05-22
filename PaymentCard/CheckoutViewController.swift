//
//  CheckoutController.swift
//  PaymentCard
//
//  Created by Polina Smirnova on 06.05.2023.
//

import UIKit
import StripePaymentsUI

class CheckoutViewController: UIViewController {
    var paymentIntentClientSecret: String?
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        cardTextField.isUserInteractionEnabled = true
        cardTextField.isEnabled = true
        cardTextField.borderColor = .init(red: 0.07, green: 0.06, blue: 0.25, alpha: 1.00)
        cardTextField.backgroundColor = .init(red: 0.19, green: 0.20, blue: 0.42, alpha: 1.00)
        cardTextField.textColor = .init(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00)
        return cardTextField
    }()
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 5
        button.backgroundColor = .init(red: 0.07, green: 0.06, blue: 0.25, alpha: 1.00)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0.49, green: 0.84, blue: 0.87, alpha: 1.00)
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 40),
        ])
        startCheckout()
    }
    
    
    @objc
    func pay() {
        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
            return
        }
        UIView.animate(withDuration: 0.2) {
            self.payButton.alpha = 0.2
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.payButton.alpha = 1.0
            }
        }

        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = cardTextField.paymentMethodParams

        let paymentHandler = STPPaymentHandler.shared()
        paymentHandler.confirmPayment(paymentIntentParams, with: self) { (status, paymentIntent, error) in
            switch (status) {
            case .failed:
                self.displayAlert(title: "Payment failed", message: "Please, try again later")
                break
            case .canceled:
                self.displayAlert(title: "Payment canceled", message: "Sorry, your payment was canceled")
                break
            case .succeeded:
                self.displayAlert(title: "Payment succeeded", message: "Your payment was accepted. Thank you for being with us", restartDemo: true)
                break
            @unknown default:
                fatalError()
                break
            }
        }
    }
}
extension CheckoutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
    func startCheckout() {
        StripeService.shared.makePayment(with: 1099) { clientSecret in
            self.paymentIntentClientSecret = clientSecret
        }
    }
    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if restartDemo {
                let restartAction = UIAlertAction(title: "Restart demo", style: .default) { _ in
                    self.cardTextField.clear()
                    self.startCheckout()
                }
                alertController.addAction(restartAction)
            }
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
