
set shellslash

" set autochdir

let g:vimproc#download_windows_dll = 1

if &compatible
  set nocompatible
endif
set runtimepath+=$VIM/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('dein'))

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
call dein#add('tomasr/molokai')
call dein#add('rakr/vim-one')
call dein#add('trusktr/seti.vim')
call dein#add('tpope/vim-markdown')
call dein#add('itchyny/lightline.vim') " 情報を見やすく
call dein#add('thinca/vim-ref')


call dein#end()

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
"----------------------------------------------------------
" neocomplete・neosnippetの設定
"----------------------------------------------------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"


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

" キーマップリーダー
let QFixHowm_Key = 'g'

" howm_dirはファイルを保存したいディレクトリを設定
let howm_dir             = '~/howm/'
let howm_filename        = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding    = 'utf-8'
let howm_fileformat      = 'unix'


let g:ref_refe_cmd = 'c:/cygwin64/home/simazaki/bin/refe' "refeコマンドのパス
