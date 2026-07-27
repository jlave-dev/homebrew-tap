# frozen_string_literal: true

# Homebrew formula for the Record macOS CLI.
class Record < Formula
  desc "Native macOS app capture and local transcription CLI"
  homepage "https://github.com/jlave-dev/record"
  url "https://github.com/jlave-dev/record/releases/download/v0.5.1/record-0.5.1-macos-arm64.tar.gz"
  version "0.5.1"
  sha256 "53ded490554ad413e467aa105e8eb8e97ab0b5b735c3628b87c5fb130f75faa1"
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
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/record --version").strip
    assert_match "record plugin install", shell_output("#{bin}/record --help")
  end
end
