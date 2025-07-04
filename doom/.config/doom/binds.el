;;; ../../dotfiles/doom/.config/doom/binds.el -*- lexical-binding: t; -*-

(map! :leader
      :prefix ("w" . "window")
      :desc "Split right"      "%"  #'split-window-right
      :desc "Split below"      "\"" #'split-window-below
      :desc "Delete window"    "x"  #'delete-window
      :desc "Switch window"    "o"  #'other-window
      :desc "Zoom window"      "z"  #'doom/window-maximize-buffer)
