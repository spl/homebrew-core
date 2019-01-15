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

  # Running most sandboxctl commands requires root/sudo priviledge, so we just
  # test that the default configuration is as expected. There is currently no
  # way to get the version; otherwise, we would test that.
  test do
    expected_output_file = testpath/"expected"
    actual_output_file = testpath/"actual"
    expected_output_file.write <<~EOS
      DARWIN_NATIVE_WITH_XCODE = false
      SANDBOX_ROOT = /var/tmp/sandbox
      SANDBOX_TYPE = darwin-native
    EOS
    system "sh", "-c", "#{bin}/sandboxctl config > #{actual_output_file}"
    assert_equal expected_output_file.read, actual_output_file.read
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
