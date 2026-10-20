class Hatcheck < Formula
  desc "Claude Code and Codex accounts on one computer, each kept apart"
  homepage "https://hatcheck.dev"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.4.0/hatcheck-aarch64-apple-darwin.tar.xz"
      sha256 "435ac457d32d2165f09ca9fe6a7b4f046007d0356df372558229773e0db197cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.4.0/hatcheck-x86_64-apple-darwin.tar.xz"
      sha256 "daedb607704b5f537efc2f12fc1d2192394f4fdca45cd636aef4408479b06273"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.4.0/hatcheck-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "71ea958e5b9eb6e37ae6f39cd97e36965a7314e72bfcec336ebe7167a872fb26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.4.0/hatcheck-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "13c086317b11f04db7d54e0c2970074ca37634f1372c9b63908d1deb63dc3b82"
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
