# Install EasyPlate from its source-only release; publish in a separate tap.
class Easyplate < Formula
  desc "Local browser tool for sample plate layouts and annotations"
  homepage "https://github.com/FupaulHuang/EasyPlate"
  url "https://github.com/FupaulHuang/EasyPlate/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "f08907dba424c0e83faabf4cde904fc6087ae2ffad0efb4ab22edc9613230c70"
  license "MIT"

  depends_on "python@3.12"

  def install
    libexec.install "index.html", "app.js", "styles.css", "server.py", "README.md", "AGENTS.md", "LICENSE"
    (libexec/"easyplate_cli.py").write <<~PY
      from server import launch
      launch()
    PY

    python = Formula["python@3.12"].opt_bin/"python3.12"
    (bin/"easyplate").write <<~SH
      #!/bin/sh
      exec "#{python}" "#{libexec}/easyplate_cli.py" "$@"
    SH
    (bin/"easyplate").chmod 0755
  end

  test do
    assert_match "Start the local EasyPlate browser app", shell_output("#{bin}/easyplate --help")
  end
end
