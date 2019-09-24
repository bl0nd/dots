" Markup # >> SECTIONS
syn match sectionComment "^[\" ]*\"" contained
hi link sectionComment Comment

syn match sectionHeader1 "^[\" ]*\" >> .*" contains=sectionComment containedin=ALL
hi def sectionHeader1 ctermfg=203 guifg=#ff5f5f
syn match sectionHeader2 "^[\" ]*\" >>> .*" contains=sectionComment containedin=ALL
hi def sectionHeader2 ctermfg=86 guifg=#5fffd7
syn match sectionHeader3 "^[\" ]*\" >>>> .*" contains=sectionComment containedin=ALL
hi def sectionHeader3 ctermfg=39 guifg=#00afff
