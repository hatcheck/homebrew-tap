class Hatcheck < Formula
  desc "Claude Code, Codex, Antigravity CLI, Kimi Code CLI, ZCode, DeepSeek Harness, MiniMax Code, Qwen Code, GitHub Copilot CLI and OpenCode accounts on one computer, each kept apart"
  homepage "https://hatcheck.dev"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.7.1/hatcheck-aarch64-apple-darwin.tar.xz"
      sha256 "419b91056dc87e394ca68912976bf2edb37fd9a724a8b7ea4b19bc20814322ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.7.1/hatcheck-x86_64-apple-darwin.tar.xz"
      sha256 "b41d8e4bca946ec867db5e8d76c1563636a668e4e54cfaa8ee25a5359cb0fe72"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.7.1/hatcheck-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "04a5b27844699f4ee0b493c879f955af799b6a2f4b976fa854f8854f923019f9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hatcheck/hatcheck/releases/download/v0.7.1/hatcheck-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b9711be01a5116e38e1543d3534c2ddb08f83031854d1387335fa9e58f77e372"
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
      bin.install "ck", "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ck", "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ck", "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ck", "cl", "claude-k", "claude-z", "cx", "hat", "hatcheck"
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
