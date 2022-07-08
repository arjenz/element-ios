// 
// Copyright 2022 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation

@available(iOS 14.0, *)
@objc protocol AllChatsLayoutEditorCoordinatorBridgePresenterDelegate {
    func allChatsLayoutEditorCoordinatorBridgePresenterDidCancel(_ coordinatorBridgePresenter: AllChatsLayoutEditorCoordinatorBridgePresenter)
    func allChatsLayoutEditorCoordinatorBridgePresenter(_ coordinatorBridgePresenter: AllChatsLayoutEditorCoordinatorBridgePresenter, didCompleteWith newSettings: AllChatsLayoutSettings)
}

/// `AllChatsLayoutEditorCoordinatorBridgePresenter` enables to start `AllChatsLayoutEditorCoordinator` from a view controller.
/// This bridge is used while waiting for global usage of coordinator pattern.
/// It breaks the Coordinator abstraction and it has been introduced for Objective-C compatibility (mainly for integration in legacy view controllers).
/// Each bridge should be removed once the underlying Coordinator has been integrated by another Coordinator.
@available(iOS 14.0, *)
@objcMembers
final class AllChatsLayoutEditorCoordinatorBridgePresenter: NSObject {
    
    // MARK: - Properties
    
    // MARK: Private
    
    private let settings: AllChatsLayoutSettings
    private let session: MXSession
    private var coordinator: AllChatsLayoutEditorCoordinator?
    private var router: NavigationRouterType?
    
    // MARK: Public
    
    weak var delegate: AllChatsLayoutEditorCoordinatorBridgePresenterDelegate?
    
    // MARK: - Setup
    
    init(settings: AllChatsLayoutSettings,
         session: MXSession) {
        self.settings = settings
        self.session = session
        super.init()
    }
    
    // MARK: - Public
    
    func present(from viewController: UIViewController, animated: Bool) {
        let navigationRouter = NavigationRouter()
        let coordinator = AllChatsLayoutEditorCoordinator(parameters: AllChatsLayoutEditorCoordinatorParameters(settings: settings, session: session))
        coordinator.completion = { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .cancel:
                self.delegate?.allChatsLayoutEditorCoordinatorBridgePresenterDidCancel(self)
            case .done(let newSettings):
                self.delegate?.allChatsLayoutEditorCoordinatorBridgePresenter(self, didCompleteWith: newSettings)
            }
        }
        let presentable = coordinator.toPresentable()
        navigationRouter.setRootModule(presentable)
        viewController.present(navigationRouter.toPresentable(), animated: animated, completion: nil)
        coordinator.start()
        
        self.coordinator = coordinator
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        guard let coordinator = self.coordinator else {
            return
        }
        coordinator.toPresentable().dismiss(animated: animated) {
            self.coordinator = nil

            if let completion = completion {
                completion()
            }
        }
    }
}
