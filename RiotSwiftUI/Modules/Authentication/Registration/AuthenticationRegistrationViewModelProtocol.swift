// 
// Copyright 2021 New Vector Ltd
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

protocol AuthenticationRegistrationViewModelProtocol {
    
    var callback: (@MainActor (AuthenticationRegistrationViewModelResult) -> Void)? { get set }
    var context: AuthenticationRegistrationViewModelType.Context { get }
    
    /// Update the view with new homeserver information.
    /// - Parameter homeserver: The view data for the homeserver. This can be generated using `AuthenticationService.Homeserver.viewData`.
    @MainActor func update(homeserver: AuthenticationHomeserverViewData)
    
    /// Update the view to confirm that the chosen username is available.
    /// - Parameter username: The username that was checked.
    @MainActor func confirmUsernameAvailability(_ username: String)
    
    /// Display an error to the user.
    /// - Parameter type: The type of error to be displayed.
    @MainActor func displayError(_ type: AuthenticationRegistrationErrorType)
}
