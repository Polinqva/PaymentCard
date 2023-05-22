////
////  ViewController.swift
////  PaymentCard
////
////  Created by Polina Smirnova on 06.05.2023.
////
//
//import UIKit
//import StripePaymentsUI
//
//class CheckoutViewController: UIViewController {
//    var paymentIntentClientSecret: String?
//    lazy var cardTextField: STPPaymentCardTextField = {
//        let cardTextField = STPPaymentCardTextField()
//        cardTextField.isUserInteractionEnabled = true
//        cardTextField.isEnabled = true
//        return cardTextField
//    }()
//    lazy var payButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.isEnabled = true
//        button.isUserInteractionEnabled = true
//        button.layer.cornerRadius = 5
//        button.backgroundColor = .systemBlue
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//        button.setTitle("Pay", for: .normal)
//        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
//        stackView.axis = .vertical
//        stackView.spacing = 20
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
//            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
//            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 24),
//        ])
//        startCheckout()
//    }
//    
//
//    @objc
//    func pay() {
//        guard let paymentIntentClientSecret = paymentIntentClientSecret else {
//            return
//        }
//        // Collect card details
//        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
//        paymentIntentParams.paymentMethodParams = cardTextField.paymentMethodParams
//        
//        // Submit the payment
//        let paymentHandler = STPPaymentHandler.shared()
//        paymentHandler.confirmPayment(paymentIntentParams, with: self) { (status, paymentIntent, error) in
//            switch (status) {
//            case .failed:
//                self.displayAlert(title: "Payment failed", message: "Payment failed. Try again later, please")
//                break
//            case .canceled:
//                self.displayAlert(title: "Payment canceled", message: "Sorry, your payment was canceled")
//                break
//            case .succeeded:
//                self.displayAlert(title: "Payment succeeded", message: "Your payment was accepted. Thank you for being with us", restartDemo: true)
//                break
//            @unknown default:
//                fatalError()
//                break
//            }
//        }
//    }
//}
//extension CheckoutViewController: STPAuthenticationContext {
//    func authenticationPresentingViewController() -> UIViewController {
//        return self
//    }
//
//     func startCheckout() {
//         StripeService.shared.makePayment(with: 1099) { clientSecret in
//              self.paymentIntentClientSecret = clientSecret
//          }
//     }
//    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
//        DispatchQueue.main.async {
//            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            if restartDemo {
//                let restartAction = UIAlertAction(title: "Restart demo", style: .default) { _ in
//                    self.cardTextField.clear()
//                    self.startCheckout()
//                }
//                alertController.addAction(restartAction)
//            }
//            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
//
//}
