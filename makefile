OCB = ocamlbuild
OCB_FLAGS = -use-ocamlfind -tags thread

test.native:test.ml
	$(OCB) $(OCB_FLAGS) $@

clean:
	$(OCB) -clean

.PHONY: clean
