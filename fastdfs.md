git clone https://github.com/happyfish100/libfastcommon.git
git clone https://github.com/happyfish100/fastdfs.git
git clone https://github.com/happyfish100/fastdht.git

yum -y installdb4 db4-utils db4-devel

# install libfastcommon
cd libfastcommon
./make.sh
./make.sh install
cd ..

# install fastdfs
cd fastdfs
./make.sh
./make.sh install
cd ..

# install fastdht
cd fastdht
./make.sh
./make.sh install
cd ..

# config files 

# init

mkdir /opt/fastdfs/pic/tracker -p
mkdir /opt/fastdfs/media/tracker -p

mkdir /opt/fastdfs/pic/store0/data -p
mkdir /opt/fastdfs/media/store0/data -p


pkill fdfs_trackerd
pkill fdfs_storaged 

fdfs_trackerd /etc/fdfs/tracker_pic.conf
fdfs_trackerd /etc/fdfs/tracker_media.conf

fdfs_storaged /etc/fdfs/storage_pic.conf
fdfs_storaged /etc/fdfs/storage_media.conf

fdhtd /etc/fdht/fdht_pic.conf
fdhtd /etc/fdht/fdht_media.conf


mkdir /opt/fastdht/pic -p
mkdir /opt/fastdht/media -p
