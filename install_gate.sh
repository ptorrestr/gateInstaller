#!/bin/bash
##############################################################
#                                                            #
#***********           GATE INSTALLATION      ***************#
#                                                            #
# By Pablo Torres (pablo.torres.t@gmail.com)                 #
##############################################################

export BASEDIR=/home/pablo/src/gate #It must be changed!!! (Only absolute path allowed)

# You must have installed libXft-devel and libXpm-devel

#0. Install gcc and all development libraries. gcc-32 compatibility libraries may be needed 

#1. Code repositories
export CLHEPurl="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/"
export CLHEPversion="2.1.0.1"
export CLHEPurlFile="clhep-2.1.0.1.tgz"
export ROOTurl="ftp://root.cern.ch/root/"
export ROOTurlFile="root_v5.30.04.source.tar.gz"
export GEANT4url="http://geant4.cern.ch/support/source/"
export GEANT4urlFile="geant4.9.4.p02.tar.gz"
export GEANT4urlG4NDL="G4NDL.3.14.tar.gz"
export GEANT4urlG4EMLOW="G4EMLOW.6.19.tar.gz"
export GEANT4urlG4Photon="G4PhotonEvaporation.2.1.tar.gz"
export GEANT4urlG4Radio="G4RadioactiveDecay.3.3.tar.gz"
export GEANT4urlG4ABLA="G4ABLA.3.0.tar.gz"
export GEANT4urlG4NEUTRON="G4NEUTRONXS.1.0.tar.gz"
export GEANT4urlG4PII="G4PII.1.2.tar.gz"
export GEANT4urlReal="RealSurface.1.0.tar.gz"
export GATEurl="http://www.opengatecollaboration.org/sites/opengatecollaboration.org/files/gate_release/2011/03/"
export GATEurlFile="gate_v6_1_tar_gz_98524.gz"


#1. Setup enviorment 
echo "BASEDIR set to $BASEDIR"
export G4VERSION=9.4
echo "G4VERSION set to $G4VERSION"
export G4VERSIONPATH=p02
echo "G4VERSIONPATH set to $G4VERSIONPATH"
export G4INSTALL=$BASEDIR/geant4.$G4VERSION.$G4VERSIONPATH
echo "G4INSTALL set to $G4INSTALL"
export ROOTSYS=$BASEDIR/root
echo "ROOTSYS set to $ROOTSYS"
export CLHEPHOME=$BASEDIR/CLHEP
echo "CLHEPHOME set to $CLHEPHOME"
export clhep_dirs=$CLHEPHOME"/dir1/dir2"
export g4clhep_base_dir="/abs"
echo "G4CLHEP_BASE_DIR set to $G4CLHEP_BASE_DIR"
export GATEHOME=$BASEDIR/gate_v6.1
echo "GATEHOME set to $GATEHOME"
export OGLHOME=/usr
echo "OGLHOME set to $OGLHOME"
export G4DATA=$G4INSTALL/data
echo "G4DATA se to $G4DATA"
export G4LEDATA=$G4DATA/G4EMLOW6.2
echo "G4LEDATA set to $G4LEDATA"
export G4LEVELGAMMADATA=$G4DATA/PhotonEvaporation2.0
echo "G4LEVELGAMMADATA set to $G4LEVELGAMMADATA"
export G4RADIOACTIVEDATA=$G4DATA/RadioactiveDecay3.2
echo "G4RADIOACTIVEDATA set to $G4RADIOACTIVEDATA"
export NeutronHPCrossSections=$G4DATA/G4NDL3.13
echo "NeutronHPCrossSections set to $NeutronHPCrossSections"
export PATH=$PATH:$GATEHOME/bin/Linux-g++:$ROOTSYS/bin:$HOME/bin
echo "PATH set to $PATH"
export LD_LIBRARY_PATH=$GATEHOME/tmp/Linux-g++/gate_v6.0.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$G4INSTALL/libLinux-g++
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ROOTSYS/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CLHEPHOME/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$OGLHOME/lib
echo "LD_LIBRARY_PATH set to $LD_LIBRARY_PATH"
#export CPATH=$CPATH:$ROOTSYS/include
#echo "C_INCLUDE_PATH set to $CPATH"

