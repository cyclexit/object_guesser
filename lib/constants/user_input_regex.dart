// Input text alphabets: “a-z”, “A-Z”, “-”(dash), “ ”(space)
// NOTE: This regex is only used to validate the trimmed strings which are the
// strings without heading and trailing whitespaces.
final RegExp trimmedUserInputRegExp =
    RegExp(r"^$|^([a-zA-Z]+(\s|-))*[a-zA-Z]+$");

const String inputFormatHelpMsg =
    "A valid input should be an English word or phrase that only contain A-Z,"
    " a-z, whitespace and hyphen.";
