# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Sandboxctl < Formula
  desc "Automates creation and management of chroot-based sandboxes"
  homepage "https://github.com/jmmv/sandboxctl"
  url "https://github.com/jmmv/sandboxctl/archive/sandboxctl-1.0.tar.gz"
  sha256 "6014e76d0d7f051f40ca84af716c3c4935e8eac52880c1d0fc5909e6fa18890b"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "bindfs"
  depends_on "shtk"

  def install
    system "autoreconf", "-i", "-s"
    system "./configure",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test sandboxctl`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