##2 Download CLHEP
if [ ! -f $CLHEPurlFile ];
then 
    wget $CLHEPurl$CLHEPurlFile
    if [ ! -f $CLHEPurlFile ];
    then
        echo "Failed"
        exit
    else
        echo "Downloading $CLHEPurlFile ...OK"
    fi
else
    echo "Downloading $CLHEPurlFile ...OK"
fi
if [ ! -d $CLHEPHOME ];
then
    tar -xvf $CLHEPurlFile
    mv ./$CLHEPversion/CLHEP $CLHEPHOME
    if [ ! -d $CLHEPHOME ];
    then
        echo "Failed"
        exit
    else
        echo "expanding $CLHEPHOME ...OK"
    fi
else
    echo "expanding $CLHEPHOME ...OK"
fi

##3 CLHEP installation
cd $CLHEPHOME
if [ ! -f $CLHEPHOME/config.status ];
then 
    ./configure --prefix=$CLHEPHOME
    if [ ! -f $CLHEPHOME/config.status ];
    then
        echo "Failed"
        exit
    else
        echo "configuring $CLHEPHOME ...OK"
    fi
else
    echo "configuring $CLHEPHOME ...OK"
fi
if [ ! -d $CLHEPHOME/bin ];
then
    make
    make install
    if [ ! -d $CLHEPHOME/bin ];
    then
        echo "Failed"
        exit
    else
        echo "building $CLHEPHOME ...OK"
    fi
else
    echo "building $CLHEPHOME ...OK"
fi

