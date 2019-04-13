
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
 call dein#begin('~/.cache/dein')
 
call dein#add('~/.cache/dein')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('fuenor/qfixhowm')
call dein#add('jacoborus/tender.vim')
" #call dein#add('tomasr/molokai')
call dein#add('rakr/vim-one')
call dein#add('trusktr/seti.vim')
call dein#add('tpope/vim-markdown')
call dein#add('itchyny/lightline.vim') 
call dein#add('kien/ctrlp.vim')
call dein#add('gabrielelana/vim-markdown')
call dein#add('thinca/vim-ref')
call dein#add('othree/html5.vim')
call dein#add('tpope/vim-rails')
call dein#add('tpope/vim-surround')
call dein#add('jremmen/vim-ripgrep')
call dein#add('posva/vim-vue') 
call dein#add('pangloss/vim-javascript')
call dein#add('othree/yajs.vim')
call dein#add('mxw/vim-jsx')
call dein#add('cohama/lexima.vim')
call dein#add('vim-scripts/AutoComplPop')


if !has('nvim')
 call dein#add('roxma/nvim-yarp')
 call dein#add('roxma/vim-hug-neovim-rpc')
endif

call dein#add('fortes/vim-escuro')

call dein#end()
call dein#save_state()
endif
" 未インストールのプラグインをインストール
if dein#check_install()
    call dein#install()
endif


"----------------------------------------------------------
" 汎用的なキーアサイン
"----------------------------------------------------------
nnoremap <up> gk
noremap <C-h>   ^
noremap <C-j>   }
noremap <C-k>   {
noremap <C-l>   $
nnoremap ; :
nnoremap : ;

" バックスペースキーの有効化
set backspace=indent,eol,start

" カーソル行を強調表示しない
set nocursorline
" 挿入モードの時のみ、カーソル行をハイライトする
autocmd InsertEnter,InsertLeave * set cursorline!

" タブインデント関連
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

set incsearch
if has("migemo")
    set migemo
    set migemodict=$VIM\dict\migemo-dict
    nnoremap / g/
endif

" カレントバッファのパス展開ショートカット
cnoremap <expr> // getcmdtype()==':' ? expand('%:p:h').'/':'//'

set ignorecase


"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
" Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"" Vim起動時にneocompleteを有効にする
"let g:neocomplete#enable_at_startup = 1
"" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
"let g:neocomplete#enable_smart_case = 1
"" 3文字以上の単語に対して補完を有効にする
"let g:neocomplete#min_keyword_length = 3
"" 区切り文字まで補完する
"let g:neocomplete#enable_auto_delimiter = 1
"" 1文字目の入力から補完のポップアップを表示
"let g:neocomplete#auto_completion_start_length = 1
"" バックスペースで補完のポップアップを閉じる
"inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
"
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
"imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
"" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
"imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
"
"highlight Pmenu ctermbg=4
"highlight PmenuSel ctermbg=1
"highlight PMenuSbar ctermbg=4
"
"" 補完ウィンドウの設定
"set completeopt=menuone
"" 補完ウィンドウの設定
"set completeopt=menuone
"" rsenseでの自動補完機能を有効化
"let g:rsenseUseOmniFunc = 1
"" let g:rsenseHome = '/usr/local/lib/rsense-0.3'
"" auto-ctagsを使ってファイル保存時にtagsファイルを更新
"let g:auto_ctags = 1
"" 起動時に有効化
"let g:neocomplcache_enable_at_startup = 1
"" 大文字が入力されるまで大文字小文字の区別を無視する
"let g:neocomplcache_enable_smart_case = 1
"" _(アンダースコア)区切りの補完を有効化
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_enable_camel_case_completion  =  1
"" 最初の補完候補を選択状態にする
"let g:neocomplcache_enable_auto_select = 1
"" ポップアップメニューで表示される候補の数
"let g:neocomplcache_max_list = 20
"" シンタックスをキャッシュするときの最小文字長
"let g:neocomplcache_min_syntax_length = 3
"" 補完の設定
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"  endif
"  let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
"  if !exists('g:neocomplete#keyword_patterns')
"          let g:neocomplete#keyword_patterns = {}
"          endif
"          let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"------------------------------------
" unite.vim
"------------------------------------
""" unite.vi
""unite prefix key.
nnoremap [unite] <Nop>
nmap <C-u> [unite]
 
"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 150
 
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]<C-j> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]<C-b> :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]<C-r> :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]<C-u> :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]<C-c> :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]<C-a> :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
	"ESCでuniteを終了
	nmap <buffer> <ESC> <Plug>(unite_exit)
	"入力モードのときjjでノーマルモードに移動
	imap <buffer> jj <Plug>(unite_insert_leave)
	"入力モードのときctrl+wでバックスラッシュも削除
	imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
	"ctrl+jで縦に分割して開く
	nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	"ctrl+jで横に分割して開く
	nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
	"ctrl+oでその場所に開く
	nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
	inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}

syntax on

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる
set number " 行番号を表示
set cursorline " カーソルラインをハイライト
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>


" 行が折り返し表示されていた場合、行単位ではなく表示行単位でカーソルを移動する
nnoremap j gj
nnoremap k gk
nnoremap <down> gj

"TAGS
set tags=C:\develop\repo\pzl00\Assets\scripts\TAGS


" markdownのハイライトを有効にする
set syntax=markdown
au BufRead,BufNewFile *.md set filetype=markdown



" html.erb 有効にする
let g:html5_event_handler_attributes_complete = 1
let g:html5_rdfa_attributes_complete = 1
let g:html5_microdata_attributes_complete = 1
let g:html5_aria_attributes_complete = 1


" inident on
filetype plugin indent on

" for MOZC
"function! ImInActivate()
"      call system('fcitx-remote -c')
"endfunction
"inoremap <ESC> <ESC>:call ImInActivate()<CR><ESC>

autocmd FileType html :set filetype=xhtml
autocmd Filetype html :set omnifunc=htmlcomplete#CompleteTags
autocmd Filetype php  :set omnifunc=phpcomplete#CompletePHP

function InsertTabWrapper()
    if pumvisible()
        return "\<c-n>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k\|<\|/'
        return "\<tab>"
    else
        return "\<c-n>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return "\<c-n>"
"    else
"        return "\<c-x>\<c-o>"
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <C-tab> <c-x><c-o>



