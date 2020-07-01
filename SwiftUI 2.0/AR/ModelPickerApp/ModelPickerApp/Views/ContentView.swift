//
//  ContentView.swift
//  ModelPickerApp
//
//  Created by Jack Wong on 6/30/20.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView : View {
    
    @State private var isPlacementEnabled = false
    @State private var selectedModel: Model?
    @State private var modelConfirmedForPlacement: Model?
    @State private var showScrollView = true
    
    private var models: [Model] = {
        //Dynamically get our model filenames
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availableModels: [Model] = []
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            let model = Model(modelName: modelName)
            availableModels.append(model)
        }
        return availableModels
    }()
    
    
    var body: some View {
        ZStack (alignment: .bottom){
            ARViewContainer(modelConfirmedForPlacement: $modelConfirmedForPlacement)
            
            if isPlacementEnabled {
                PlacementButtonsView(isPlacementEnabled: $isPlacementEnabled, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
                
            }else {
//                ModelPickerView(isPlacementEnabled: $isPlacementEnabled, selectedModel: $selectedModel, models: models).opacity(showScrollView ? 1.0 : 0.0).animation(.easeIn(duration: 0.2))
                if showScrollView {
                    ModelPickerView(isPlacementEnabled: $isPlacementEnabled, selectedModel: $selectedModel, models: models).transition(.move(edge: .bottom))
                }
            }
        }.onTapGesture {
            if !isPlacementEnabled {
                withAnimation {
                    showScrollView.toggle()
                }
                print("DEBUG: Scroll view is now \(showScrollView ? "visible" : "hidden")")
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = FocusARView(frame: .zero)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if let model = modelConfirmedForPlacement {
            
            if let modelEntity = model.modelEntity {
                print("DEBUG: adding model to scene - \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .any)
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
                uiView.scene.addAnchor(anchorEntity)
            }else {
                print("DEBUG: Unable to load modelEntity for: \(model.modelName)")
            }
            
            DispatchQueue.main.async {
                modelConfirmedForPlacement = nil
            }
        }
    }
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


class FocusARView: ARView {
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        self.setupConfig()
        self.focusEntity = FocusEntity(on: self, style: .classic)
        
        setUpARView()
    }
    
    func setupConfig() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        session.run(config, options: [])
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpARView(){
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal,.vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        session.run(config)
    }
    
}

extension FocusARView: FocusEntityDelegate {
    func toTrackingState() {
        print("tracking")
    }
    func toInitializingState() {
        print("initializing")
    }
}


struct ModelPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    
    var models: [Model]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(0 ..< models.count) { index in
                    Button(action: {
                        print("DEBUG: selected model with name \(self.models[index].modelName)")
                        selectedModel = models[index]
                        isPlacementEnabled = true
                    }){
                        Image(uiImage: models[index].image)
                            .resizable()
                            .frame(height:80)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .frame(height: 80)
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

struct PlacementButtonsView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: Model?
    @Binding var modelConfirmedForPlacement: Model?
    
    var body: some View {
        HStack {
            // Cancel Button
            Button(action: {
                print("DEBUG: Model placement cancelled")
                resetPlacementParameters()
            }){
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(.all, 20)
            }
            
            //Confirm Button
            Button(action: {
                print("DEBUG: Model placement confirmed")
                modelConfirmedForPlacement = selectedModel
                resetPlacementParameters()
            }){
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(.all, 20)
            }
        }
    }
    
    func resetPlacementParameters() {
        isPlacementEnabled = false
        selectedModel = nil
    }
}
