test:
	g8 file://. --name=example --wiget=foo-bar --force -o tmp-test
	cd tmp-test && make build