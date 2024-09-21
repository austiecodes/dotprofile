"Pluggins
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go'
call plug#end()

"Settings
set nu
set rnu
set expandtab     " 将制表符扩展为空格
set tabstop=4     " 设置一个制表符的空格数为 4
set shiftwidth=4    " 设置自动缩进的空格数为 4
set softtabstop=4   " 设置使用 Backspace 键删除一个制表符时，删除的空格数为 4
set clipboard=unnamed
set termguicolors

"General Keymaps
imap hj  <Esc>
nmap hj <Esc>
nmap <Space> :

"CocKeympas
source ~/.vim/.cocrc

"NerdTree Keymaps
nnoremap qw <C-w>w
nnoremap qe <C-w>l

"EOF
