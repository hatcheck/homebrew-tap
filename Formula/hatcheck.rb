class Hatcheck < Formula
  desc "Claude Code and Codex accounts on one computer, each kept apart"
  homepage "https://hatcheck.dev"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.3.0/hatcheck-aarch64-apple-darwin.tar.xz"
      sha256 "6cf590872b0014caf6cf959e71686fbe59c4bdd3f8c0f91623faed32d35d54d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.3.0/hatcheck-x86_64-apple-darwin.tar.xz"
      sha256 "51be0331a8648f4bd1e27e0247789196e68c59596bbc2b472a9f078b412810a7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.3.0/hatcheck-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "25df4ccfe936932795129477b2abec2c81a6f8289f8f3cf0fd3002b58d680e5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.3.0/hatcheck-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0f4559f2385f4414cc305623e79770abb0a7c6b226a9e0a6429d7f7edb710b64"
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
