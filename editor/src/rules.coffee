define ->
    Rules =
        "javascript":
            "functions": [
                /(?:var\s*)?(.+)\s*=\s*function\([^\)]*\)\s*\{[^\}]*\};?/m,
                /function\s*(.+)\([^\)]*\)\s*\{[^\}]*\};?/m
            ]
            "variables": null
        
    return Rules
