class DatapipeCli < Formula
  desc "A high-performance, streaming-first CLI for structured data"
  homepage "https://github.com/varuns2903/datapipe"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.1.1/datapipe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "68a44a2334aa2a41f699a57df74e47e0861b79cd46458ae1f87e30cc9c6bd62e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.1.1/datapipe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "985df6a1736c3474ab7674428bb85315aa66397a9ea1e0d5093dcb8d527358c6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.1.1/datapipe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4316894e19f78a8170ba5ff688445ff4284d3e9f98036cf59e17e5aa4d4f666c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.1.1/datapipe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5d12d4d88a20b634cb9e4b0b691bd3c8839bb0a05e85b661ff8ce21d74b6cd75"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "dp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "dp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "dp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "dp"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
