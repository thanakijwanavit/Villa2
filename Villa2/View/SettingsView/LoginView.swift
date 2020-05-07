

import UIKit
import SwiftUI
import AuthenticationServices

struct LoginView: View {
  @Environment(\.window) var window: UIWindow?
  @EnvironmentObject var user: CurrentUser
  @Binding var showLogin:Bool
  @State var appleSignInDelegates: SignInWithAppleDelegates! = nil

  var body: some View {
    ZStack {
        Color(.secondarySystemFill).edgesIgnoringSafeArea(.all)

        VStack(spacing: 10) {
        Image("VillaLogo1")
        .resizable()
        .scaledToFit()

//        UserAndPassword()
//        .padding()

        SignInWithApple()
        .frame(width: 280, height: 60)
        .onTapGesture(perform: showAppleLogin)
    
            
        LoginWithFB()
        .frame(width: 280, height: 60)
            
            
        SignUp()
        .frame(width: 280, height: 60)
            
            
        LoginDebugButton(showLogin: self.$showLogin)

      }
    }
    .onAppear {
      self.performExistingAccountSetupFlows()
    }
  }

  private func showAppleLogin() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]

    performSignIn(using: [request])
  }

  /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
  private func performExistingAccountSetupFlows() {
    #if !targetEnvironment(simulator)
    // Note that this won't do anything in the simulator.  You need to
    // be on a real device or you'll just get a failure from the call.
    let requests = [
      ASAuthorizationAppleIDProvider().createRequest(),
      ASAuthorizationPasswordProvider().createRequest()
    ]

    performSignIn(using: requests)
    #endif
  }

  private func performSignIn(using requests: [ASAuthorizationRequest]) {
    appleSignInDelegates = SignInWithAppleDelegates(window: window) { success in
      if success {
        // update UI
        debugPrint("sign in successful")
        
      } else {
        // show the user an error
        debugPrint("sign in error")
      }
    }

    let controller = ASAuthorizationController(authorizationRequests: requests)
    controller.delegate = appleSignInDelegates
    controller.presentationContextProvider = appleSignInDelegates
    controller.performRequests()
  }
}

struct LoginDebugButton:View {
    @EnvironmentObject var user:CurrentUser
    @Binding var showLogin:Bool

    var body: some View {
        Button(action: {
            self.user.isLoggedIn.toggle()
            self.showLogin.toggle()
        }) {
            Text("debugLogin")
        }
        .frame(width: 280, height: 60)
        .background(Color.black)
        .foregroundColor(.white)
        .font(.headline)
    }
}


struct LoginWithFB:View {
    @EnvironmentObject var user:CurrentUser
    
    var body: some View {
        Button(action: {
            //
        }) {
                Image("FBLoginButton")
                    .renderingMode(.original)
                    .resizable()
        }
    }
}

struct SignUp:View {
@EnvironmentObject var user:CurrentUser

    var body: some View {
        Button(action: {
                self.user.isLoggedIn.toggle()
            }) {
                ZStack{
                    Color.gray
                    Text("Sign up")
                    .font(.headline)
                }
            }
        .buttonStyle(PlainButtonStyle())
        }
}


#if DEBUG
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
        LoginView(showLogin: .constant(true))
        .environmentObject(CurrentUser())
        .background(Color(.systemBackground))
        .environment(\.colorScheme, .dark)
        
        LoginView(showLogin: .constant(true))
        .environmentObject(CurrentUser())
        .background(Color(.systemBackground))
        .environment(\.colorScheme, .light)
    }
    
  }
}
#endif
