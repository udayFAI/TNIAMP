
enum APIEnvironment {
    case development
    case production
    case staging
    var scheme: String {
        switch self {
        case .development:
            return "http://183.82.2.55:8090/jhsmobileapi/mobile/configure/v1"
        case .production:
            return "http://183.82.2.55:8090/jhsmobileapi/mobile/configure/v1"
        case .staging:
            return "y18ft8td4k.execute-api.ap-south-1.amazonaws.com"
        }
    }
}

enum APIHost {
    case development
    case production
    case staging
   
    var host: String {
        switch self {
        case .development:
            return "/dev/api"
        case .production:
            return "/dev/api"
        case .staging:
            return "/dev/api/"
        }
    }
}

enum endPathPoints {
    static let otpgenerator = "otp/generate"
    static let otpValidate = "otp/validate"
    static let lookup = "lookup"
}
