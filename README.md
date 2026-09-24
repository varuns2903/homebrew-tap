# Homebrew Tap

Homebrew formulas for [varuns2903](https://github.com/varuns2903) projects.

| Formula | Project | Install |
|---|---|---|
| `dp` (datapipe-cli) | [datapipe](https://github.com/varuns2903/datapipe): streaming-first CLI for structured data | `brew install varuns2903/tap/dp` |
| `tetromino` | [tetromino](https://github.com/varuns2903/tetromino): falling-block puzzle game for the terminal (Linux) | `brew install varuns2903/tap/tetromino` |

Or tap once and use the short names:

```
brew tap varuns2903/tap
brew install tetromino
```

## Updating tetromino

After a new tetromino release `vX.Y.Z` is published, in
`Formula/tetromino.rb` change both `url`s and both `sha256`s
(the values are in the release's `SHA256SUMS.txt`), then push. The
`tetromino formula` workflow installs, tests and audits it.
