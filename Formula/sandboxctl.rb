class Sandboxctl < Formula
  desc "Automate creation and management of chroot-based sandboxes"
  homepage "https://github.com/jmmv/sandboxctl"
  url "https://github.com/jmmv/sandboxctl/archive/sandboxctl-1.1.tar.gz"
  sha256 "652efe8eaed011721145723631c4e5f973f822c34b22c133fbac47bb506bd038"

  depends_on "pkg-config" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "bindfs"
  depends_on "shtk"

  # Install into $HOMEBREW_PREFIX/bin instead of $HOMEBREW_PREFIX/sbin.
  patch :DATA

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

__END__
diff --git a/Makefile.am b/Makefile.am
--- a/Makefile.am
+++ b/Makefile.am
@@ -98,7 +98,7 @@ EXTRA_DIST += sandbox.subr.in
 sandbox.subr: $(srcdir)/sandbox.subr.in
        sources="$(srcdir)/sandbox.subr.in" target=sandbox.subr; $(BUILD_FILE)

-sbin_SCRIPTS = sandboxctl
+bin_SCRIPTS = sandboxctl
 CLEANFILES += sandboxctl
 EXTRA_DIST += sandboxctl.sh
 sandboxctl: $(srcdir)/sandboxctl.sh
