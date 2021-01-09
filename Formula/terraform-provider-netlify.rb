class TerraformProviderNetlify < Formula
  desc "Terraform Netlify provider."
  homepage "https://github.com/AegirHealth/terraform-provider-netlify"
  url "https://github.com/AegirHealth/terraform-provider-netlify/archive/v0.6.12.tar.gz"
  sha256 "eec50cbf920427b8372107fb9e64abf38ab653c807551563810ffff0a1b7d57b"
  version "0.6.12"
  license "MPL-2.0"

  depends_on "go" => :build

  depends_on "terraform"

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.version=#{version}"
    plugin_dir = HOMEBREW_PREFIX/"etc/terraform/providers/terraform.homebrew/homebrew/netlify/#{version}/darwin_amd64"
    FileUtils.mkdir_p plugin_dir
    plugin_dir.install_symlink bin/"terraform-provider-netlify"
  end

  def caveats
    <<~EOF
      To make Terraform aware of this plugin, add the following to your .terraformrc:

      provider_installation {
        filesystem_mirror {
          path    = "#{HOMEBREW_PREFIX}/etc/terraform/providers"
        }
      }

      And then you can reference the provider in your Terraform sources:

      terraform {
        required_providers {
          netlify = {
            source = "terraform.homebrew/homebrew/netlify"
            version = "#{version}"
          }
        }
      }
    EOF
  end

  test do
    assert_match(/This binary is a plugin/, shell_output("#{bin}/terraform-provider-netlify 2>&1", 1))
  end
end
