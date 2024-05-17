setup-install:
	cd setup && pwd && bun install

setup: setup-install
	cd setup && bun index.ts