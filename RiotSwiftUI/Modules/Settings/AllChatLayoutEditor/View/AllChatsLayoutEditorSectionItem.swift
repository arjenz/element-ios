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

import SwiftUI

struct AllChatsLayoutEditorSectionItem: View {
    // MARK: - Properties
    
    // MARK: Private
    
    @Environment(\.theme) private var theme: ThemeSwiftUI
    
    private var tintColor: Color {
        section.selected ? theme.colors.background : theme.colors.secondaryContent
    }
    
    private var backColor: Color {
        section.selected ? theme.colors.accent : theme.colors.background
    }
    
    // MARK: Public
    
    var section: AllChatsLayoutEditorSection
    
    @ViewBuilder
    var body: some View {
        VStack {
            Image(uiImage: section.image)
                .renderingMode(.template)
                .foregroundColor(tintColor)
            Text(section.name)
                .foregroundColor(tintColor)
                .font(theme.fonts.callout)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .frame(minWidth: 100, minHeight: 64)
        .background(backColor)
        .cornerRadius(16)
    }
}

struct AllChatLayoutEditorSectionItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            preview
            .background(Color.gray)
            preview
            .theme(.dark)
            .preferredColorScheme(.dark)
        }
        .padding()
    }
    
    private static var preview: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                AllChatsLayoutEditorSectionItem(section: AllChatsLayoutEditorSection(type: .favourites, name: VectorL10n.titleFavourites, image: Asset.Images.tabFavourites.image, selected: false))
                AllChatsLayoutEditorSectionItem(section: AllChatsLayoutEditorSection(type: .recents, name: VectorL10n.allChatsEditLayoutRecents, image: Asset.Images.allChatRecents.image, selected: false))
            }
            
            HStack(spacing: 16) {
                AllChatsLayoutEditorSectionItem(section: AllChatsLayoutEditorSection(type: .favourites, name: VectorL10n.titleFavourites, image: Asset.Images.tabFavourites.image, selected: true))
                AllChatsLayoutEditorSectionItem(section: AllChatsLayoutEditorSection(type: .recents, name: VectorL10n.allChatsEditLayoutRecents, image: Asset.Images.allChatRecents.image, selected: true))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
