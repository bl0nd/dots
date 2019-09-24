" Markup // >> SECTIONS
syn match sectionComment "^[\/\/ ]*\/\/" contained
hi link sectionComment Comment

syn match sectionHeader1 "^[\/\/ ]*\/\/ >> .*" contains=sectionComment containedin=ALL
hi def sectionHeader1 ctermfg=203 guifg=#ff5f5f
syn match sectionHeader2 "^[\/\/ ]*\/\/ >>>> .*" contains=sectionComment containedin=ALL
hi def sectionHeader2 ctermfg=214 guifg=#ffaf00
