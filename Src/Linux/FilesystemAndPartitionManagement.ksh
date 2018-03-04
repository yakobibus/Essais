Howto expand an ext4 filesystem or patition size ?
- http://www.uptimemadeeasy.com/vmware/grow-an-ext4-filesystem-on-a-vmware-esxi-virtual-machine/

Use fdisk to Create a Partition

vgdisplay : list all of the volume groups on the system 

pvcreate <partition device path>, then we use 
vgextend to add it to the volume group

Example :
# pvcreate /dev/sda3
Physical volume "/dev/sda3" successfully created
# vgextend vg_elasticube /dev/sda3
Volume group "vg_elasticube" successfully extended

We can now see our new free space that we just added to the volume group:

# vgdisplay vg_elasticube | grep "Free"
  Free  PE / Size       25598 / 99.99 GiB
  
  Next, We extend the logical volume of the filesystem that we are expanding:

# lvextend -L+99G  /dev/vg_elasticube/lv_home
  Extending logical volume lv_home to 275.04 GiB
  Logical volume lv_home successfully resized

At this point, I like to unmount the filesystem so that there is no risk of messing up 
the filesystem while it is getting resized.
Typically, I use umount </filesystem-name>.  
If the filesystem is busy, you can comment out the filesystem 
in the /etc/fstab file and reboot the machine.


--------
Verify the Ext4 Filesystem Using e2fsck

Before we resize the filesystem, we check the filesystem first using e2fsck to verify it is healthy:

Example :
# e2fsck -f /dev/vg_elasticube/lv_home
e2fsck 1.41.12 (17-May-2010)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/vg_elasticube/lv_home: 8715/11542528 files (7.1% non-contiguous), 4488175/46147584 blocks


---

Resize the ext4 Filesystem

With the filesystem checked, it is all ready to resize using the resize2fs command:
example :
# resize2fs /dev/vg_elasticube/lv_home 275G
resize2fs 1.41.12 (17-May-2010)
Resizing the filesystem on /dev/vg_elasticube/lv_home to 72089600 (4k) blocks.
The filesystem on /dev/vg_elasticube/lv_home is now 72089600 blocks long.

Now that the filesystem is expanded, we check it again using e2fsck all over again:
# e2fsck -f /dev/vg_elasticube/lv_home
e2fsck 1.41.12 (17-May-2010)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/vg_elasticube/lv_home: 8715/18022400 files (7.1% non-contiguous), 4895774/72089600 blocks

Finally, we can remount our filesystem. When we do, note that it is now larger!

# mount /data
# df -h /data
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg_elasticube-lv_home
                      271G   15G  243G   6% /data
                      
-----------------------------------------------------------------------------------------------------

-  https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/storage_administration_guide/ext4grow



6.3. Redimensionner un système de fichiers Ext4
Avant d'agrandir un système de fichiers ex4, assurez-vous que la taille du périphérique bloc sous-jacent sera appropriée pour contenir le système de fichiers. Veuillez utiliser les méthodes de redimensionnement appropriées pour les périphériques bloc affectés.
Un système de fichiers ext4 peut être agrandi pendant son montage en utilisant la commande resize2fs :

# resize2fs /mount/device node

La commande resize2fs peut également réduire la taille d'un système de fichiers ext4 non monté :

# resize2fs /dev/device size

Lors du redimensionnement d'un système de fichiers ext4, l'utilitaire resize2fs lit la taille de bloc du système de fichiers en unités, à moins qu'un suffixe indiquant une unité particulière ne soit utilisé. Les suffixes suivants indiquent des unités particulières :

    s — secteurs de 512 octets sectors
    K — kilooctets
    M — mégaoctets
    G — gigaoctets 

Note
Le paramètre de taille est optionnel (et souvent redondant) lors de son expansion. resize2fs s'étend automatiquement pour remplir tout l'espace disponible du conteneur, habituellement un volume ou une partition logique.
Pour obtenir des informations supplémentaires sur le redimensionnement d'un système de fichiers ext4, veuillez consulter man resize2fs.



