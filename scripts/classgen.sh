
#!/bin/bash

class="$1"

# Safety check
if [ -z "$class" ]; then
  echo "Usage: $0 CLASS_NAME"
  exit 1
fi

uuid=$(uuidgen)
class_dir="$class"

# Create directories
mkdir -p "$class_dir"/{lab,lecture,homework,notes,resources}

# Create main .org file
cat <<EOF > "$class_dir/${class}.org"
#+title: ${class}
#+filetags: :$(echo "$class" | tr '[:upper:]' '[:lower:]'):class:
:PROPERTIES:
:ID: ${uuid}
:END:

* /${class}/
** properties
*** prof

*** textbook

*** website

*** location

** schedule

** homework

** notes

#+name: generate-note-links
#+begin_src emacs-lisp :results output raw :dir notes
(mapconcat
 (lambda (f)
   (let ((name (file-name-base f)))
     (format "- [[file:notes/%s][%s]]" (file-name-nondirectory f) name)))
 (directory-files "." t "\\.org$") "\n")
#+end_src

#+RESULTS: generate-note-links
EOF

# Append transclude line
echo "#+transclude: [[id:${uuid}][${class}]]" >> "$HOME/Documents/college/Fall2025/Fall2025.org"

echo "Structure for $class created with ID $uuid."

