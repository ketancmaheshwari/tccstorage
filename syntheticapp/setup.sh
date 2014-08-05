# ensure that this script is being sourced

if [[ $0 =~ .*bash ]] ; then 
  if [ ${BASH_VERSINFO[0]} -gt 2 -a "${BASH_SOURCE[0]}" = "${0}" ] ; then
    echo ERROR: script ${BASH_SOURCE[0]} must be executed as: source ${BASH_SOURCE[0]}
    exit 1
  fi
  # Lookup tutorial directory based on PATH entry for this script
  TUTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
elif [[ $ZSH_VERSION != "" ]] ; then 
  if [[  ! $- =~ .*i.* ]] ; then 
    echo ERROR: script $0 must be executed as: source $0
    return 1
  fi
  # Lookup tutorial directory based on PATH entry for this script
  TUTDIR="$( cd "$( dirname "$0" )" && /bin/pwd )"
fi

echo Swift version is $(swift -version)
rm -f swift.log

if [ _$(env which cleanup 2>/dev/null) != _$TUTDIR/bin/cleanup ]; then
  echo Adding $TUTDIR/bin:$TUTDIR/app: to front of PATH
  PATH=$TUTDIR/bin:$TUTDIR/app:$PATH
else
  echo Assuming $TUTDIR/bin:$TUTDIR/app: is already at front of PATH
fi

# Setting .swift files
if [ -e $HOME/.swift/swift.properties ]; then
  saveprop=$(mktemp $HOME/.swift/swift.properties.XXXX)
  echo Saving $HOME/.swift/swift.properties in $saveprop
  mv $HOME/.swift/swift.properties $saveprop
else
  mkdir -p $HOME/.swift
fi

cat >>$HOME/.swift/swift.properties <<END

# Properties for Swift Tutorial

sites.file=sites.xml
tc.file=apps

wrapperlog.always.transfer=false
sitedir.keep=false
file.gc.enabled=false
status.mode=provider

execution.retries=0
lazy.errors=false

use.provider.staging=true
provider.staging.pin.swiftfiles=false
use.wrapper.staging=false

END

return # TEMP: for localhost execuiton on Mac

# Start coaster-service and generate sites.xml
cd scs
start-coaster-service
for p in 04 05 06; do
  cp sites.xml ../part${p}/sites.xml
done
cd ..

return
