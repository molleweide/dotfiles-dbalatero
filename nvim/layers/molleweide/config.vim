" remap ESC to jk
" works well w/qwerty and colemak
inoremap zm <esc>

"(v)im (r)eload
nmap <silent> ,vr :so %<CR>

" Mappings to move lines
" alt+j/k to move up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"(k)eybindings
nnoremap <silent> <Leader>knr :e ~/.dotfiles/notes/RNDM.md<CR>
nnoremap <silent> <Leader>knt :e ~/.dotfiles/notes/TODO.md<CR>
nnoremap <silent> <Leader>kv :e ~/.dotfiles/nvim/layers/molleweide/config.vim<CR>
nnoremap <silent> <Leader>kV :e ~/.dotfiles/notes/build-nvim.md<CR>
nnoremap <silent> <Leader>kt :e ~/.dotfiles/tmux.conf<CR>
nnoremap <silent> <Leader>kzz :e ~/.dotfiles/zshrc<CR>
nnoremap <silent> <Leader>kza :e ~/.dotfiles/zsh/custom/aliases.zsh<CR>
nnoremap <silent> <Leader>kze :e ~/.dotfiles/zsh/custom/exports.zsh<CR>
nnoremap <silent> <Leader>ky :e ~/.dotfiles/yabairc<CR>
nnoremap <silent> <Leader>ks :e ~/.dotfiles/skhdrc<CR>
nnoremap <silent> <Leader>kr :e ~/.dotfiles/installers/reaper<CR>
nnoremap <silent> <Leader>kr :e ~/.dotfiles/installers/reaper<CR>
" add command to oh my zsh
nmap <silent> <Leader>knr :e ~/.dotfiles/notes/reaper.md<CR>

" colemak layout insert mode
set keymap=INSERT_COLEMAK
set iminsert=1
set imsearch=0

" re-indent file
map <leader>i mzgg=G`z<CR>

" Tab through buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Close buffer
nmap <leader>x :bd<CR>


" TODO
"
" noremap <Space> <PageDown>
" noremap - <PageUp>

" " Easier copy/paste
" vnoremap p "_dP
" nmap <leader>y <Plug>SystemCopy
" xmap <leader>y <Plug>SystemCopy
" nmap <leader>p <Plug>SystemPaste
" nmap <leader>yy <Plug>SystemCopyLine
" tnoremap <Esc> <C-\><C-n>

" Delete current visual selection and dump in black hole buffer before pasting
" Used when you want to paste over something without it getting copied to
" Vim's default buffer
vnoremap <leader>p "_dP

" quicker save
nnoremap <leader>c :w<CR>

" space on control L
inoremap <C-l> <Space>
cnoremap <C-l> <Space>

" create custom command to close help
:command! H :helpc

" convert inner word to CAPITAL letters
nnoremap <leader>u viwUe
nnoremap <leader>U viwue

" " Move vertically by visual line
" nnoremap j gj
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk
" nnoremap gj j
" nnoremap gk k


" " === Emmet === "
" " let g:user_emmet_expandabbr_key = '<C-e>,'
" let g:user_emmet_expandabbr_key = '<C-e>,'
