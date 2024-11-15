;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.

;; Ivy is too slow 2024
;; (package! swiper)
;; (package! ivy-posframe)
;; (package! ivy-yasnippet)
;; (package! ivy-rich)
;; (package! ivy-xref)

(package! imenu-anywhere)
(package! counsel-projectile)
(package! embark)
(package! consult)

;; Allow copy to system clipboard
(package! clipetty)


(package! treemacs)
(package! lsp-treemacs)
(package! treemacs-projectile)
(package! treemacs-icons-dired)
(package! treemacs-evil)
(package! treemacs-magit)

(package! perspective)
(package! helm-backup)
(package! avy)
(package! evil-terminal-cursor-changer)
(package! winum)
(package! origami)
(package! windresize)
(package! golden-ratio)
(package! xclip)
(package! drag-stuff)
(package! string-inflection)

;; coding
(package! highlight-indent-guides)
(package! projectile)
(package! devdocs)
(package! auto-complete)
(package! uuidgen)
(package! git-timemachine)
(package! company-mode)
(package! direnv)
(package! lua-mode)
;; rust needed ?
;; (package! rust-mode)
;; (package! rustic)
;; (package! flycheck-rust)
;; (package! slint-mode)

;; Tuto SP https://ebzzry.com/en/emacs-pairs/
(package! smartparens)
(package! restclient) ;; Rest Client like postman
(package! ob-restclient) ;; Org mode Rest Client like postman
(package! ace-link) ;; follow links

;; Llm
(package! ollama-copilot
  :recipe (:host github :repo "mberrueta/ollama-copilot"))

(package! gptel)
(package! elysium
  :recipe (:type git :host github :repo "lanceberge/elysium" :branch "main" :files ("*.el")))


;; Coding
(package! flycheck-eglot)
(package! yasnippet-snippets)
(package! eglot)
(package! tree-sitter)
(package! tree-sitter-langs)
(package! treesit-auto)
(package! web-mode) ;; edit web templates
(package! flycheck-posframe)
;;
;;HTML & CSS
;;
(package! com-css-sort)
(package! web-beautify)
(package! flymake-css)
(package! rainbow-mode)
(package! prettier-js) ; node and npm install -g prettier is required !

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Elixir
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package! elixir-mode)
(package! elixir-ts-mode)
(package! heex-ts-mode)
(package! mix)
(package! exunit)
(package! elixir-yasnippets)
(package! flycheck-credo)
(package! flycheck-mix)
(package! flycheck-elixir)
(package! inf-elixir)
(package! flymake-elixir)
(package! flymake-easy)
(package! emmet-mode)
;; (package! lsp-tailwindcss :recipe (:host github :repo "merrickluo/lsp-tailwindcss"))
(package! lsp-tailwindcss)
(package! eldoc)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package! evil-matchit)
(package! keycast)
(package! csv-mode)
(package! feature-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;   Python ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package! pytest)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; Dart + Flutter ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(package! dart-mode)
(package! lsp-mode)
(package! lsp-dart)
(package! flycheck)
(package! company)
(package! lsp-ui)
(package! hover)

;; https://emacs-lsp.github.io/lsp-dart/
;; (package! dart-mode)
;; ;; (package! lsp-mode)
;; (package! lsp-dart)
;; (package! lsp-treemacs)
;; (package! flycheck)
;; ;; (package! lsp-ui)
;; (package! hover)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; nix ;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(package! nix-mode)
