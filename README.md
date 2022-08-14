# parallax-trade

# Submodule 관리

## 등록

```sh
git submodule add -b main git@github.com:modolee/parallax-trade-scraper.git submodules/scraper
```

## 삭제

```sh
git submodule deinit -f <path/to/submodule>

rm -rf .git/modules/<path/to/submodule>

git rm -f <path/to/submodule>
```
