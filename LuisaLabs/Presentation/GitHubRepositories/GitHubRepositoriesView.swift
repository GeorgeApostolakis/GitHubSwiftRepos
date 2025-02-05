//
//  GitHubRepositoriesView.swift
//  LuisaLabs
//
//  Created by george.apostolakis on 02/02/25.
//

import SwiftUI

// MARK: - View
struct GitHubRepositoriesView: View {
    struct ViewState {
        let total: Int
        let showContents: Int
        let backValueDisabled: Bool
        let forwardValueDisabled: Bool
        let itens: [GitHubRepositoryResponse]
    }

    enum ScreenState {
        case content
        case loading
        case error(String)
    }

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .content: buildContentView()
            case .loading: ProgressView()
            case .error(let error): buildErrorView(error)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRepositories()
            }
        }
    }

    // MARK: - ContentView
    @ViewBuilder
    private func buildContentView() -> some View {
        VStack {
            buildHeader()
            if viewModel.repos.isEmpty {
                buildEmptyView()
            } else {
                buildList()
            }
        }
        .padding()
    }

    private func buildHeader() -> some View {
        HStack {
            Button {
                Task {
                    await viewModel.navigateBack()
                }
            } label: {
                Image(systemName: "arrowshape.backward")
            }
            .disabled(viewModel.backValueDisable)
            Text("\(viewModel.showContents) of \(viewModel.total)").padding(.horizontal)
            Button {
                Task {
                    await viewModel.navigateForward()
                }
            } label: {
                Image(systemName: "arrowshape.forward")
            }
            .disabled(viewModel.forwardValueDisable)
            Spacer()
        }
    }

    private func buildList() -> some View {
        List {
            ForEach(viewModel.repos) { repository in
                HStack {
                    VStack {
                        if let url = URL(string: repository.owner?.avatarUrl ?? "") {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else if phase.error != nil {
                                    Text("No image available")
                                } else {
                                    Image(systemName: "photo")
                                }
                            }
                            .frame(width: 30, height: 30)
                        } else {
                            Image(systemName: "photo")
                            .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    VStack {
                        HStack {
                            Text(repository.name ?? "name Not found")
                                .font(.title)
                            Spacer()
                        }
                        HStack {
                            Text(repository.description ?? "description not found")
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                }
                .listRowInsets(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                .listRowSeparator(.hidden)
                .padding(.vertical)
                .border(.black)
            }
        }
        .listStyle(.plain)
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
    }

    private func buildEmptyView() -> some View {
        VStack {
            Text("Ops")
                .font(.headline)
                .foregroundStyle(.red)
            Text("No results where found!")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func buildErrorView(_ errorString: String) -> some View {
        VStack {
            VStack {
                Image(systemName: "x.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
                    .padding(.bottom, 25)
                    .foregroundColor(.red)
                Text("Error: \(errorString)")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            Button {
                Task {
                    await viewModel.fetchRepositories()
                }
            } label: {
                Text("Tentar Novamente")
                    .font(.headline)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.black)

            }
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    GitHubRepositoriesView()
}
