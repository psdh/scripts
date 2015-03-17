fedpkg srpm
out=`ls *.src.rpm`
mock -r fedora-rawhide-x86_64 $out
if [ "$?" -eq 0 ]
then
    echo "[CHECKBUILD.SH] Ran Correctly with hardening! No problem with x86_64 architecture"
else
    spec=`ls *.spec`
    ./disableHardened $spec
    fedpkg srpm
    mock -r fedora-rawhide-x86_64 $out
    if [ "$?" -eq 0 ]
    then
        echo "[Checkbuild.sh] Ran correctly after disabling hardening of the build, this implies that this is build failure is due to hardening!! [[ToDo]]"
    else
        echo "[CHECKBUILD.SH] Does not run even after disabling hardening! Report to package owner"
fi
