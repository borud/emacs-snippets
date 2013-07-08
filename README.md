# Snippet shortcuts

This is a very quick and dirty hack for managing my snippets.
Snippets, in this context, are short notes to keep track of what I am
doing and what I should be doing.

I use Markdown to format my snippets.

Put this file somewhere in your emacs load path and add this to your
.emacs file:

    (require 'snippets)
	(global-set-key (kbd "C-c S") 'snippet-visit-file)

## Markdown mode

You might want to add Markdown mode to your Emacs. Here is the
implementation I use http://jblevins.org/projects/markdown-mode/
