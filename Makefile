# app.py should pass pylint
# optional, but recommended, build a simple integration test

setup:
	    # Create python virtualenv & source it
	    # source ~/.lyst/bin/activate
	    python3 -m venv ~/.mudano
			pip3 install -r requirements.txt



validate-circleci:
	    circleci config process .circleci/config.yml

run-circleci-local:
	    circleci local execute

lint:
	    # This is a linter for Python source code linter: https://www.pylint.org/
	    # This should be run from inside a virtualenv
	    pylint --disable=R,C,C0114,W0702,W0611 solution.py

all: setup lint
