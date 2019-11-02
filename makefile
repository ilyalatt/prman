.RECIPEPREFIX +=
.PHONY: сдуфт restore activate_venv build uninstall_local install_local publish

clean:
  rm -r build dist *.egg-info || true

restore:
  if [ ! -d ".venv" ]; then PIPENV_VENV_IN_PROJECT=true pipenv sync; fi

activate_venv:
  . .venv/bin/activate

build: clean restore activate_venv
  pipenv lock -r > requirements.txt
  python3 setup.py --quiet sdist bdist_wheel
  rm requirements.txt

uninstall_local:
  pipx uninstall prman || true
  rm /home/user/.local/bin/prman || true

install_local: uninstall_local build
  pipx install --spec dist/*.tar.gz prman

publish: build
  pipenv run twine check dist/*
  pipenv run twine upload dist/*
