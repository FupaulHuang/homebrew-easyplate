# Install EasyPlate from its source-only release; publish in a separate tap.
class Easyplate < Formula
  desc "Local browser tool for sample plate layouts and annotations"
  homepage "https://github.com/FupaulHuang/EasyPlate"
  url "https://github.com/FupaulHuang/EasyPlate/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "c3a67a98399f13e59054dc49c64b7c130a06806c00371fe9655539bce3ebdb60"
  license "MIT"

  depends_on "python@3.12"

  def install
    libexec.install "index.html", "app.js", "xlsx.js", "styles.css", "server.py", "updater.py", "README.md", "AGENTS.md", "LICENSE"
    (libexec/".easyplate-homebrew").write "#{HOMEBREW_PREFIX}/bin/brew\n"
    (libexec/"docs").install "docs/easyplate-browser.png"
    (libexec/"easyplate_cli.py").write <<~PY
      from server import launch
      launch()
    PY

    python = Formula["python@3.12"].opt_bin/"python3.12"
    (bin/"easyplate").write <<~SH
      #!/bin/sh
      python="${EASYPLATE_PYTHON:-#{python}}"
      if ! "$python" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 10) else 1)' >/dev/null 2>&1; then
        echo "EasyPlate requires Python 3.10 or newer. Set EASYPLATE_PYTHON to a supported Python executable." >&2
        exit 1
      fi
      exec "$python" "#{libexec}/easyplate_cli.py" "$@"
    SH
    (bin/"easyplate").chmod 0755
  end

  test do
    assert_match "Start the local EasyPlate browser app", shell_output("#{bin}/easyplate --help")
    assert_match "EasyPlate", shell_output("#{bin}/easyplate --version")
    assert_match "--check", shell_output("#{bin}/easyplate update --help")
  end
end
