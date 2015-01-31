# A scraper for 1980s DoF Tax Photos

This script will download a CSV mapping to access all photos the Department of
Finance took in the mid-80s by BBL.

The only pre-requisite to run should be a unix-like box (Linux or MacOSX should
work) and `curl`.

To use:

```
$ git clone https://github.com/talos/nyc-dof-1980s-tax-photos.git
$ cd nyc-dof-1980s-tax-photos
$ ./download.sh > mapping.csv 2>errors.log &
```

This will save a CSV called `mapping.csv` of the format:

```
borough,block,lot,filename
```

where the image for that row's BBL would be accessed at
`http://nycma.lunaimaging.com/MediaManager/srvr?mediafile=$filename`
substituting `$filename` for the value in the CSV.  For example, the row

```
2,2260,10,/Size3/RECORDSPHOTOUNITBRO-4-NA/1059/lvd_12_00021.jpg
```

is BBL 2/2260/10, whose image is at
[http://nycma.lunaimaging.com/MediaManager/srvr?mediafile=/Size3/RECORDSPHOTOUNITBRO-4-NA/1059/lvd_12_00021.jpg](http://nycma.lunaimaging.com/MediaManager/srvr?mediafile=/Size3/RECORDSPHOTOUNITBRO-4-NA/1059/lvd_12_00021.jpg)

### What's next

* If the mapping file is small enough, hosting it in the repo.
* An nginx.conf proxy configuration.
