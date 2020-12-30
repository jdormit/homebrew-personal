require "language/node"

class Obelix < Formula
  desc "A simple & reliable static site generator"
  homepage "https://obelix-site-builder.github.io/obelix"
  url "https://registry.npmjs.org/obelix/-/obelix-1.7.0.tgz"
  sha256 "4e7064fca1fc33ef598901f6561ec5f4254149e8590db7dd2830d1eb434fe7c4"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"obelix.json").write("{\"src\": \"src\", \"out\": \"out\"}")
    Dir.mkdir testpath/"src"
    (testpath/"src/index.md").write("---\n---\n# This is a test")
    system bin/"obelix", "build"
    File.open(testpath/"out/index.html") do |f|
      expected = <<-EOF.chomp
<html>
  <head></head>
  <body>
    <h1>This is a test</h1>
  </body>
</html>
EOF
      assert_match expected, f.read
    end
  end
end
