// Input text alphabets: “a-z”, “A-Z”, “-”(dash), “ ”(space)
// TODO: make input "   dog-" invalid
final RegExp userInputRegExp =
    RegExp(r"^$|\s|^[a-zA-Z\s]+[a-zA-Z-\s]*[a-zA-Z\s]$");

const String inputFormatHelpMsg =
    "A valid input should begin and end with a latin letter and only contain "
    "A-Z, a-z, whitespace and hyphen.";
