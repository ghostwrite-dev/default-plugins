# Ghostwrite's default plugins

The plugins that come with [Ghostwrite](https://github.com/ghostwrite-dev/ghostwrite). Built in,
the editor has only plain text: the languages it knows, and PDFs and images, are these 13, each a
folder here. They come with the app, so there's nothing to install. [More](#more-plugins) are
installed from their own repositories.

| Plugin | What it adds |
| --- | --- |
| [`bash`](bash) | Bash and shell scripts: `.sh`, `.bash`, `.zsh`, `.bashrc`, `.zshrc` and `.profile` |
| [`c`](c) | C (`.c`, `.h`) and C++ (`.cc`, `.cpp`, `.cxx`, `.hpp`, `.hh`, `.hxx`), served by `clangd` |
| [`css`](css) | CSS: `.css` |
| [`go`](go) | Go: `.go`, served by `gopls` |
| [`image`](image) | PNG, JPEG, GIF (its first frame), WebP, BMP, TIFF and ICO, shown read-only in a tab |
| [`javascript`](javascript) | JavaScript (`.js`, `.mjs`, `.cjs`), JSX (`.jsx`), TypeScript (`.ts`, `.mts`, `.cts`) and TSX (`.tsx`), served by `typescript-language-server` |
| [`json`](json) | JSON: `.json` |
| [`markdown`](markdown) | Markdown: `.md`, `.markdown`, with code blocks colored as their language |
| [`pdf`](pdf) | PDFs: `.pdf`, their pages read-only in a tab, drawn with [hayro](https://github.com/LaurenzV/hayro) |
| [`python`](python) | Python: `.py`, `.pyi`, served by `basedpyright`, `pyright` or `pylsp`, started in the project's virtualenv |
| [`rust`](rust) | Rust: `.rs`, served by `rust-analyzer` |
| [`toml`](toml) | TOML: `.toml` and `Cargo.lock` |
| [`yaml`](yaml) | YAML: `.yaml`, `.yml` |

The languages with a tree-sitter grammar are colored by it, and all of them but Markdown have
text objects (`maf`, `]f` and the rest). A server is started only if it's on your PATH.

Most are no code at all: a `plugin.json`, a grammar compiled to WebAssembly, and its queries.
Python's has a little code too, which starts its servers in the project's virtualenv (`.venv` or
`venv`, or `$VIRTUAL_ENV`) and tells them its interpreter. PDFs' and images' read the project
only. Each says what it may reach under `"access"` in its `plugin.json`.

## More plugins

Others have a repository of their own, and aren't bundled: Ghostwrite installs them from GitHub
when you ask.

| Plugin | What it adds | Install |
| --- | --- | --- |
| [`typst`](https://github.com/ghostwrite-dev/typst) | Typst: `.typ`, compiled as you type, its pages in a tab (`:preview` or `space v`, and back), colored by Typst's own syntax, and served by `tinymist` | `:plugin install ghostwrite-dev/typst` |
| [`lean`](https://github.com/ghostwrite-dev/lean) | Lean 4: `.lean`, served by `lake serve`, with the goals in a panel beside the file (`space v` shows or hides it), colored by Lean's tokens, and its abbreviations (`\to` is `→`) | `:plugin install ghostwrite-dev/lean` |

[`catalog.json`](catalog.json) lists them, with the files each handles, so Ghostwrite can suggest
one when you open a file none of its plugins handles.

## Building

With [plugin-build](https://github.com/ghostwrite-dev/plugin-build)'s `build.sh` beside it:

```sh
git clone https://github.com/ghostwrite-dev/plugin-build ../plugin-build
rustup target add wasm32-wasip2
./build.sh            # or ./build.sh rust python
```

That makes `target/plugins/<name>` of each, which `:plugin install target/plugins/<name>` installs
in Ghostwrite: its code, if it has a `Cargo.toml`, built for WebAssembly; the grammars its
`grammars.txt` lists, downloaded and checked against their sha256; and the rest of its files as
they are. Code builds against [`ghostwrite-plugin-api`](https://github.com/ghostwrite-dev/ghostwrite/tree/plugin-api-v2.0.0/crates/plugin-api)
at the tag `plugin-api-v2.0.0`.

## Releases

A tag `v<X.Y.Z>` releases them all: the release has each one's folder as `<name>.zip`, and
`SHA256SUMS`. Each plugin's own version is the one in its `plugin.json`.

## License

MIT (see [LICENSE](LICENSE)), but for the text-object queries (`textobjects.scm`, and `textobjects-*.scm` in `c` and
`javascript`). Those are helix's (`runtime/queries/*/textobjects.scm` at
https://github.com/helix-editor/helix), with the files each inherits from put in it, and as such
are under the Mozilla Public License 2.0 (https://mozilla.org/MPL/2.0/): see [LICENSE-MPL](LICENSE-MPL).
The highlight and injection queries are the grammars' own, unchanged, under their licenses, from
the projects each `grammars.txt` names.
