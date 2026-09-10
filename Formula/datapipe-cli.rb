class DatapipeCli < Formula
  desc "A high-performance, streaming-first CLI for structured data"
  homepage "https://github.com/varuns2903/datapipe"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.2.0/datapipe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d9e2b7d1dc8b6cbd59ad9d65f2d3f08139d5851fb4873760630b6c2393716ec8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.2.0/datapipe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "41432119a2d8bbecdb6385edd0d932081e95e3427638a560bbe2d85a09646593"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.2.0/datapipe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e5e46de5f6a988f160d002b15af802fe27ae83536a8e08113712e0dc503e190c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.2.0/datapipe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f8db02c4e6e39166a07d98caea569b9ffa36f3276f03a4984d75f8178bfc322e"
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
