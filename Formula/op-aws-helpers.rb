class OnePasswordCliRequirement < Requirement
  fatal true

  satisfy(build_env: false) { which "op" }

  def message
    <<~EOS
      1password-cli is required. Please install it with:
        brew install --cask 1password-cli
    EOS
  end
end

class OpAwsHelpers < Formula
  desc "Scripts to help use AWS with 1Password"
  homepage "https://gitlab.com/paulswartz/op-aws-helpers"
  url "https://gitlab.com/paulswartz/op-aws-helpers.git",
      revision: "41339077acb327853655ba5283d952a0bbced29f"
  version "0.1.0"
  license "Unlicense"

  depends_on "awscli"
  depends_on "jq"
  depends_on OnePasswordCliRequirement
  depends_on "python@3"

  def install
    bin.install "op-aws-credential-helper"
    bin.install "op-aws-password-rotate"
    bin.install "op-aws-rotate"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/op-aws-credential-helper 2>&1", 1)
  end
end
