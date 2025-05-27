//
//  ContentView.swift
//  notifications
//
//  Created by Shaan on 23/05/25.
//


import SwiftUI
import SwiftMessages

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var pincode: String = ""

    @State private var showGoBackAlert = false

    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("REGISTRATION")
                    .bold()
                    .font(.system(size: 28))

                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .bold()
                    .padding(.horizontal)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .bold()

                TextField("Address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .bold()

                TextField("Pincode", text: $pincode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .bold()

                Button("Register") {
                    if name.isEmpty || email.isEmpty || address.isEmpty || pincode.isEmpty {
                        showErrorMessage("Please fill in all fields.")
                    } else {
                        showSuccessMessage()
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)

                Spacer()
            }
            .padding(.top)
            .navigationBarTitle("Register", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    showGoBackAlert = true
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Go Back")
                    }
                }
            )
            .alert(isPresented: $showGoBackAlert) {
                Alert(
                    title: Text("Are You Sure?"),
                    message: Text("Do you want to go back? Unsaved changes will be lost."),
                    primaryButton: .destructive(Text("Go Back")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }

    func showSuccessMessage() {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: "Success", body: "Registration completed!")
        view.button?.isHidden = true

        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 2)

        SwiftMessages.show(config: config, view: view)
    }

    func showErrorMessage(_ message: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.configureContent(title: "Error", body: message)
        view.button?.isHidden = true

        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.duration = .seconds(seconds: 3)

        SwiftMessages.show(config: config, view: view)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
