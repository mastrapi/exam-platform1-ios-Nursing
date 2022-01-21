//
//  PaygateManagerCore.swift
//  Explore
//
//  Created by Andrey Chernyshev on 27.08.2020.
//  Copyright © 2020 Andrey Chernyshev. All rights reserved.
//

import RxSwift

final class PaygateManagerCore: PaygateManager {
    private lazy var purchaseManager = PurchaseManager()
}

// MARK: Retrieve
extension PaygateManagerCore {
    func retrievePaygate() -> Single<PaygateMapper.PaygateResponse?> {
        RestAPITransport()
            .callServerApi(requestBody: GetPaygateRequest(userToken: SessionManagerCore().getSession()?.userToken,
                                                          version: UIDevice.appVersion ?? "1"))
            .map { PaygateMapper.parse(response: $0, productsPrices: nil) }
    }
}

// MARK: Prepare prices
extension PaygateManagerCore {
    func prepareProductsPrices(for paygate: PaygateMapper.PaygateResponse) -> Single<PaygateMapper.PaygateResponse?> {
        guard !paygate.productsIds.isEmpty else {
            return .deferred { .just(paygate) }
        }
        
        return purchaseManager
            .obtainProducts(ids: paygate.productsIds)
            .map { products -> [ProductPrice] in
                products.map { ProductPrice(product: $0.original) }
            }
            .map { PaygateMapper.parse(response: paygate.json, productsPrices: $0) }
    }
}
