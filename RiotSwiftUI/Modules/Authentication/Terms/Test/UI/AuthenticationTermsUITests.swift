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

import XCTest
import RiotSwiftUI

class AuthenticationTermsUITests: MockScreenTest {

    override class var screenType: MockScreenState.Type {
        return MockAuthenticationTermsScreenState.self
    }

    override class func createTest() -> MockScreenTest {
        return AuthenticationTermsUITests(selector: #selector(verifyAuthenticationTermsScreen))
    }

    func verifyAuthenticationTermsScreen() throws {
        guard let screenState = screenState as? MockAuthenticationTermsScreenState else { fatalError("no screen") }
        switch screenState {
        case .matrixDotOrg:
            verifyTerms(accepted: false)
        case .accepted:
            verifyTerms(accepted: true)
        case .multiple:
            verifyTerms(accepted: false)
        }
    }
    
    func verifyTerms(accepted: Bool) {
        let nextButton = app.buttons["nextButton"]
        XCTAssertTrue(nextButton.exists, "The next button should always exist.")
        XCTAssertEqual(nextButton.isEnabled, accepted, "The next button should be enabled when the terms are accepted")
    }

}
