# The url, sha256, and version lines are rewritten automatically by
# scripts/release.sh in alikimovich/transcriber on every release.
class Transcriber < Formula
  desc "Record and transcribe conversations on-device (mic + system audio)"
  homepage "https://github.com/alikimovich/transcriber"
  url "https://github.com/alikimovich/transcriber/releases/download/v0.1.1/transcriber-v0.1.1-macos-arm64.zip"
  sha256 "669086a657da46dbdc431d1c2d788522e1d686d8b87b3923ac2a19de0f2bf3e2"
  version "0.1.1"
  license "MIT"

  depends_on :macos
  depends_on arch: :arm64

  def install
    bin.install "transcriber", "tcapture"
  end

  def caveats
    <<~EOS
      Requires macOS 26+ (transcription runs on-device via SpeechAnalyzer).

      Grant microphone access once, up front:
        tcapture request-mic
      macOS asks for Screen & System Audio Recording on the first capture.

      Recordings are saved to ~/Documents/Conversations by default;
      set TRANSCRIBER_CONVERSATIONS to change that.
    EOS
  end

  test do
    assert_match "transcriber v", shell_output("#{bin}/transcriber --version")
  end
end
