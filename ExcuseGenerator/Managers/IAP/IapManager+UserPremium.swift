//
//  IapManager+UserPremium.swift
//  ExcuseGenerator
//
//  Created by Daniel Fernandez Yopla on 12.07.2022.
//

import Combine

protocol IapManagerUserPremium {
    var isUserPremium: AnyPublisher<Bool, Never> { get }
}
