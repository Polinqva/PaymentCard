//
//  StripeService.swift
//  PaymentCard
//
//  Created by Polina Smirnova on 06.05.2023.
//

import Alamofire

class StripeService {
    
    static let shared = StripeService()
    private let paymentURL = "http://localhost:8888/new_file.php"
    
    func makePayment(with amount: Int, completion: @escaping (String?) -> Void) {
        AF.request(paymentURL, method: .post, parameters: ["amount": amount])
            .validate(statusCode: 200..<300)
            .responseDecodable(of: PaymentResponse.self) { response in
                switch response.result {
                case .success(let paymentResponse):
                    completion(paymentResponse.clientSecret)
                case .failure(let error):
                    completion(nil)
                    print(error.localizedDescription)
                }
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Response string: \(responseString)")
                }
            }
    }
}

struct PaymentResponse: Codable {
    let clientSecret: String
    
    enum CodingKeys: String, CodingKey {
        case clientSecret = "client_secret"
    }
}