##4 Download ROOT
cd $BASEDIR
if [ ! -f $ROOTurlFile ];
then
    wget $ROOTurl$ROOTurlFile
    if [ ! -f $ROOTurlFile ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $ROOTurlFile ...OK"
    fi
else
    echo "downloading $ROOTurlFile ...OK"
fi
if [ ! -d $ROOTSYS ];
then
    tar -xvf $ROOTurlFile
    if [ ! -d $ROOTSYS ];
    then
        echo "Failed"
        exit
    else
        echo "expanding $ROOTSYS ...OK"
    fi
else
    echo "expanding $ROOTSYS ...OK"
fi

##5 ROOT installation
cd $ROOTSYS
if [ ! -f $ROOTSYS/config.status ];
then 
    ./configure --prefix=$ROOTSYS --libdir=$ROOTSYS/lib --incdir=$ROOTSYS/include
    if [ ! -f $ROOTSYS/config.status ];
    then
        echo "Failed"
        exit
    else
        echo "configuring $ROOTSYS ...OK"
    fi
else
    echo "configuring $ROOTSYS ...OK"
fi

if [ ! -f $ROOTSYS/lib/libCore.so ];
then 
    make
    make install
    if [ ! -f $ROOTSYS/lib/libCore.so ];
    then
        echo "Failed"
        exit
    else
        echo "building $ROOTSYS ...OK"
    fi
else
    echo "building $ROOTSYS ...OK"
fi

##6 Download Geant4
cd $BASEDIR
if [ ! -f $GEANT4urlFile ];
then
    wget $GEANT4url$GEANT4urlFile
    if [ ! -f $GEANT4urlFile ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlFile ...OK"
    fi
else
    echo "downloading $GEANT4urlFile ...OK"
fi
if [ ! -d $G4INSTALL ];
then
    tar -xvf $GEANT4urlFile
    if [ ! -d $G4INSTALL ];
    then    
        echo "Failed"
        exit
    else
        echo "Expanding $GEANT4urlFile ...OK"
    fi
else
    echo "Expanding $GEANT4urlFile ...OK"
fi
if [ ! -f $GEANT4urlG4NDL ];
then
    wget $GEANT4url$GEANT4urlG4NDL
    if [ ! -f $GEANT4urlG4NDL ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4NDL ...OK"
    fi
else
    echo "downloading $GEANT4urlG4NDL ...OK"
fi
if [ ! -f $GEANT4urlG4EMLOW ];
then
    wget $GEANT4url$GEANT4urlG4EMLOW
    if [ ! -f $GEANT4urlG4EMLOW ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4EMLOW ...OK"
    fi
else
    echo "downloading $GEANT4urlG4EMLOW ...OK"
fi
if [ ! -f $GEANT4urlG4Photon ];
then
    wget $GEANT4url$GEANT4urlG4Photon
    if [ ! -f $GEANT4urlG4Photon ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4Photon ...OK"
    fi
else
    echo "downloading $GEANT4urlG4Photon ...OK"
fi
if [ ! -f $GEANT4urlG4Radio ];
then
    wget $GEANT4url$GEANT4urlG4Radio
    if [ ! -f $GEANT4urlG4Radio ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4Radio ...OK"
    fi
else
    echo "downloading $GEANT4urlG4Radio ...OK"
fi
if [ ! -f $GEANT4urlG4ABLA ];
then
    wget $GEANT4url$GEANT4urlG4ABLA
    if [ ! -f $GEANT4urlG4ABLA ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4ABLA ...OK"
    fi
else
    echo "downloading $GEANT4urlG4ABLA ...OK"
fi
if [ ! -f $GEANT4urlG4NEUTRON ];
then
    wget $GEANT4url$GEANT4urlG4NEUTRON
    if [ ! -f $GEANT4urlG4NEUTRON ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4NEUTRON ...OK"
    fi
else
    echo "downloading $GEANT4urlG4NEUTRON ...OK"
fi
if [ ! -f $GEANT4urlG4PII ];
then
    wget $GEANT4url$GEANT4urlG4PII
    if [ ! -f $GEANT4urlG4PII ];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlG4PII ...OK"
    fi
else
    echo "downloading $GEANT4urlG4PII ...OK"
fi
if [ ! -f $GEANT4urlReal ];
then
    wget $GEANT4url$GEANT4urlReal
    if [ ! -f $GEANT4urlReal];
    then
        echo "Failed"
        exit
    else
        echo "downloading $GEANT4urlReal ...OK"
    fi
else
    echo "downloading $GEANT4urlReal ...OK"
fi

if [ ! -d $G4DATA ];
then
    mkdir $G4DATA
    tar -xvf $GEANT4urlG4NDL -C $G4DATA
    tar -xvf $GEANT4urlG4EMLOW -C $G4DATA
    tar -xvf $GEANT4urlG4Photon -C $G4DATA
    tar -xvf $GEANT4urlG4Radio -C $G4DATA
    tar -xvf $GEANT4urlG4ABLA -C $G4DATA
    tar -xvf $GEANT4urlG4NEUTRON -C $G4DATA
    tar -xvf $GEANT4urlG4PII -C $G4DATA
    tar -xvf $GEANT4urlReal -C $G4DATA
else
    echo "Expanding data ...OK"
fi

#7 Geant4 Installation
if [ ! -f "$G4INSTALL/lib/Linux-g++/libG4run.so" ];
then
    cd $G4INSTALL
    sed 's/clhep_dirs=`find $g4clhep_base_dir*/echo "h" #line/' $G4INSTALL/Configure > $G4INSTALL/Configure2
    sh ./Configure2 -build -d -e
    ./Configure
    if [ ! -f "$G4INSTALL/lib/Linux-g++/libG4run.so" ];
    then
        echo "Failed"
        exit
    else
        echo "Building GEANT4 ...OK"
    fi
else
    echo "Building GEANT4 ...OK"
fi

#8 Download GATE
cd $BASEDIR
if [ ! -f $GATEurlFile ];
then
    wget $GATEurl$GATEurlFile
    if [ ! -f $GATEurlFile ];
    then
        echo "Failed"
        exit
    else
        echo  "Downloading GATE ...OK"
    fi
else
    echo "Downloading GATE ...OK"
fi
if [ ! -d $GATEHOME ];
then
    tar -xvf $GATEurlFile
    if [ ! -d $GATEHOME ];
    then
        echo "Failed"
        exit
    else
        echo "Expanding GATE ...OK"
    fi
else
    echo "Expanding GATE ...OK"
fi

#9 GATE Installation
cd $GATEHOME
if [ ! -f "$GATEHOME/bin/Linux-g++/Gate" ];
then
    source "./env_gate.sh"
    source $G4INSTALL/env.sh
    make
    if [ ! -f "$GATEHOME/bin/Linux-g++/Gate" ];
    then
        echo "Failed"
        exit
    else
        echo "Building GATE ...OK"
    fi
else
    echo "Building GATE ...OK"
fi
echo "INSTALLATION FINISHED"
#10 Clean
#cd $GATEHOME
#rm *.gz
#rm *.tgz
