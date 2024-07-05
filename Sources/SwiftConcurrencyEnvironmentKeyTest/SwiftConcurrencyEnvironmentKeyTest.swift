import SwiftUI

public struct Container<Content: View, Accessory: View>: View {

    @Environment(\.containerStyle) private var style

    private let content: Content
    private let accessory: Accessory

    public init(
        @ViewBuilder content: () -> Content,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.content = content()
        self.accessory = accessory()
    }

    public var body: some View {
        let configuration = ContainerStyleConfiguration(
            content: content,
            accessory: accessory)
        AnyView(style.resolve(configuration: configuration))
    }
}

// MARK: - Style

@MainActor
public protocol ContainerStyle: DynamicProperty {

    typealias Configuration = ContainerStyleConfiguration
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

private struct DefaultContainerStyle: ContainerStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.accessory
            configuration.content
        }
    }
}

// MARK: - Environment

private enum ContainerStyleKey: EnvironmentKey {
    static let defaultValue: any ContainerStyle = DefaultContainerStyle()
}

extension EnvironmentValues {

    fileprivate var containerStyle: any ContainerStyle {
        get { self[ContainerStyleKey.self] }
        set { self[ContainerStyleKey.self] = newValue }
    }
}

extension View {

    public func containerStyle(_ style: some ContainerStyle) -> some View {
        environment(\.containerStyle, style)
    }
}

extension Scene {

    public func containerStyle(_ style: some ContainerStyle) -> some Scene {
        environment(\.containerStyle, style)
    }
}

// MARK: - Configuration

@MainActor
public struct ContainerStyleConfiguration {

    public struct Content: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public struct Accessory: View {
        fileprivate let base: AnyView
        public var body: some View { base }
    }

    public let content: Content
    public let accessory: Accessory

    fileprivate init(
        content: some View,
        accessory: some View
    ) {
        self.content = Content(base: AnyView(content))
        self.accessory = Accessory(base: AnyView(accessory))
    }
}

// MARK: - Resolution

extension ContainerStyle {

    fileprivate func resolve(configuration: Configuration) -> some View {
        ResolvedContainerStyle(style: self, configuration: configuration)
    }
}

private struct ResolvedContainerStyle<Style: ContainerStyle>: View {

    let style: Style
    let configuration: Style.Configuration

    var body: some View {
        style.makeBody(configuration: configuration)
    }
}

// MARK: - Preview

#Preview {
    Container {
        Text("Content")
    } accessory: {
        Text("Accessory")
    }
    .padding()
}
