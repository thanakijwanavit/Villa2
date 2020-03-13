//
//  ActionList.swift
//  Villa2
//
//  Created by nic Wanavit on 3/13/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

import SwiftUI

struct ActionList: View {
    var actions:[Action] = [
        Action(name: "call", pageName: "call", image: Image(systemName: "phone")),
        Action(name: "message", pageName: "message", image: Image(systemName: "message")),
        Action(name: "video", pageName: "video call", image: Image(systemName: "video"))
    ]
    var body: some View {
        VStack(spacing: 20){
            ForEach(actions, id: \.name){ action in
                AnyView{
                    HStack{
                        Text(action.name)
                        
                    }
                }
            }
        }
    }
}

struct ActionList_Previews: PreviewProvider {
    static var previews: some View {
        ActionList()
    }
}
