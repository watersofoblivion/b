(lang dune 3.14)
(using menhir 2.0)

(name b)

(generate_opam_files true)

(source
 (github watersofoblivion/b))

(authors "Jonathan Bryant")

(maintainers "Jonathan Bryant")

(license LICENSE)

(documentation https://github.com/watersofoblivion/b)

(package
 (name b)
 (synopsis "An Impractical Introduction to Computer Science")
 (description "An Impractical Introduction to Computer Science")
 (depends
  ocaml
  dune
  menhir
  cmdliner
  ounit2
  bisect_ppx
  sedlex)
 (tags
  (assembly "lambda calculus")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
