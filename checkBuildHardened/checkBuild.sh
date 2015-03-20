# The mock commands will be replaced by koji build commands, and when that is done, I'll directly start by putting the "%undefine ..." in the spec file and build. (that is I'll skip the initial build)

fedpkg srpm         # make src.rpm file
out=`ls *.src.rpm`
mock -r fedora-rawhide-x86_64 $out  # to be replaced by koji build
if [ "$?" -eq 0 ]
then
    echo "[CHECKBUILD.SH] Ran Correctly with hardening! No problem with x86_64 architecture"
else
    spec=`ls *.spec`
    python disableHardened.py $spec         # essentially puts the %undefine _hardened_build into the spec file
    fedpkg srpm
    mock -r fedora-rawhide-x86_64 $out      # to be replaced by koji build
    if [ "$?" -eq 0 ]
    then
        echo "[CHECKBUILD.SH] Ran correctly after disabling hardening of the build, this implies that this is build failure is due to hardening!! [[ToDo]]"
    else
        echo "[CHECKBUILD.SH] Does not run even after disabling hardening! Report to package owner"
    fi
fi
