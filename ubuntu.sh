BootStrap: debootstrap
OSVersion: trusty
MirrorURL: http://us.archive.ubuntu.com/ubuntu/

%environment

%runscript
    exec echo -e "singularity [image] exec p3-* or rast-* to use... \n singularity [image] exec ls /usr/bin for list of programs"

%post
    echo "Hello from inside the container"
    sed -i 's/$/ universe/' /etc/apt/sources.list
    apt-get update
    apt-get upgrade

    #essential stuff
    apt -y install git sudo man vim build-essential wget unzip perl curl gdebi-core cpanminus

    mkdir /apps
    cd /apps

    wget https://github.com/PATRIC3/PATRIC-distribution/releases/download/1.018/patric-cli-1.018.deb
    sudo gdebi -n patric-cli-1.018.deb
    cpanm install Class::Accessor
    git clone https://github.com/SEEDtk/RASTtk.git
    cp -r -n RASTtk/lib/* /usr/share/patric-cli/deployment/lib/

#    sudo dpkg -i patric-cli-1.018.deb
#    sudo apt-get install -f

    DEFAULTBIN="/usr/local/bin"

    #cant use these anymore for hpc
    #create a directory to work in (that is, input data)
#    mkdir /work

    #mount dir for databases etc.
#    mkdir /db

    #mount dir for output writing
#    mkdir /out

    #so we dont get those stupid perl warnings
    locale-gen en_US.UTF-8

    #so we dont get those stupid warning on hpc/pbs
    mkdir /extra
    mkdir /xdisk
    mkdir /rsgrps
    
    #
    # Mount points for TACC directories
    #
    mkdir /home1
    mkdir /scratch
    mkdir /work

