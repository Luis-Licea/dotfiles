.ONESHELL:

venv:
	python3 -m venv venv
	ln -s venv/bin/activate activate
	source venv/bin/activate
	pip install --upgrade pip
	pip install --upgrade setuptools

install:
	SETUPTOOLS_ENABLE_FEATURES="legacy-editable" pip install --editable . --config-settings editable_mode=compat
