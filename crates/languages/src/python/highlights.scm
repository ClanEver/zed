(parameter (identifier) @variable)
(attribute attribute: (identifier) @property)
(type (identifier) @type)

; Module imports

(import_statement
  (dotted_name (identifier) @type))

(import_statement
  (aliased_import
    name: (dotted_name (identifier) @type)
    alias: (identifier) @type))

(import_from_statement
  (dotted_name (identifier) @type))

(import_from_statement
  (aliased_import
    name: (dotted_name (identifier) @type)
    alias: (identifier) @type))

; Function calls

(call
  function: (attribute attribute: (identifier) @function.method))
(call
  function: (identifier) @function)

; Function definitions

(function_definition
  name: (identifier) @function)

; Identifier naming conventions

((identifier) @type
 (#match? @type "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\\d_]*$"))

; Builtin functions

((call
  function: (identifier) @function.builtin)
 (#match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

; Literals

[
  (none)
  (true)
  (false)
] @constant.builtin

[
  (integer)
  (float)
] @number

; Self references

[
  (parameters (identifier) @variable.special)
  (attribute (identifier) @variable.special)
  (#match? @variable.special "^self|cls$")
]

(comment) @comment
(string) @string
(escape_sequence) @escape

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

; Docstrings.
(function_definition
  "async"?
  "def"
  name: (_)
  (parameters)?
  body: (block (expression_statement (string) @string.doc)))

(decorator
  "@" @function.decorator
  [
    (attribute
      object: (identifier) @function.decorator
      attribute: (identifier) @function.decorator
    ) @function.decorator
    (call
      function: [
        (identifier) @function.decorator
        (attribute
          object: (identifier) @function.decorator
          attribute: (identifier) @function.decorator
        ) @function.decorator
      ]
    ) @function.decorator
    (_) @function.decorator
  ]
)

(class_definition
  (argument_list [
    (identifier) @type
    (keyword_argument (identifier) @variable.parameter)
  ])
)

[
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "%"
  "%="
  "^"
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  "|"
  "~"
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
  "and"
  "in"
  "is"
  "not"
  "or"
  "is not"
  "not in"
] @keyword
