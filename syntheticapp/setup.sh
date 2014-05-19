# ensure that this script is being sourced

if [ ${BASH_VERSINFO[0]} -gt 2 -a "${BASH_SOURCE[0]}" = "${0}" ] ; then
  echo ERROR: script ${BASH_SOURCE[0]} must be executed as: source ${BASH_SOURCE[0]}
  exit 1
fi

# Add Sun Java

module load java

# Add swift to PATH

TUTSWIFT=/home/users/p01537/swift-0.94.1-RC2
PATHSWIFT=$(which swift 2>/dev/null)

if [ _$PATHSWIFT = _$TUTSWIFT/bin/swift ]; then
  echo using Swift from $TUTSWIFT,already in PATH
elif [ -x $TUTSWIFT/bin/swift ]; then
  echo Using Swift from $TUTSWIFT, and adding to PATH
  PATH=$TUTSWIFT/bin:$PATH
elif [ _$PATHSWIFT != _ ]; then
  echo Using $PATHSWIFT from PATH
else
  echo ERROR: $TUTSWIFT not found and no swift in PATH. Tutorial will not function.
#  return
fi

echo Swift version is $(swift -version)
rm -f swift.log

# Setting scripts folder to the PATH env var.

TUTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ _$(which cleanup 2>/dev/null) != _$TUTDIR/bin/cleanup ]; then
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
provider.staging.pin.swiftfiles=true
use.wrapper.staging=false

END

cat >gen.sites <<END
<?xml version="1.0" encoding="UTF-8"?>
<config xmlns="http://swift-lang.org/sites">

  <pool handle="localhost">
    <execution provider="local" />
    <profile namespace="karajan" key="jobThrottle">0.04</profile>
    <profile namespace="karajan" key="initialScore">10000</profile>
    <workdirectory>/lus/scratch/$USER/swiftwork</workdirectory>
    <profile namespace="swift" key="stagingMethod">local</profile>
  </pool>

  <pool handle="raven">
    <execution provider="coaster" jobmanager="local:pbs" URL="local:01"/>
    <profile namespace="env"    key="PATHPREFIX">{env.PWD}/../app</profile>
    <profile namespace="globus" key="jobsPerNode">32</profile>
    <profile namespace="globus" key="queue">small</profile>
    <profile namespace="globus" key="providerAttributes">pbs.aprun;pbs.mpp;depth=32</profile>
    <profile namespace="globus" key="maxWallTime">00:01:00</profile>
    <profile namespace="globus" key="maxTime">3600</profile>
    <profile namespace="globus" key="lowOverAllocation">10000</profile>
    <profile namespace="globus" key="highOverAllocation">10000</profile>
    <profile namespace="globus" key="slots">2</profile>
    <profile namespace="globus" key="maxNodes">1</profile>
    <profile namespace="globus" key="nodeGranularity">1</profile>
    <profile namespace="karajan" key="jobThrottle">3.20</profile>
    <profile namespace="karajan" key="initialScore">10000</profile>
    <workdirectory>/lus/scratch/{env.USER}/swiftwork</workdirectory>
  </pool>

  <pool handle="ravenMED">
    <execution provider="coaster" jobmanager="local:pbs" URL="local:02"/>
    <profile namespace="env"    key="PATHPREFIX">{env.PWD}/../app</profile>
    <profile namespace="globus" key="queue">medium</profile>
    <profile namespace="globus" key="jobsPerNode">32</profile>
    <profile namespace="globus" key="providerAttributes">pbs.aprun;pbs.mpp;depth=32</profile>
    <profile namespace="globus" key="maxWallTime">00:01:00</profile>
    <profile namespace="globus" key="maxTime">3600</profile>
    <profile namespace="globus" key="lowOverAllocation">10000</profile>
    <profile namespace="globus" key="highOverAllocation">10000</profile>
    <profile namespace="globus" key="slots">1</profile>
    <profile namespace="globus" key="maxNodes">8</profile>
    <profile namespace="globus" key="nodeGranularity">8</profile>
    <profile namespace="karajan" key="jobThrottle">2.56</profile>
    <profile namespace="karajan" key="initialScore">10000</profile>
    <workdirectory>/lus/scratch/{env.USER}/swiftwork</workdirectory>
  </pool>

  <pool handle="ravenGPU">
    <execution provider="coaster" jobmanager="local:pbs" URL="local:03"/> 
    <profile namespace="env"    key="PATHPREFIX">{env.PWD}/../app</profile>
    <profile namespace="globus" key="queue">gpu_nodes</profile>
    <profile namespace="globus" key="jobsPerNode">16</profile>
    <profile namespace="globus" key="providerAttributes">pbs.aprun;pbs.mpp;depth=16</profile>
    <profile namespace="globus" key="maxWallTime">00:01:00</profile>
    <profile namespace="globus" key="maxTime">3600</profile>
    <profile namespace="globus" key="lowOverAllocation">10000</profile>
    <profile namespace="globus" key="highOverAllocation">10000</profile>
    <profile namespace="globus" key="slots">1</profile>
    <profile namespace="globus" key="maxNodes">6</profile>
    <profile namespace="globus" key="nodeGranularity">6</profile>
    <profile namespace="karajan" key="jobThrottle">5.00</profile>
    <profile namespace="karajan" key="initialScore">10000</profile>
    <workdirectory>/lus/scratch/{env.USER}/swiftwork</workdirectory>
  </pool>

</config>
END

for p in 04 05 06; do
  cp gen.sites part${p}/sites.xml
done

rm gen.sites

return

