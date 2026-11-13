# frozen_string_literal: true

# Homebrew formula for the Record macOS CLI.
class Record < Formula
  desc "Native macOS app capture and local transcription CLI"
  homepage "https://github.com/jlave-dev/record"
  url "https://github.com/jlave-dev/record/releases/download/v0.5.4/record-0.5.4-macos-arm64.tar.gz"
  version "0.5.4"
  sha256 "5d6a800dc1a193704b649af96ba85f3a95a841e06b9cd0c27a662cdcb1c8348f"
  license "MIT"

  depends_on arch: :arm64
  depends_on "ffmpeg"
  depends_on macos: :sequoia
  depends_on "whisper-cpp"

  def install
    prefix.install Dir["*"]
  end

  def caveats
    <<~EOS
      First live use requests Screen & System Audio Recording permission and
      prepares an approximately 430 MB local model automatically:
        record live start --app zoom

      Optional agent adapters:
        record plugin install --codex
        record plugin install --claude

      After upgrades, installed adapters refresh on the first runtime command.
      To refresh before starting an agent session, run:
        record plugin refresh
      Restart the agent app to load the new plugin version.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/record --version").strip
    assert_match "record plugin <install", shell_output("#{bin}/record --help")
    system libexec/"record/capture/capture", "--help"
    system libexec/"record/transcribe", "--help"
    system libexec/"record/live/live", "--help"
  end
end
