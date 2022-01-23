//
//  ActivityFormView.swift
//  ActivitySampling
//
//  Created by Falko Schumann on 07.01.22.
//

import SwiftUI

struct ActivityFormView: View {
    @Binding var disabled: Bool
    @Binding var activity: String
    @FocusState var activityFocused: Bool
    
    let log: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Activity:")
            TextField("What are you working on?", text: $activity)
                .disabled(disabled)
                .focused($activityFocused)
                .onSubmit { log() }
                .onChange(of: disabled) { newValue in
                    if (!newValue) {
                        activityFocused = true
                    }
                }
            Button(action: { log() }) {
                Text("Log").frame(maxWidth: .infinity)
            }
            .disabled(disabled)
        }
    }
}

struct ActivityFormView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityFormView(disabled: .constant(false), activity: .constant(""), log: {})
                .previewDisplayName("empty, enabled")
                .frame(width: 300)
            ActivityFormView(disabled: .constant(false), activity: .constant("Lorem ipsum"), log: {})
                .previewDisplayName("filled out, enabled")
                .frame(width: 300)
            ActivityFormView(disabled: .constant(true), activity: .constant(""), log: {})
                .previewDisplayName("empty, disabled")
                .frame(width: 300)
        }
    }
}
