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
    # The CLI and the helper's app bundle go to libexec together — the CLI
    # finds TranscriberCapture.app next to its own executable, and the bundle
    # (not a bare binary) is what makes macOS attribute the mic and
    # system-audio permission prompts to "Transcriber Capture" instead of the
    # user's terminal.
    libexec.install "transcriber", "TranscriberCapture.app"
    bin.write_exec_script libexec/"transcriber"
  end

  def caveats
    <<~EOS
      Requires macOS 26+ (transcription runs on-device via SpeechAnalyzer).

      Grant microphone access once, up front:
        transcriber request-mic
      macOS asks for Screen & System Audio Recording on the first capture;
      both prompts name "Transcriber Capture".

      Recordings are saved to ~/Documents/Conversations by default;
      set TRANSCRIBER_CONVERSATIONS to change that.
    EOS
  end

  test do
    assert_match "transcriber v", shell_output("#{bin}/transcriber --version")
  end
end
