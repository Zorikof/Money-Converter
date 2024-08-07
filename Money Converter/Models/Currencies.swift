import SwiftUI

struct CurrencyDataResponse: Codable {
    let data: [String: Double]
}

let currencyAbbreviations: [String: String] = [
        "SGD": "Сингапурский доллар",
        "BGN": "Болгарский лев",
        "AUD": "Австралийский доллар",
        "MXN": "Мексиканское песо",
        "DKK": "Датская крона",
        "THB": "Тайский бат",
        "INR": "Индийская рупия",
        "NZD": "Новозеландский доллар",
        "CHF": "Швейцарский франк",
        "SEK": "Шведская крона",
        "KRW": "Южнокорейская вона",
        "ISK": "Исландская крона",
        "BRL": "Бразильский реал",
        "PLN": "Польский злотый",
        "JPY": "Японская иена",
        "HUF": "Венгерский форинт",
        "HRK": "Хорватская куна",
        "PHP": "Филиппинское песо",
        "CZK": "Чешская крона",
        "NOK": "Норвежская крона",
        "CNY": "Китайский юань",
        "TRY": "Турецкая лира",
        "GBP": "Британский фунт стерлингов",
        "IDR": "Индонезийская рупия",
        "HKD": "Гонконгский доллар",
        "EUR": "Евро",
        "RON": "Румынский лей",
        "ZAR": "Южноафриканский рэнд",
        "MYR": "Малайзийский ринггит",
        "RUB": "Российский рубль",
        "ILS": "Новый израильский шекель",
        "CAD": "Канадский доллар"
]

func lowerCase(_ input: String) -> String {
    guard input.count == 3 else {
        return "Problem with func:lowerCase"
    }
    let lowercased = input.prefix(2).lowercased()
    return String(lowercased)
}
