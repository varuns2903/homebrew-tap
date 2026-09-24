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
      url "https://github.com/varuns2903/tetromino/releases/download/v1.0.1/tetromino-1.0.1-linux-x86_64.tar.gz"
      sha256 "cc64db63a681471790fea360cce603099b118a5bf819113bdad0a0890d1c542b"
    end
    on_arm do
      url "https://github.com/varuns2903/tetromino/releases/download/v1.0.1/tetromino-1.0.1-linux-aarch64.tar.gz"
      sha256 "b3f4b8e5f155e0934cd8d660cb9269272428f134c1f1173811623a17e5dc7166"
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
