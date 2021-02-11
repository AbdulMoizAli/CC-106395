const DFATable = {
    A: { a: 'B', b: 'C' },
    B: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    C: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    D: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    E: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    F: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    G: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    H: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    I: { a: 'D', b: 'E', 0: 'F', 1: 'G', _: 'H', '.': 'I', '@': 'J' },
    J: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
    K: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
    L: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
    M: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
    N: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
    O: { a: 'K', b: 'L', 0: 'M', 1: 'N', '.': 'O' },
};

const initialState = 'A',
    finalStates = ['K', 'L', 'M', 'N', 'O'];

const inputStrings = process.argv.slice(2);

for (const string of inputStrings) {
    const result = validateString(string);

    if (result) console.log(`'${string}' is a valid email.`);
    else console.log(`'${string}' is not a valid email.`);
}

function validateString(string) {
    let currentState = initialState;
    for (const char of string) {
        currentState = DFATable[currentState][char];
        if (!currentState) return false;
    }

    if (finalStates.includes(currentState)) return true;
    return false;
}
