//
//  ModalViewIndicator.swift
//  Villa2
//
//  Created by nic Wanavit on 3/29/20.
//  Copyright © 2020 tenxor. All rights reserved.
//

// Credit Mycroft Canner
//https://stackoverflow.com/questions/58493192/is-there-a-standard-way-to-display-a-modal-view-indicator
//


import SwiftUI

struct ModalViewIndicator: View {
    var body: some View {
        GeometryReader{ g in
            HStack{
                Spacer()
                Image(systemName: "minus")
                    .resizable()
                    .font(Font.title.weight(.heavy))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .frame(width: g.size.width / 5, height: 10, alignment: .center)
                Spacer()
            }
//            .padding(4)
            .padding(.top, 8)
        }
        .frame( height: 21, alignment: .center)
    }
}

struct ModalViewIndicator_Previews: PreviewProvider {
    static var previews: some View {
        Text("ModalViewIndicator")
            .sheet(isPresented: .constant(true)) {
                VStack {
                    ModalViewIndicator()
                    GeometryReader { geometry in
                        Image(systemName: "sun.dust.fill")
                            .resizable()
                            .frame(
                                width: geometry.size.width/2,
                                height: geometry.size.width/2,
                                alignment: .center
                        )
                    }
                }
        }
    }
}
