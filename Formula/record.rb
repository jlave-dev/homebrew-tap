# frozen_string_literal: true

# Homebrew formula for the Record macOS CLI.
class Record < Formula
  desc "Native macOS app capture and local transcription CLI"
  homepage "https://github.com/jlave-dev/record"
  url "https://github.com/jlave-dev/record/releases/download/v0.5.3/record-0.5.3-macos-arm64.tar.gz"
  version "0.5.3"
  sha256 "6e693018dd02d6bb269c2443f509e96554c60319b20b7411263fb8561f0332dd"
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on macos: :sequoia
  depends_on "whisper-cpp"

  def install
    prefix.install Dir["*"]
  end

  def post_install
    system bin/"record", "plugin", "refresh"
  end

  def caveats
    <<~EOS
      First live use requests Screen & System Audio Recording permission and
      prepares an approximately 430 MB local model automatically:
        record live start --app zoom

      Optional agent adapters:
        record plugin install --codex
        record plugin install --claude

      Installed adapters refresh automatically during future Homebrew upgrades.
      Restart the agent app to load the new plugin version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/record --version").strip
    assert_match "record plugin <install", shell_output("#{bin}/record --help")
  end
end
