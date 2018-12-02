/*
 * ~/.jupyter/custom/custom.js
 * https://github.com/lambdalisue/jupyter-vim-binding#customization
 */

// Configure CodeMirror Keymap
require([
  'nbextensions/vim_binding/vim_binding',   // depends your installation
], function() {
  // Map jj to <Esc>
  CodeMirror.Vim.map("jk", "<Esc>", "insert");
  // Swap j/k and gj/gk (Note that <Plug> mappings)
  CodeMirror.Vim.map("j", "<Plug>(vim-binding-gj)", "normal");
  CodeMirror.Vim.map("k", "<Plug>(vim-binding-gk)", "normal");
  CodeMirror.Vim.map("gj", "<Plug>(vim-binding-j)", "normal");
  CodeMirror.Vim.map("gk", "<Plug>(vim-binding-k)", "normal");

});

// Configure Jupyter Keymap
require([
  'nbextensions/vim_binding/vim_binding',
  'base/js/namespace',
], function(vim_binding, ns) {
  // Add post callback
  vim_binding.on_ready_callbacks.push(function(){
    var km = ns.keyboard_manager;
    km.edit_shortcuts.remove_shortcut('cmdtrl-1');
    km.edit_shortcuts.remove_shortcut('cmdtrl-2');
    km.edit_shortcuts.remove_shortcut('cmdtrl-3');

    km.command_shortcuts.remove_shortcut('cmdtrl-1');
    km.command_shortcuts.remove_shortcut('cmdtrl-2');
    km.command_shortcuts.remove_shortcut('cmdtrl-3');

    // Update Help
    km.edit_shortcuts.events.trigger('rebuild.QuickHelp');
    km.command_shortcuts.events.trigger('rebuild.QuickHelp');
  });
});
