class Tetromino < Formula
  desc "Falling-block puzzle game for the terminal"
  homepage "https://github.com/varuns2903/tetromino"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :linux

  # Prebuilt, fully static release binaries: nothing to compile, no runtime
  # dependencies. Linux only for now.
  on_linux do
    on_intel do
      url "https://github.com/varuns2903/tetromino/releases/download/v1.1.0/tetromino-1.1.0-linux-x86_64.tar.gz"
      sha256 "96d6881a24699be19e33318bb4488431505261533eb646c0dce8aa529ee9a946"
    end
    on_arm do
      url "https://github.com/varuns2903/tetromino/releases/download/v1.1.0/tetromino-1.1.0-linux-aarch64.tar.gz"
      sha256 "ed14f88a14f23365c6fcb81e1882e30ba77a222277a1332e94c349093521cd68"
    end
  end

  def install
    bin.install "tetromino"
    man6.install "tetromino.6"
  end

  test do
    assert_match "tetromino #{version}", shell_output("#{bin}/tetromino --version")
    # Refuses to start without a terminal, with a clear message and exit code 1.
    assert_match "must be a terminal", shell_output("#{bin}/tetromino </dev/null 2>&1", 1)
  end
end
