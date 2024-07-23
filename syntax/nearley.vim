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

syn match nearleyDirective '\v^\@builtin'
syn match nearleyDirective '\v^\@include'
syn match nearleyDirective '\v^\@preprocessor'
syn match nearleyDirective '\v^\@lexer'
syn match nearleyComment '\v#.*'

syn match nearleyOperator /\v\-\>/
syn match nearleyOperator /\v\|/
syn match nearleyOperator /\v\:\+/
syn match nearleyOperator /\v\:\*/
syn match nearleyOperator /\v\?/

syn match nearleyNonTerminal "\v^[a-zA-Z0-9_?+]+"

syn region nearleyString start=/\v"/ skip=/\v\\./ end=/\v"/
syn region nearleyString start="\[" end="]"

if code_language == "typescript"
  syn region nearleyCodeBlock matchgroup=quasiQuote start=+@{%+ end=+%}+ contains=@typescript
  syn region nearleyCodeBlockPost matchgroup=quasiQuote start=+{%+ end=+%}+ contains=@typescript
else
  syn region nearleyCodeBlock matchgroup=quasiQuote start=+@{%+ end=+%}+ contains=@javascript
  syn region nearleyCodeBlockPost matchgroup=quasiQuote start=+{%+ end=+%}+ contains=@javascript
endif

syn keyword nearleyBuiltin id joiner arrconcat nuller containedin=nearleyCodeBlockPost

hi def link quasiQuote          Special
hi def link nearleyDirective    Include
hi def link nearleyComment      Comment
hi def link nearleyOperator     Operator
hi def link nearleyBuiltin      Keyword
hi def link nearleyString       String
hi def link nearleyNonTerminal  Special

if exists('old_syntax')
  let b:current_syntax = old_syntax
endif
