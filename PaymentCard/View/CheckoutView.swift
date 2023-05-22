//
//  CheckoutView.swift
//  PaymentCard
//
//  Created by Polina Smirnova on 07.05.2023.
//

//import UIKit
//import StripePaymentsUI
//
//class CheckoutViewController: UIViewController {
//    var paymentIntentClientSecret: String?
//    let checkoutController = CheckoutController()
//    
// var cardTextField: STPPaymentCardTextField = {
//        let cardTextField = STPPaymentCardTextField()
//        cardTextField.isUserInteractionEnabled = true
//        cardTextField.isEnabled = true
//        return cardTextField
//    }()
//var payButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.isEnabled = true
//        button.isUserInteractionEnabled = true
//        button.layer.cornerRadius = 5
//        button.backgroundColor = .systemBlue
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 22)
//        button.setTitle("Pay", for: .normal)
//       
//        return button
//    }()
//    
//func setupView() {
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
//    }
//}
