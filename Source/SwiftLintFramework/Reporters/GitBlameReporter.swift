/// Reports violations in the format understood by `git blame -L`
public struct GitBlameReporter: Reporter {
    // MARK: - Reporter Conformance

    public static let identifier = "gitblame"
    public static let isRealtime = true

    public var description: String {
        return "Reports violations in the format git blame uses to highlight the latest authors"
    }

    public static func generateReport(_ violations: [StyleViolation]) -> String {
        return violations.map(generateForSingleViolation).joined(separator: "\n")
    }

    /// Generates a report for a single violation.
    ///
    /// - parameter violation: The violation to report.
    ///
    /// - returns: The report for a single violation.
    internal static func generateForSingleViolation(_ violation: StyleViolation) -> String {
        // {:line},{:line} {full_path_to_file}
        guard let line = violation.location.line,
              let relativeFile = violation.location.relativeFile else {
            return ""
        }
        return [
            "\(line),",
            "\(line) ",
            "\(relativeFile)"
        ].joined()
    }
}
