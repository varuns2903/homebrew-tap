class DatapipeCli < Formula
  desc "A high-performance, streaming-first CLI for structured data"
  homepage "https://github.com/varuns2903/datapipe"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.3.0/datapipe-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1ade82b53e00a35021cdb906ba671e8ffdfd6cb4d9fdefb754083e5f0945ad89"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.3.0/datapipe-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d2fc20dd5eb4e7f13fa4952dfd774a9780fa4bae657b480977e41f80dc735615"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.3.0/datapipe-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3c44dc54ebabe59d2bc7d772770aa6051400caaec80c55c74172159aa92c6f64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/varuns2903/datapipe/releases/download/v0.3.0/datapipe-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1cde172580af5bed5751fed66034a2ead6b11fa01725e118086b8c91e9d4e93a"
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
