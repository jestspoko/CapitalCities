//
//  FlowController.swift
//  FriendlyScore
//
//  Created by Lukasz Czechowicz on 09.08.2017.
//  Copyright © 2017 Lukasz Czechowicz. All rights reserved.
//

import UIKit


/// Base protocol describing view controller's flow behavior
protocol FlowController {
    var childFlow: FlowController? {get set}
    var configure:FlowConfigure {get set}
    init(configure : FlowConfigure)
    func start()
}
