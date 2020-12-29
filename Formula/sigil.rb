class Sigil < Formula
  desc "Standalone string interpolator and template processor"
  homepage "https://github.com/gliderlabs/sigil"
  version "0.6.0"
  url "https://github.com/gliderlabs/sigil/archive/v0.6.0.tar.gz"
  sha256 "9a68665b3a1bc497a3d618b5bebc926287ee8337d141e1b930c323f3e2900e9a"
  license "BSD-3-Clause"

  depends_on "go" => :build

  def install
    system "go", "get", "-d", "./cmd"
    system "go", "build", *std_go_args, "./cmd"
  end

  test do
    assert_equal "Foo is bar", shell_output("printf 'Foo is ${FOO:?}' | FOO=bar #{bin}/sigil -p")
  end
end
