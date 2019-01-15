class Shtk < Formula
  desc "Application toolkit for POSIX-compliant shell scripts"
  homepage "https://github.com/jmmv/shtk"
  url "https://github.com/jmmv/shtk/archive/shtk-1.7.tar.gz"
  sha256 "2c279b0e83d028237dd8d277a3aa3eb24086d8370b950eecae3362ec1fdc65c1"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "autoreconf", "-i", "-s"
    system "./configure",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    #ENV.prepend_path "PATH", bin
    ENV.delete("PATH")
    #print ENV.to_h
    system prefix/"tests/shtk/shtk_test"
    #system "env", "-i", prefix/"tests/shtk/shtk_test"
  end
end
