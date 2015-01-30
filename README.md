# A scraper for 1980s DoF Tax Photos

This script will download all the photos the Department of Finance took in the
mid-80s.

The only pre-requisite to run should be a unix-like box (Linux or MacOSX should
work) and `curl`.

To use, clone the repo and run `./download.sh`:

`
$ git clone https://github.com/talos/nyc-dof-1980s-tax-photos.git
$ cd nyc-dof-1980s-tax-photos
$ ./download.sh
`

This will create a folder called `output`, and fill it with the photos.  The
photos are renamed from their original arbitrary name to one based off the BBL,
like `3-1772-0074.jpg`.  Beware, there are a lot -- at least 24GB worth.  It
will take a while to download them all.

### What's next

Since it takes a long time to download the images, the goal is to host them
somewhere else where they are properly indexed.  Each image currently has an
arbitrary URL, which makes it impossible for an API to do a lookup.
