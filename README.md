# u-boot

This is a repository to help me keep track of changes I need to make to U-Boot to
set up the beagleboard for HUGnet.   This patch does the following:

1. Puts UART2 (/dev/ttyO1) onto the correct pins for our addon board.
2. Enables GPIO168 as an GPIO output
3. Enables bootz*
4. Enables raw ramdisk images*

 * These are to support the Ubuntu images that I am using for HUGnet on the Beagleboard.
 More information can be found at http://elinux.org/BeagleBoardUbuntu .

## Applying the patch

mux.patch is the patch file, created by git that can be used to make these changes in
other u-boot repositories.  It is just a small change, and it is unique to HUGnet, so
I didn't actually clone the whole u-boot repository.

## Download Binaries

Where you really want to go is:

http://downloads.hugllc.com/beagleboard/

You can download the latest binaries there.

## Filing Bug Reports
Bug reports can be filed on GitHub

## License
This is released under the GNU GPL V3.  You can find the complete text in the
LICENSE file, or at http://opensource.org/licenses/gpl-3.0.html