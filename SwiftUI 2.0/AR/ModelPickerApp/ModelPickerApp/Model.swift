//
//  Model.swift
//  ModelPickerApp
//
//  Created by Jack Wong on 6/30/20.
//

import UIKit
import RealityKit
import Combine

class Model {
    var modelName: String
    var image: UIImage?
    var modelEntity: ModelEntity?
    
    private var cancalleable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)
        
        let filename = modelName + ".usdz"
        self.cancalleable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { (loadCompletion) in
                //Handle Error
                print("DEBUG: Unable to load modelEntity for modelName: \(self.modelName)")
            }, receiveValue: { (modelEntity) in
                self.modelEntity = modelEntity
                print("DEBUG: Successfully loaded modelEntity for modelName: \(self.modelName)")
            })
    }
}
