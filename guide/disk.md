# Disk and Filesystem

You should first partition your drive.  You should allocate at minimum 25GB of space for your new computer. For example, on Windows, go to Disk Management, right click on the disks and shrink them so that there's enough allocated disk space for the new operating system. There may be many reasons why you can't shrink, expand, or move around these already existing partitions, and to do that you'll need to use more powerful disk management toosl like DISKPART (especially to delete those annoying EFI partitions). If you are originally on Linux, then I don't know, but you would likely use Gparted, and you may have to modify these partitions from a bootable USB (just download a Ubuntu ISO, create a bootable USB drive with Rufus, and Ubuntu should have Gparted by default). 

You want to create a /boot, /swap, and / (root) partitions. There are 4 main ones: Ext4, btrfs, XFS, and OpenZFS. 


