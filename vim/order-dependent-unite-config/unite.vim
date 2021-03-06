"===============================================================================
" Plugin source
"===============================================================================
"Shougo/unite.vim"

"===============================================================================
" Plugin Configurations
"===============================================================================
let g:unite_enable_start_insert = 1
let g:unite_split_rule = 'botright'
let g:unite_force_overwrite_statusline = 0
let g:unite_winheight = 15
let g:unite_source_history_yank_enable = 1
let g:unite_prompt = '──➤  '
let g:unite_update_time = 200
"let g:unite_source_rec_max_cache_files = 0 " The default is 20000
let g:unite_data_directory = $HOME.'/.vim/tmp/unite'
let g:unite_source_buffer_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%m-%d-%Y %H:%M:%S) '
let g:unite_source_rec_async_command= 'ag --nocolor --nogroup -g ""'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

"-------------------------------------------------------------------------------
" Settings that take effect only in unite buffers
"-------------------------------------------------------------------------------
autocmd FileType unite call s:unite_buffer_settings()

function! s:unite_buffer_settings()
  let b:SuperTabDisabled=1
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  imap <silent><buffer><expr> <C-x> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  noremap <silent><buffer><expr> <C-d> unite#do_action('delete')
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction

"===============================================================================
" Plugin Keymappings
"===============================================================================
" filter buffer for search term
nnoremap <Leader>sb :Unite line<CR>
nnoremap <Leader>y :Unite history/yank<CR><Esc>
nnoremap <Leader>sj :Unite jump<CR><Esc>
nnoremap <Leader>nu :<C-u>Unite neobundle/update -log -vertical -auto-quit<CR>
nnoremap <Leader>ff :Unite file file_rec/async -start-insert -buffer-name=files -winheight=18<CR>
nnoremap <Leader>b :Unite buffer<CR>

"===============================================================================
" Setup Unite Menus Options
"===============================================================================
let g:unite_source_menu_menus = {}
nnoremap [menu] <Nop>
" menu prefix key (for all Unite menus)
nmap <LocalLeader> [menu]
nnoremap <silent>[menu]u :Unite -silent -winheight=20 menu<CR><Esc>

"===============================================================================
" Menu for Custom Key
"===============================================================================
let g:unite_source_menu_menus.CustomKeyMaps = {'description': 'Custom mapped keyboard shortcuts                   |<SPACE>'}
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates = [
    \['➤ Buffer list                                                   <Leader>b', 'Unite buffer'],
    \['➤ Delete from buffer list in normal mode                        <C-d>', 'echo "Use <C-d> to delete a buffer"'],
    \['➤ Find files,                                                   <Leader>ff', 'normal <Leader>ff'],
    \['➤ Search jumps                                                  <Leader>sj', 'Unite jump'],
    \['➤ Search lines in the current buffer                            <Leader>sb', 'Unite line'],
    \['➤ Update Neobundle packages                                     <Leader>nu', 'normal <Leader>nu'],
    \['➤ Yank history                                                  <Leader>y', 'Unite history/yank'],
    \]
nnoremap <silent>[menu]<Space> :Unite -silent -winheight=17 -start-insert menu:CustomKeyMaps<CR>

"===============================================================================
" Plugin Keyboard Shortcuts
"===============================================================================
let g:unite_source_menu_menus.PluginKeyMaps = {'description': 'Keyboard shortcuts mapped by 3rd party plugins     |p'}
let g:unite_source_menu_menus.PluginKeyMaps.command_candidates = [
    \['➤ Replace in quickfix                                   :Qfreplace', 'echo "Use :Qfreplace"'],
    \]
nnoremap <silent>[menu]p :Unite -silent -winheight=17 -start-insert menu:PluginKeyMaps<CR>

"===============================================================================
" Vanilla Vim Keyboard Shortcuts
"===============================================================================
let g:unite_source_menu_menus.BuiltInKeyMaps = {'description': 'Lesser known/used builtin vim keybindings         |b'}
let g:unite_source_menu_menus.BuiltInKeyMaps.command_candidates = [
    \['➤ Show current char info                                        ga', 'normal ga'],
    \]
nnoremap <silent>[menu]b :Unite -silent -winheight=17 -start-insert menu:BuiltInKeyMaps<CR>
