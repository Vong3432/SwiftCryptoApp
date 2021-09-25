//
//  HomeView.swift
//  SwiftCryptoApp
//
//  Created by Vong Nyuksoon on 17/09/2021.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                homeHeader
                
                SearchBarView(searchText: $vm.searchText)
                
                columsTitle
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading)) // move from the left
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing)) // move from the right
                }
                
                Spacer(minLength: 0)
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.light)
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10)) // change default list inset padding
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10)) // change default list inset padding
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columsTitle: some View {
        LazyVStack {
            GeometryReader { geometry in
                HStack {
                    Text("Coins")
                    Spacer()
                    if(showPortfolio) {
                        Text("Holding")
                    }
                    Text("Price")
                        .frame(width: geometry.size.width * 0.3, alignment: .trailing)
                }
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .padding(.horizontal)
                .frame(minHeight: 0)
            }
        }
    }
}
