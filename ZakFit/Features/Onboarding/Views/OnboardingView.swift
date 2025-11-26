//
//  OnboardingView.swift
//  ZakFit
//
//  Created by Anne Ferret on 25/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var vm = OnboardingViewModel()
    
    // Get data from previous view and initialize this view's form data
    var userData: LoginFormData
    @State private var onboardingData = OnboardingFormData()
    
    // UX values
    @State private var showCalendar = false
    @FocusState private var focusedField: Field?
    enum Field { case height, weight }
    
    // Steps
    private var stepWelcome: some View {
        OnboardingCard {
            Text("Configuration")
                .font(.title)
            Text("Pour commencer, nous allons avoir besoin de quelques informations de base pour configurer ton profil.")
                .font(.smallTitle)
            Text("Tu pourras changer ces informations à tout moment plus tard.")
                .font(.smallTitle)
        }
    }
    private var stepMorphology: some View {
        OnboardingCard {
            Text("Ma morphologie")
                .font(.title2)
            
            GlassEffectContainer {
                VStack(spacing: 16) {
                    DataBox(label: "Date de naissance", theme: .onboarding, icon: .calendar) {
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
                    
                    Menu {
                        Picker("Sexe", selection: $onboardingData.sex) {
                            Text("Homme").tag(true)
                            Text("Femme").tag(false)
                        }
                    } label: {
                        DataBox(label: "Sexe", theme: .onboarding, icon: .list) {
                            if let sex = onboardingData.sex {
                                Text(sex ? "H" : "F")
                                    .font(.cardData)
                            }
                        }
                    }
                    
                    DataBox(label: "Taille", theme: .onboarding, icon: .numbers) {
                        TextField("", value: $onboardingData.height, format: .number)
                            .font(.cardData)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .height)
                        Text("cm")
                            .font(.cardUnit)
                            .offset(y: -5)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        focusedField = .height
                    }
                    
                    DataBox(label: "Poids", theme: .onboarding, icon: .numbers) {
                        TextField("", value: $onboardingData.weight, format: .number)
                            .font(.cardData)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                            .submitLabel(.go)
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
    }
    private var stepRestrictions: some View {
        OnboardingCard {
            Text("Mes restrictions alimentaires")
                .font(.title2)
            Text("Je ne consomme pas de...")
                .font(.caption)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                ForEach(vm.restrictionTypesAvailable) { type in
                    Button(type.name) {
                        if onboardingData.restrictionTypes.contains(type) {
                            onboardingData.restrictionTypes.removeAll { $0.id == type.id }
                        } else {
                            onboardingData.restrictionTypes.append(type)
                        }
                    }
                    .buttonStyle(CustomButtonStyle(state: onboardingData.restrictionTypes.contains(type) ? .highlight : .normal))
                }
            }
            Text("Ces informations nous permettront de ne proposer que des aliments compatibles avec ton profil alimentaire.")
                .font(.callout)
        }
    }
    private var stepProgram: some View {
        OnboardingCard {
            Text("Mon programme")
                .font(.title2)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 16) {
                Button("Prise de masse") { vm.fitnessProgram = .gainMass }
                    .buttonStyle(CustomButtonStyle(state: vm.fitnessProgram == .gainMass ? .highlight : .normal, width: .full))
                Button("Maintien") { vm.fitnessProgram = .maintain }
                    .buttonStyle(CustomButtonStyle(state: vm.fitnessProgram == .maintain ? .highlight : .normal, width: .full))
                Button("Perte de poids") { vm.fitnessProgram = .loseWeight }
                    .buttonStyle(CustomButtonStyle(state: vm.fitnessProgram == .loseWeight ? .highlight : .normal, width: .full))
                Button("Personnalisé") { vm.fitnessProgram = .custom }
                    .buttonStyle(CustomButtonStyle(state: vm.fitnessProgram == .custom ? .highlight : .normal, width: .full))
            }
        }
        .onChange(of: vm.fitnessProgram) {
            vm.calculateRepartition()
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    
                    ZStack {
                        Group {
                            switch vm.currentStep {
                                case 0: stepProgram
//                                case 0: stepWelcome
                                case 1: stepMorphology
                                case 2: stepRestrictions
                                case 3: stepProgram
                                case 4: EmptyView()
                                default: EmptyView()
                            }
                        }
                        .transition(.push(from: .bottom))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.easeInOut(duration: 0.3), value: vm.currentStep)
                    
                    // Error message
                    if !vm.errorMessage.isEmpty {
                        Text(vm.errorMessage)
                            .foregroundStyle(Color.Label.secondary)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Progress indicator
                    HStack(spacing: 8) {
                        ForEach(0..<5) { index in
                            Capsule()
                                .fill(index <= vm.currentStep ? Color.App.background : Color.App.background.opacity(0.3))
                                .frame(height: 4)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)

                }
            }
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .task {
                await vm.fetchRestrictionTypes()
            }
            
            .sheet(isPresented: $showCalendar) {
                VStack {
                    DatePicker("", selection: Binding(
                        get: {
                            onboardingData.birthday ?? Calendar.current.date(
                                from: DateComponents(year: 2000, month: 1, day: 1)
                            )!
                        },
                        set: { onboardingData.birthday = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button("Valider") {
                        showCalendar = false
                    }
                    .buttonStyle(CustomButtonStyle(state: .validate))
                }
                .presentationDetents([.fraction(0.35)])
            }
            
            .toolbar {
                if vm.currentStep > 0 {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Précédent", systemImage: "chevron.backward") {
                            withAnimation {
                                vm.currentStep -= 1
                            }
                        }
                    }
                }
                if vm.currentStep < 4 {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Suivant", systemImage: "chevron.forward") {
                            withAnimation {
                                vm.nextStep(formData: onboardingData)
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
        password: "preview user"
    ))
}
