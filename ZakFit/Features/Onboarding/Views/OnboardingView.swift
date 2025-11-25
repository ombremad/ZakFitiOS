//
//  OnboardingView.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var vm = LoginViewModel()
    
    // Get data from previous view and initialize this view's form data
    var userData: LoginFormData
    @State private var onboardingData = OnboardingFormData()
    
    // UX values
    @State private var showSexPicker = false
    @State private var showCalendar = false
    @FocusState private var focusedField: Field?
    enum Field { case height, weight }

    var body: some View {
        NavigationStack {
            TabView(selection: $vm.currentTab) {
                
                OnboardingCard {
                    Text("Configuration")
                        .font(.title)
                    Text("Pour commencer, nous allons avoir besoin de quelques informations de base pour configurer ton profil.")
                        .font(.smallTitle)
                    Text("Tu pourras changer ces informations à tout moment plus tard.")
                        .font(.smallTitle)
                }
                .tag(0)
                
                OnboardingCard {
                    Text("Ma morphologie")
                        .font(.title2)
                    
                    GlassEffectContainer {
                        VStack(spacing: 16) {
                            InteractiveBox(label: "Date de naissance", state: .onboarding) {
                                if let birthday = onboardingData.birthday {
                                    Text(birthday.formatted(.dateTime.day(.twoDigits)))
                                        .font(.cardDataSmall)
                                    Text("/")
                                        .font(.cardUnit)
                                    Text(birthday.formatted(.dateTime.month(.twoDigits)))
                                        .font(.cardDataSmall)
                                    Text("/")
                                        .font(.cardUnit)
                                    Text(birthday.formatted(.dateTime.year()))
                                        .font(.cardDataSmall)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showCalendar = true
                            }
                            
                            InteractiveBox(label: "Sexe", state: .onboarding) {
                                if let sex = onboardingData.sex {
                                    Text(sex ? "H" : "F")
                                        .font(.cardData)
                                }
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                showSexPicker = true
                            }
                                                        
                            InteractiveBox(label: "Taille", state: .onboarding) {
                                TextField("", value: $onboardingData.height, format: .number)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .focused($focusedField, equals: .height)
                                Text("cm")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                focusedField = .height
                            }
                            
                            InteractiveBox(label: "Poids", state: .onboarding) {
                                TextField("", value: $onboardingData.weight, format: .number)
                                    .font(.cardData)
                                    .multilineTextAlignment(.trailing)
                                    .keyboardType(.decimalPad)
                                    .focused($focusedField, equals: .weight)
                                Text("kg")
                                    .font(.cardUnit)
                                    .offset(y: -5)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                focusedField = .weight
                            }
                        }
                    }
                    
                    Text("Ces informations sont indispensables pour calculer les calories et macro-nutriments qui serviront de base à ton programme fitness et nutrition.")
                        .font(.callout)

                }
                .tag(1)
                
                OnboardingCard {
                    Text("là")
                }
                .tag(2)
                
                OnboardingCard {
                    Text("ici")
                }
                .tag(3)

                
                OnboardingCard {
                    VStack(alignment: .center, spacing: 48) {
                        Image(.welcome)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 215)
                        Button("Commencer") {}
                            .buttonStyle(CustomButtonStyle(state: .highlight))
                    }
                }
                .tag(4)
                
            }
            .navigationBarBackButtonHidden()
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .confirmationDialog("Sexe", isPresented: $showSexPicker) {
                Button("Homme") {
                    onboardingData.sex = true
                }
                Button("Femme") {
                    onboardingData.sex = false
                }
            }
            
            .sheet(isPresented: $showCalendar) {
                VStack {
                    DatePicker("", selection: Binding(
                        get: { onboardingData.birthday ?? Date() },
                        set: { onboardingData.birthday = $0 }
                    ), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding()
                    
                    Button("Valider") {
                        showCalendar = false
                    }
                    .buttonStyle(CustomButtonStyle(state: .validate))
                    .padding()
                }
                .presentationDetents([.fraction(0.6)])
            }

            .toolbar {
                if vm.currentTab < 4 {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Suivant", systemImage: "chevron.forward") {
                            withAnimation {
                                vm.currentTab += 1
                            }
                        }
                    }
                }
                if vm.currentTab > 0 {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Précédent", systemImage: "chevron.backward") {
                            withAnimation {
                                vm.currentTab -= 1
                            }
                        }
                    }
                }
            }
            
            .background {
                LinearGradient.accent
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    OnboardingView(userData: LoginFormData(
        firstName: "Anne",
        lastName: "Ferret",
        email: "my@email.com",
        password: ""
    ))
}
