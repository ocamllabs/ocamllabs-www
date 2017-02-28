.PHONY: all build

BUSHEL=docker run -it -v "$$(pwd -P):/app" -p 4000:4000 bushel

build:
	docker build -t bushel .

install:
	$(BUSHEL) bundle install --path vendor/bundle

serve:
	$(BUSHEL) bundle exec jekyll serve --host 0.0.0.0
