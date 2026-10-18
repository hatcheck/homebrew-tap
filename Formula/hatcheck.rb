class Hatcheck < Formula
  desc "Claude Code and Codex accounts on one computer, each kept apart"
  homepage "https://hatcheck.dev"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.2.0/hatcheck-aarch64-apple-darwin.tar.xz"
      sha256 "719535fce46b8ecefccc6082bbb17248dcc029a2faad82835533b8a4a617f42f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.2.0/hatcheck-x86_64-apple-darwin.tar.xz"
      sha256 "0bb3009b0ee423ea0c6b1cef5476e27d27590f1a994db9f2e6f62ebb18db153d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.2.0/hatcheck-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ede7668f39f1c701c77068307246f0907aea62fc2eca3fbbd83771c832e244cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.2.0/hatcheck-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "001faa6735f0251659623cffb0316789c48fae29203f3e530f2cb8eff1ab7847"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
      bin.install "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
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
