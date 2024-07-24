if exists('b:current_syntax')
  let old_syntax = b:current_syntax
  unlet b:current_syntax
endif

if search('^@preprocessor typescript') != 0
  syn include @typescript syntax/typescript.vim
  unlet b:current_syntax

  let code_language = "typescript"
else
  syn include @javascript syntax/javascript.vim
  unlet b:current_syntax

  let code_language = "javascript"
endif

syn match nearleyDirective  "^@builtin"
syn match nearleyDirective  "^@include"
syn match nearleyDirective  "^@preprocessor"
syn match nearleyDirective  "^@lexer"
syn match nearleyComment    "#.*"

syn match nearleyOperator "("
syn match nearleyOperator ")"
syn match nearleyOperator "->"
syn match nearleyOperator "|"
syn match nearleyOperator ":+"
syn match nearleyOperator ":\*"
syn match nearleyOperator ":?"

syn match nearleyNonTerminal "^[a-zA-Z0-9_?+]\+"
syn match nearleyNonTerminal "\(^@.*\)\@<![a-zA-Z0-9_?+]\+"

syn match nearleyToken "%[a-zA-Z0-9_?+]\+"

syn region nearleyString start=+"+ skip=+\\.+ end=+"+
syn region nearleyString start=+\[+ end=+]+

if code_language == "typescript"
  syn region nearleyCodeBlock matchgroup=nealeyCodeQuote start=+@{%+ end=+%}+ contains=@typescript
  syn region nearleyCodeBlockPost matchgroup=nealeyCodeQuote start=+{%+ end=+%}+ contains=@typescript
else
  syn region nearleyCodeBlock matchgroup=nealeyCodeQuote start=+@{%+ end=+%}+ contains=@javascript
  syn region nearleyCodeBlockPost matchgroup=nealeyCodeQuote start=+{%+ end=+%}+ contains=@javascript
endif

syn keyword nearleyBuiltin id joiner arrconcat nuller containedin=nearleyCodeBlockPost

hi def link nearleyDirective    Include
hi def link nearleyComment      Comment
hi def link nearleyOperator     Operator
hi def link nearleyBuiltin      Keyword
hi def link nearleyString       String
hi def link nearleyNonTerminal  Identifier
hi def link nearleyToken        Constant
hi def link nealeyCodeQuote     Operator

if exists('old_syntax')
  let b:current_syntax = old_syntax
endif
